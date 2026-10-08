import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

import '../helpers/helpers.dart';

void main() {
  group(GameEngine, () {
    /// Activists in the camp that activate [fields] repression fields
    /// while support is 0 (fields 2, middle 4, middle 6).
    Camp campActivating(int fields, {int resources = 0}) =>
        Camp(activists: const [0, 2, 4, 6][fields], resources: resources);

    /// Starts the repression phase after the excavation with scripted
    /// random values.
    GameState repress({
      required List<RepressionCard> deck,
      int fields = 1,
      Camp? camp,
      int support = 0,
      Forest? forest,
      Map<ActionCardId, CardSide> cardSides = const {},
      List<RepressionCard> repressionInPlay = const [],
      Set<ActionCardId> activatedCards = const {},
      List<int> random = const [],
    }) => GameEngine(FakeRandomGenerator(random)).apply(
      buildGameState(
        phase: GamePhase.excavation,
        pendingDecision: const ReturnActivistsDecision(),
        camp: camp ?? campActivating(fields),
        support: support,
        forest: forest,
        cardSides: cardSides,
        repressionDeck: deck,
        repressionInPlay: repressionInPlay,
        activatedCards: activatedCards,
      ),
      const Continue(),
    );

    GameState applyTo(
      GameState state,
      GameCommand command, {
      List<int> random = const [],
    }) => GameEngine(FakeRandomGenerator(random)).apply(state, command);

    group('repression phase', () {
      test('R-092/R-093: draws one card per activated field', () {
        final state = repress(
          deck: [RepressionCard.surveillance, RepressionCard.assemblyBan],
          fields: 2,
        );
        expect(
          state.repressionInPlay,
          equals([RepressionCard.surveillance, RepressionCard.assemblyBan]),
        );
        expect(state.repressionDeck, isEmpty);
      });

      test('R-067: draws the cards from the top of the deck', () {
        final state = repress(
          deck: [RepressionCard.surveillance, RepressionCard.assemblyBan],
        );
        expect(state.repressionInPlay, equals([RepressionCard.surveillance]));
        expect(state.repressionDeck, equals([RepressionCard.assemblyBan]));
      });

      test('AC-030: legal team reduces 3 draws to 2', () {
        final state = repress(
          deck: List.filled(3, RepressionCard.surveillance),
          fields: 3,
          activatedCards: {ActionCardId.legalTeam},
        );
        expect(state.repressionInPlay, hasLength(2));
      });

      test('R-092: legal team does not reduce below 0 draws', () {
        final state = repress(
          deck: [RepressionCard.surveillance],
          fields: 0,
          activatedCards: {ActionCardId.legalTeam},
        );
        expect(state.repressionInPlay, isEmpty);
      });

      test('R-068/Q15: stops drawing when the deck is empty', () {
        final state = repress(deck: [], fields: 2);
        expect(state.repressionInPlay, isEmpty);
        expect(state.phase, equals(GamePhase.preparation));
      });

      test('AC-034/R-091: cards of the previous round are shuffled back '
          'and their blockade ends', () {
        final state = repress(
          deck: [RepressionCard.surveillance],
          fields: 0,
          repressionInPlay: [RepressionCard.internetSurveillance],
        );
        expect(state.repressionInPlay, isEmpty);
        expect(
          state.repressionDeck,
          unorderedEquals([
            RepressionCard.surveillance,
            RepressionCard.internetSurveillance,
          ]),
        );
        expect(state.isBlocked(ActionCardId.internet), isFalse);
      });

      test('logs every drawn card (F-07)', () {
        final state = repress(deck: [RepressionCard.surveillance]);
        expect(
          state.log,
          equals([const RepressionCardDrawn(RepressionCard.surveillance)]),
        );
      });

      test('R-080: starts the next round afterwards', () {
        final state = repress(
          deck: [RepressionCard.surveillance],
          activatedCards: {ActionCardId.sabotage},
        );
        expect(state.round, equals(2));
        expect(state.clock, equals(2));
        expect(state.phase, equals(GamePhase.preparation));
        expect(state.activatedCards, isEmpty);
      });
    });

    group('blocking cards', () {
      test('R-062–R-065/Q12: block their action card in the next round', () {
        final state = repress(deck: [RepressionCard.assemblyBan]);
        expect(state.isBlocked(ActionCardId.demo), isTrue);
      });
    });

    group('one-time cards', () {
      const flips = {
        RepressionCard.internetCensorship: (
          'AC-032/R-056',
          ActionCardId.internet,
        ),
        RepressionCard.publicityCensorship: ('R-057', ActionCardId.publicity),
        RepressionCard.observation: ('R-058', ActionCardId.hardwareStore),
        RepressionCard.confiscation: ('R-059', ActionCardId.ruralCommune),
        RepressionCard.threat: ('R-060', ActionCardId.allies),
        RepressionCard.ban: ('R-061/Q1', ActionCardId.autonomousCentre),
      };
      for (final MapEntry(key: repression, value: (rule, card))
          in flips.entries) {
        test('$rule: $repression turns $card to side B '
            'and leaves the game', () {
          final state = repress(deck: [repression]);
          expect(state.cardSides[card], equals(CardSide.b));
          expect(state.repressionInPlay, isEmpty);
          expect(state.repressionDeck, isEmpty);
        });
      }
    });

    group('immediate cards', () {
      test('AC-031/R-051: raid removes half of 5 resources rounded up', () {
        final state = repress(
          deck: [RepressionCard.raid],
          camp: const Camp(activists: 2, resources: 5),
        );
        expect(state.camp.resources, equals(2));
        expect(state.repressionInPlay, equals([RepressionCard.raid]));
      });

      test('R-054/Q6: protection by the public adds a resource', () {
        final state = repress(
          deck: [RepressionCard.publicProtection],
          camp: const Camp(activists: 2, resources: 1),
        );
        expect(state.camp.resources, equals(2));
      });

      test('R-054/Q8: protection by the public respects the limit', () {
        final state = repress(
          deck: [RepressionCard.publicProtection],
          camp: const Camp(activists: 2, resources: 8),
        );
        expect(state.camp.resources, equals(8));
      });

      test('R-052: night shift excavates the rolled column', () {
        final state = repress(deck: [RepressionCard.nightShift], random: [4]);
        expect(
          state.forest.columns[2][0].state,
          equals(ForestCardState.clearCut),
        );
        expect(
          state.log,
          equals([
            const RepressionCardDrawn(RepressionCard.nightShift),
            const RepressionDieRolled(5),
          ]),
        );
      });

      test('R-052/R-100: night shift can lose the game '
          'and stops further draws', () {
        final state = repress(
          deck: [RepressionCard.nightShift, RepressionCard.surveillance],
          fields: 2,
          forest: forestWith({
            (0, 0): const ForestCard(state: ForestCardState.removed),
            (0, 1): const ForestCard(state: ForestCardState.removed),
            (0, 2): const ForestCard(state: ForestCardState.removed),
            (0, 3): const ForestCard(state: ForestCardState.clearCut),
          }),
        );
        expect(state.outcome, equals(GameOutcome.defeat));
        expect(state.repressionDeck, equals([RepressionCard.surveillance]));
      });
    });

    group('$ResolveNegativePress', () {
      GameState negativePress({
        Camp camp = const Camp(activists: 2, resources: 0),
        int support = 1,
        Forest? forest,
        List<RepressionCard> deck = const [RepressionCard.negativePress],
      }) => repress(deck: deck, camp: camp, support: support, forest: forest);

      test('AC-036: asks to choose between support and an activist', () {
        final state = negativePress();
        expect(state.pendingDecision, equals(const NegativePressDecision()));
        expect(state.phase, equals(GamePhase.repression));
      });

      test('R-053: lowers support by 1', () {
        final state = applyTo(
          negativePress(),
          const ResolveNegativePress(NegativePressChoice.support),
        );
        expect(state.support, equals(0));
        expect(state.activistsInPlay, equals(2));
        expect(state.pendingDecision, isNull);
      });

      test('R-053/Q20: removes an activist from the camp', () {
        final state = applyTo(
          negativePress(),
          const ResolveNegativePress(NegativePressChoice.activist),
        );
        expect(state.camp.activists, equals(1));
        expect(state.support, equals(1));
      });

      test('Q20: removes the first activist on the forest '
          'when the camp is empty', () {
        final state = applyTo(
          negativePress(
            camp: const Camp(activists: 0, resources: 0),
            forest: forestWith({
              (1, 1): const ForestCard(hasActivist: true),
              (2, 0): const ForestCard(hasActivist: true),
            }),
          ),
          const ResolveNegativePress(NegativePressChoice.activist),
        );
        expect(state.forest.columns[1][1].hasActivist, isFalse);
        expect(state.forest.columns[2][0].hasActivist, isTrue);
      });

      test('Q18: removes an activist automatically when support is 0', () {
        final state = negativePress(support: 0);
        expect(state.pendingDecision, isNull);
        expect(state.camp.activists, equals(1));
      });

      test('Q18: lowers support automatically without activists', () {
        final state = negativePress(
          camp: const Camp(activists: 0, resources: 0),
          support: 4,
        );
        expect(state.pendingDecision, isNull);
        expect(state.support, equals(3));
      });

      test('Q18: has no effect without support and activists', () {
        final state = applyTo(
          buildGameState(
            phase: GamePhase.repression,
            camp: const Camp(activists: 0, resources: 0),
            cardSides: {ActionCardId.internet: CardSide.b},
            pendingDecision: const RestoreCardDecision(),
            repressionDeck: [RepressionCard.negativePress],
            repressionInPlay: [RepressionCard.legalAid],
            repressionCardsToDraw: 1,
          ),
          const ChooseCardToRestore(ActionCardId.internet),
        );
        expect(state.pendingDecision, isNull);
        expect(state.support, equals(0));
        expect(state.phase, equals(GamePhase.preparation));
      });

      test('R-067: continues drawing after the decision', () {
        final state = applyTo(
          repress(
            deck: [RepressionCard.negativePress, RepressionCard.assemblyBan],
            camp: const Camp(activists: 4, resources: 0),
            support: 1,
          ),
          const ResolveNegativePress(NegativePressChoice.support),
        );
        expect(
          state.repressionInPlay,
          equals([RepressionCard.negativePress, RepressionCard.assemblyBan]),
        );
        expect(state.phase, equals(GamePhase.preparation));
      });

      test('throws $InvalidDecisionException without negative press', () {
        expect(
          () => applyTo(
            buildGameState(),
            const ResolveNegativePress(NegativePressChoice.support),
          ),
          throwsA(isA<InvalidDecisionException>()),
        );
      });
    });

    group('$ChooseCardToRestore', () {
      test('AC-033: legal aid turns the chosen card back to side A', () {
        final awaiting = repress(
          deck: [RepressionCard.legalAid],
          cardSides: {ActionCardId.internet: CardSide.b},
        );
        expect(awaiting.pendingDecision, equals(const RestoreCardDecision()));
        final state = applyTo(
          awaiting,
          const ChooseCardToRestore(ActionCardId.internet),
        );
        expect(state.cardSides[ActionCardId.internet], equals(CardSide.a));
        expect(state.pendingDecision, isNull);
      });

      test('R-055: has no effect when no card is on side B', () {
        final state = repress(deck: [RepressionCard.legalAid]);
        expect(state.pendingDecision, isNull);
        expect(state.repressionInPlay, equals([RepressionCard.legalAid]));
      });

      test('throws $CardNotOnSideBException for a card on side A', () {
        expect(
          () => applyTo(
            repress(
              deck: [RepressionCard.legalAid],
              cardSides: {ActionCardId.internet: CardSide.b},
            ),
            const ChooseCardToRestore(ActionCardId.allies),
          ),
          throwsA(isA<CardNotOnSideBException>()),
        );
      });

      test('throws $InvalidDecisionException without legal aid', () {
        expect(
          () => applyTo(
            buildGameState(),
            const ChooseCardToRestore(ActionCardId.allies),
          ),
          throwsA(isA<InvalidDecisionException>()),
        );
      });
    });

    group('$ChooseSecurityCard', () {
      test('R-050/Q14: asks to choose a card in the rolled column', () {
        final state = repress(deck: [RepressionCard.security], random: [2]);
        expect(
          state.pendingDecision,
          equals(const SecurityPlacementDecision(column: 1)),
        );
        expect(state.log, contains(const RepressionDieRolled(3)));
      });

      test('AC-035: an activist on the chosen card leaves the game', () {
        final state = applyTo(
          repress(
            deck: [RepressionCard.security],
            fields: 2,
            forest: forestWith({(1, 2): const ForestCard(hasActivist: true)}),
            random: [2],
          ),
          const ChooseSecurityCard(2),
        );
        expect(
          state.forest.columns[1][2],
          equals(const ForestCard(hasSecurity: true)),
        );
        expect(state.activistsInPlay, equals(4));
        expect(state.pendingDecision, isNull);
      });

      test('Q7: rerolls when the column has no free card', () {
        final state = repress(
          deck: [RepressionCard.security],
          forest: forestWith({
            for (var p = 0; p < Forest.cardsPerColumn; p++)
              (0, p): const ForestCard(state: ForestCardState.removed),
          }).replace(column: 2, position: 0, card: const ForestCard()),
          random: [0, 5],
        );
        expect(
          state.pendingDecision,
          equals(const SecurityPlacementDecision(column: 2)),
        );
      });

      test('R-003/Q7: has no effect when all 3 security guards are in use', () {
        final state = repress(
          deck: [RepressionCard.security],
          forest: forestWith({
            (0, 0): const ForestCard(hasSecurity: true),
            (1, 0): const ForestCard(hasSecurity: true),
            (2, 0): const ForestCard(hasSecurity: true),
          }),
        );
        expect(state.pendingDecision, isNull);
        expect(state.phase, equals(GamePhase.preparation));
      });

      test('Q7: has no effect when no forest card is free', () {
        final state = repress(
          deck: [RepressionCard.security],
          forest: forestFilledWith(
            const ForestCard(state: ForestCardState.removed),
          ),
        );
        expect(state.pendingDecision, isNull);
      });

      for (final (description, card) in [
        (
          'Q17: a removed card',
          const ForestCard(state: ForestCardState.removed),
        ),
        (
          'R-050: a card with a security guard',
          const ForestCard(hasSecurity: true),
        ),
      ]) {
        test('throws $InvalidForestCardException for $description', () {
          expect(
            () => applyTo(
              repress(
                deck: [RepressionCard.security],
                forest: forestWith({(0, 1): card}),
              ),
              const ChooseSecurityCard(1),
            ),
            throwsA(isA<InvalidForestCardException>()),
          );
        });
      }

      for (final position in [-1, 4]) {
        test('throws $InvalidForestCardException for position $position', () {
          expect(
            () => applyTo(
              repress(deck: [RepressionCard.security]),
              ChooseSecurityCard(position),
            ),
            throwsA(isA<InvalidForestCardException>()),
          );
        });
      }

      test('throws $InvalidDecisionException without security', () {
        expect(
          () => applyTo(buildGameState(), const ChooseSecurityCard(0)),
          throwsA(isA<InvalidDecisionException>()),
        );
      });
    });
  });
}
