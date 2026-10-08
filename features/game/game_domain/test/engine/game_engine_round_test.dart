import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

import '../helpers/helpers.dart';

void main() {
  group(GameEngine, () {
    late GameEngine engine;

    setUp(() {
      engine = GameEngine(FakeRandomGenerator());
    });

    Forest forestWithRemovedCards(int count) => forestWith({
      for (var i = 0; i < count; i++)
        (i, 0): const ForestCard(state: ForestCardState.removed),
    });

    /// Ends the excavation phase of [round] and runs its repression phase.
    GameState endRound({
      required int round,
      int support = 0,
      Forest? forest,
      List<RepressionCard> deck = const [],
    }) => engine.apply(
      buildGameState(
        round: round,
        phase: GamePhase.excavation,
        pendingDecision: const ReturnActivistsDecision(),
        camp: const Camp(activists: 0, resources: 0),
        support: support,
        forest: forest,
        repressionDeck: deck,
      ),
      const Continue(),
    );

    group('initial repression phase', () {
      test('AC-005/R-113: 7 activists and support 5 draw 3 cards', () {
        final state = engine.apply(
          buildGameState(
            round: 0,
            camp: const Camp(activists: 7, resources: 0),
            support: 5,
            repressionDeck: List.filled(4, RepressionCard.surveillance),
          ),
          const Continue(),
        );
        expect(state.repressionInPlay, hasLength(3));
        expect(state.round, equals(1));
        expect(state.phase, equals(GamePhase.preparation));
      });
    });

    group('game end', () {
      test('R-101: a round before the last starts the next round', () {
        final state = endRound(round: 11, support: 4);
        expect(state.round, equals(12));
        expect(state.outcome, isNull);
      });

      test('AC-040: support 4 against 3 removed cards wins', () {
        final state = endRound(
          round: 12,
          support: 4,
          forest: forestWithRemovedCards(3),
        );
        expect(state.outcome, equals(GameOutcome.victory));
        expect(state.phase, equals(GamePhase.finished));
        expect(state.round, equals(12));
      });

      test('AC-041/Q9: support 3 against 3 removed cards loses', () {
        final state = endRound(
          round: 12,
          support: 3,
          forest: forestWithRemovedCards(3),
        );
        expect(state.outcome, equals(GameOutcome.defeat));
        expect(state.phase, equals(GamePhase.finished));
      });

      test('Q16: the repression phase of round 12 is played', () {
        final state = endRound(
          round: 12,
          support: 4,
          forest: forestWithRemovedCards(3),
          deck: [RepressionCard.negativePress],
        );
        expect(state.support, equals(3));
        expect(state.outcome, equals(GameOutcome.defeat));
      });

      test('rejects commands after the game is finished', () {
        final finished = endRound(round: 12, support: 1);
        expect(
          () => engine.apply(finished, const Continue()),
          throwsA(isA<InvalidPhaseException>()),
        );
      });
    });
  });

  group('removedForestCards', () {
    test('R-102: counts the removed forest cards', () {
      expect(
        buildGameState(
          forest: forestWith({
            (0, 0): const ForestCard(state: ForestCardState.removed),
            (2, 1): const ForestCard(state: ForestCardState.removed),
            (1, 0): const ForestCard(state: ForestCardState.clearCut),
          }),
        ).removedForestCards,
        equals(2),
      );
    });
  });
}
