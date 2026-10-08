import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

import '../helpers/helpers.dart';

void main() {
  group(GameEngine, () {
    late GameEngine engine;

    setUp(() {
      engine = GameEngine(FakeRandomGenerator());
    });

    GameState preparation({
      Camp camp = const Camp(activists: 5, resources: 1),
      int support = 0,
      Map<ActionCardId, CardSide> cardSides = const {},
      List<RepressionCard> repressionInPlay = const [],
      Set<ActionCardId> assignedCards = const {},
    }) => buildGameState(
      phase: GamePhase.preparation,
      camp: camp,
      support: support,
      cardSides: cardSides,
      repressionInPlay: repressionInPlay,
      assignedCards: assignedCards,
    );

    group('$Continue', () {
      test('R-080/R-113: starts round 1 with the clock on 1 '
          'when no repression field is activated', () {
        final state = engine.apply(
          buildGameState(
            round: 0,
            camp: const Camp(activists: 1, resources: 2),
          ),
          const Continue(),
        );
        expect(state.phase, equals(GamePhase.preparation));
        expect(state.round, equals(1));
        expect(state.clock, equals(1));
      });

      test('throws $InvalidPhaseException in the preparation phase', () {
        expect(
          () => engine.apply(preparation(), const Continue()),
          throwsA(isA<InvalidPhaseException>()),
        );
      });
    });

    group('$AssignToCard', () {
      test('R-081: pays activists and resources from the camp', () {
        final state = engine.apply(
          preparation(),
          const AssignToCard(ActionCardId.blockade),
        );
        expect(state.camp, equals(const Camp(activists: 4, resources: 0)));
        expect(state.assignedCards, equals({ActionCardId.blockade}));
      });

      test('R-007/Q10: assigned activists stay in play', () {
        final state = engine.apply(
          preparation(),
          const AssignToCard(ActionCardId.demo),
        );
        expect(state.activistsInPlay, equals(5));
      });

      test('AC-010: blockade cannot be assigned without resources', () {
        expect(
          () => engine.apply(
            preparation(camp: const Camp(activists: 5, resources: 0)),
            const AssignToCard(ActionCardId.blockade),
          ),
          throwsA(isA<ConditionNotMetException>()),
        );
      });

      test('R-042: demo cannot be assigned with fewer than 5 activists', () {
        expect(
          () => engine.apply(
            preparation(camp: const Camp(activists: 4, resources: 1)),
            const AssignToCard(ActionCardId.demo),
          ),
          throwsA(isA<ConditionNotMetException>()),
        );
      });

      test(
        'AC-013: publicity on side B cannot be assigned with 1 activist',
        () {
          expect(
            () => engine.apply(
              preparation(
                camp: const Camp(activists: 1, resources: 1),
                cardSides: {ActionCardId.publicity: CardSide.b},
              ),
              const AssignToCard(ActionCardId.publicity),
            ),
            throwsA(isA<ConditionNotMetException>()),
          );
        },
      );

      test('R-036: publicity on side B costs 2 activists and 1 resource', () {
        final state = engine.apply(
          preparation(
            camp: const Camp(activists: 2, resources: 1),
            cardSides: {ActionCardId.publicity: CardSide.b},
          ),
          const AssignToCard(ActionCardId.publicity),
        );
        expect(state.camp, equals(const Camp(activists: 0, resources: 0)));
      });

      test('AC-016: civil disobedience cannot be assigned with support 0', () {
        expect(
          () => engine.apply(
            preparation(),
            const AssignToCard(ActionCardId.civilDisobedience),
          ),
          throwsA(isA<ConditionNotMetException>()),
        );
      });

      test('R-032: civil disobedience lowers support by 1', () {
        final state = engine.apply(
          preparation(support: 2),
          const AssignToCard(ActionCardId.civilDisobedience),
        );
        expect(state.support, equals(1));
        expect(state.camp.activists, equals(4));
      });

      test('R-043/Q5: a card cannot be assigned twice in a round', () {
        expect(
          () => engine.apply(
            preparation(assignedCards: {ActionCardId.sabotage}),
            const AssignToCard(ActionCardId.sabotage),
          ),
          throwsA(isA<CardAlreadyAssignedException>()),
        );
      });

      const blockingCards = {
        RepressionCard.internetSurveillance: ('R-062', ActionCardId.internet),
        RepressionCard.assemblyBan: ('AC-012/R-063', ActionCardId.demo),
        RepressionCard.surveillance: ('R-064', ActionCardId.hardwareStore),
        RepressionCard.courtOrder: ('R-065/Q1', ActionCardId.autonomousCentre),
      };
      for (final MapEntry(key: repression, value: (rule, card))
          in blockingCards.entries) {
        test('$rule/R-044/R-083: $card cannot be assigned while $repression '
            'is in play', () {
          expect(
            () => engine.apply(
              preparation(repressionInPlay: [repression]),
              AssignToCard(card),
            ),
            throwsA(isA<CardBlockedException>()),
          );
        });
      }

      test('R-083: an immediate repression card blocks nothing', () {
        expect(
          () => engine.apply(
            preparation(repressionInPlay: [RepressionCard.raid]),
            const AssignToCard(ActionCardId.demo),
          ),
          returnsNormally,
        );
      });

      test('throws $InvalidPhaseException outside the preparation phase', () {
        expect(
          () => engine.apply(
            buildGameState(),
            const AssignToCard(ActionCardId.sabotage),
          ),
          throwsA(isA<InvalidPhaseException>()),
        );
      });
    });

    group('$UndoAssignment', () {
      test('AC-015/R-082: restores activists, resources and support', () {
        final before = preparation(
          camp: const Camp(activists: 6, resources: 1),
          support: 2,
        );
        final assigned = engine.apply(
          engine.apply(
            before,
            const AssignToCard(ActionCardId.civilDisobedience),
          ),
          const AssignToCard(ActionCardId.demo),
        );
        final undone = engine.apply(
          engine.apply(
            assigned,
            const UndoAssignment(ActionCardId.civilDisobedience),
          ),
          const UndoAssignment(ActionCardId.demo),
        );
        expect(undone, equals(before));
      });

      test('throws $CardNotAssignedException for an unassigned card', () {
        expect(
          () => engine.apply(
            preparation(),
            const UndoAssignment(ActionCardId.sabotage),
          ),
          throwsA(isA<CardNotAssignedException>()),
        );
      });

      test('throws $InvalidPhaseException outside the preparation phase', () {
        expect(
          () => engine.apply(
            buildGameState(assignedCards: {ActionCardId.sabotage}),
            const UndoAssignment(ActionCardId.sabotage),
          ),
          throwsA(isA<InvalidPhaseException>()),
        );
      });
    });
  });

  group('activistsInPlay', () {
    test('R-007/Q10: counts activists in the camp and on the forest', () {
      expect(
        buildGameState(
          camp: const Camp(activists: 2, resources: 0),
          forest: forestWithActivist(),
        ).activistsInPlay,
        equals(3),
      );
    });
  });
}
