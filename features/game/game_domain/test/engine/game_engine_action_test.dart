import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

import '../helpers/helpers.dart';

void main() {
  group(GameEngine, () {
    late GameEngine engine;

    setUp(() {
      engine = GameEngine(FakeRandomGenerator());
    });

    GameState endPreparation(
      Set<ActionCardId> cards, {
      Camp camp = const Camp(activists: 6, resources: 3),
      int support = 2,
      Forest? forest,
      Map<ActionCardId, CardSide> cardSides = const {},
    }) {
      var state = buildGameState(
        phase: GamePhase.preparation,
        camp: camp,
        support: support,
        forest: forest,
        cardSides: cardSides,
      );
      for (final card in cards) {
        state = engine.apply(state, AssignToCard(card));
      }
      return engine.apply(state, const EndPreparation());
    }

    group('$EndPreparation', () {
      test('AC-011: demo raises support by 2 and adds an activist', () {
        final state = endPreparation(
          {ActionCardId.demo},
          camp: const Camp(activists: 5, resources: 1),
          support: 0,
        );
        expect(state.support, equals(2));
        expect(state.activistsInPlay, equals(6));
        expect(state.camp, equals(const Camp(activists: 6, resources: 0)));
      });

      // (rule, card, side, activists gained, resources gained, support gained)
      const effects = [
        ('R-030', ActionCardId.sabotage, CardSide.a, 0, 0, 0),
        ('R-031', ActionCardId.legalTeam, CardSide.a, 0, 0, 0),
        ('R-036', ActionCardId.publicity, CardSide.a, 1, 0, 1),
        ('R-036', ActionCardId.publicity, CardSide.b, 1, 0, 1),
        ('R-037', ActionCardId.internet, CardSide.a, 0, 1, 1),
        ('R-037', ActionCardId.internet, CardSide.b, 0, 0, 1),
        ('R-038', ActionCardId.hardwareStore, CardSide.a, 0, 1, 0),
        ('R-038', ActionCardId.hardwareStore, CardSide.b, 0, 1, 0),
        ('R-039', ActionCardId.ruralCommune, CardSide.a, 0, 1, 0),
        ('R-039', ActionCardId.ruralCommune, CardSide.b, 0, 1, 0),
        ('R-040', ActionCardId.autonomousCentre, CardSide.a, 1, 1, 0),
        ('R-040', ActionCardId.autonomousCentre, CardSide.b, 0, 1, 0),
        ('R-041', ActionCardId.allies, CardSide.a, 1, 0, 0),
        ('R-041', ActionCardId.allies, CardSide.b, 1, 0, 0),
      ];
      for (final (rule, card, side, activists, resources, support) in effects) {
        test('$rule/R-085/R-086/R-087: $card on side ${side.name} '
            'gains $activists M, $resources R, $support U', () {
          const camp = Camp(activists: 6, resources: 3);
          final cost = card.cost(side);
          final state = endPreparation({card}, cardSides: {card: side});
          expect(
            state.camp,
            equals(
              Camp(
                activists: camp.activists + activists,
                resources: camp.resources - cost.resources + resources,
              ),
            ),
          );
          expect(state.support, equals(2 + support));
        });
      }

      test('R-084: effects of all assigned cards are executed', () {
        final state = endPreparation({
          ActionCardId.allies,
          ActionCardId.hardwareStore,
          ActionCardId.internet,
        });
        expect(state.camp, equals(const Camp(activists: 7, resources: 4)));
        expect(state.support, equals(3));
      });

      test('F-07: starts a new round log', () {
        final state = engine.apply(
          buildGameState(
            phase: GamePhase.preparation,
            log: [const RepressionCardDrawn(RepressionCard.raid)],
          ),
          const EndPreparation(),
        );
        expect(state.log, [isA<DiceRolled>()]);
      });

      test('R-084: assigned cards become activated for the round', () {
        final state = endPreparation({ActionCardId.sabotage});
        expect(state.activatedCards, equals({ActionCardId.sabotage}));
        expect(state.assignedCards, isEmpty);
      });

      test('R-002/Q8: activists beyond 11 in play are forfeited', () {
        final state = endPreparation({
          ActionCardId.allies,
        }, camp: const Camp(activists: 11, resources: 0));
        expect(state.activistsInPlay, equals(11));
      });

      test('R-004/Q8: resources beyond 8 are forfeited', () {
        final state = endPreparation({
          ActionCardId.hardwareStore,
        }, camp: const Camp(activists: 1, resources: 8));
        expect(state.camp.resources, equals(8));
      });

      test('R-008/Q10: support beyond 11 is forfeited', () {
        final state = endPreparation({ActionCardId.demo}, support: 10);
        expect(state.support, equals(11));
      });

      test('R-120: rolls the excavator dice without forest placements', () {
        final state = endPreparation({ActionCardId.allies});
        expect(state.log, [isA<DiceRolled>()]);
      });

      test('R-085: asks where to place activists of forest actions', () {
        final state = endPreparation({
          ActionCardId.blockade,
          ActionCardId.treeHouse,
          ActionCardId.civilDisobedience,
        });
        expect(state.phase, equals(GamePhase.action));
        expect(
          state.pendingDecision,
          equals(const PlaceActivistsDecision(activists: 3)),
        );
        expect(state.camp.activists, equals(3));
        expect(state.activistsInPlay, equals(6));
      });

      test('R-085/Q19: activists return to the camp '
          'when no forest card is free', () {
        final state = endPreparation({
          ActionCardId.blockade,
        }, forest: forestFilledWith(const ForestCard(hasSecurity: true)));
        expect(state.pendingDecision, isNull);
        expect(state.camp.activists, equals(6));
        expect(state.log, [isA<DiceRolled>()]);
      });

      test('throws $InvalidPhaseException outside the preparation phase', () {
        expect(
          () => engine.apply(buildGameState(), const EndPreparation()),
          throwsA(isA<InvalidPhaseException>()),
        );
      });
    });

    group('$PlaceActivistOnForest', () {
      GameState awaitingPlacement({int activists = 1, Forest? forest}) =>
          buildGameState(
            phase: GamePhase.action,
            camp: const Camp(activists: 2, resources: 0),
            forest: forest,
            pendingDecision: PlaceActivistsDecision(activists: activists),
          );

      test('AC-014: places the activist on the chosen forest card', () {
        final state = engine.apply(
          awaitingPlacement(),
          const PlaceActivistOnForest(column: 2, position: 3),
        );
        expect(state.forest.columns[2][3].hasActivist, isTrue);
        expect(state.camp.activists, equals(2));
      });

      test('R-120: rolls the excavator dice once all activists are placed', () {
        final state = engine.apply(
          awaitingPlacement(),
          const PlaceActivistOnForest(column: 2, position: 3),
        );
        expect(state.log, [isA<DiceRolled>()]);
      });

      test('R-085: keeps asking while activists remain to be placed', () {
        final state = engine.apply(
          awaitingPlacement(activists: 2),
          const PlaceActivistOnForest(column: 2, position: 3),
        );
        expect(
          state.pendingDecision,
          equals(const PlaceActivistsDecision(activists: 1)),
        );
        expect(state.phase, equals(GamePhase.action));
        expect(state.log, isEmpty);
      });

      test('Q19: returns remaining activists when no forest card is free', () {
        final state = engine.apply(
          awaitingPlacement(
            activists: 2,
            forest: forestFilledWith(
              const ForestCard(state: ForestCardState.removed),
            ).replace(column: 0, position: 0, card: const ForestCard()),
          ),
          const PlaceActivistOnForest(column: 0, position: 0),
        );
        expect(state.pendingDecision, isNull);
        expect(state.camp.activists, equals(3));
      });

      test('Q11: allows a clear-cut forest card', () {
        final state = engine.apply(
          awaitingPlacement(
            forest: forestWith({
              (1, 0): const ForestCard(state: ForestCardState.clearCut),
            }),
          ),
          const PlaceActivistOnForest(column: 1, position: 0),
        );
        expect(state.forest.columns[1][0].hasActivist, isTrue);
      });

      final forbiddenCards = {
        'Q11: a card with a security guard': const ForestCard(
          hasSecurity: true,
        ),
        'Q19: a card with an activist': const ForestCard(hasActivist: true),
        'a removed card': const ForestCard(state: ForestCardState.removed),
      };
      for (final MapEntry(key: description, value: card)
          in forbiddenCards.entries) {
        test('throws $InvalidForestCardException for $description', () {
          expect(
            () => engine.apply(
              awaitingPlacement(forest: forestWith({(0, 0): card})),
              const PlaceActivistOnForest(column: 0, position: 0),
            ),
            throwsA(isA<InvalidForestCardException>()),
          );
        });
      }

      for (final (column, position) in [(3, 0), (0, 4), (-1, 0), (0, -1)]) {
        test('throws $InvalidForestCardException for ($column, $position)', () {
          expect(
            () => engine.apply(
              awaitingPlacement(),
              PlaceActivistOnForest(column: column, position: position),
            ),
            throwsA(isA<InvalidForestCardException>()),
          );
        });
      }

      test('throws $InvalidDecisionException without a pending placement', () {
        expect(
          () => engine.apply(
            buildGameState(phase: GamePhase.action),
            const PlaceActivistOnForest(column: 0, position: 0),
          ),
          throwsA(isA<InvalidDecisionException>()),
        );
      });
    });
  });
}
