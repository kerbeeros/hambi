import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

import '../helpers/helpers.dart';

void main() {
  group(GameEngine, () {
    /// Runs a round without assignments into the excavation phase with the
    /// scripted die values (1–6).
    GameState excavate(
      List<int> dice, {
      Forest? forest,
      Set<ActionCardId> assignedCards = const {},
    }) {
      final engine = GameEngine(
        FakeRandomGenerator([for (final die in dice) die - 1]),
      );
      return engine.apply(
        buildGameState(
          phase: GamePhase.preparation,
          camp: const Camp(activists: 2, resources: 0),
          forest: forest,
          assignedCards: assignedCards,
        ),
        const EndPreparation(),
      );
    }

    ForestCard card(GameState state, int column, int position) =>
        state.forest.columns[column][position];

    group('excavation', () {
      for (final (die, column) in [
        (1, 0),
        (2, 0),
        (3, 1),
        (4, 1),
        (5, 2),
        (6, 2),
      ]) {
        test(
          'R-005/R-120/R-122: two dice showing $die hit WS${column + 1} twice',
          () {
            final state = excavate([die, die]);
            expect(card(state, column, 0).state, ForestCardState.removed);
            expect(card(state, column, 1).state, ForestCardState.forest);
          },
        );
      }

      test('AC-020: a die showing 3 hits WS2', () {
        final state = excavate([3, 6]);
        expect(card(state, 0, 0), equals(const ForestCard()));
        expect(card(state, 1, 0).state, equals(ForestCardState.clearCut));
      });

      test('AC-021: a forest card becomes clear-cut', () {
        final state = excavate([1, 6]);
        expect(card(state, 0, 0).state, equals(ForestCardState.clearCut));
      });

      test('AC-022: a clear-cut card becomes removed', () {
        final state = excavate(
          [1, 6],
          forest: forestWith({
            (0, 0): const ForestCard(state: ForestCardState.clearCut),
          }),
        );
        expect(card(state, 0, 0).state, equals(ForestCardState.removed));
      });

      test('R-123/Q4: the first card that is not removed is hit', () {
        final state = excavate(
          [1, 6],
          forest: forestWith({
            (0, 0): const ForestCard(state: ForestCardState.removed),
          }),
        );
        expect(card(state, 0, 1).state, equals(ForestCardState.clearCut));
      });

      test('AC-023: an activist on the target is removed instead', () {
        final state = excavate([1, 6], forest: forestWithActivist());
        expect(card(state, 0, 0), equals(const ForestCard()));
        expect(state.activistsInPlay, equals(2));
      });

      test('AC-024: a security guard is removed and the card clear-cut', () {
        final state = excavate([
          1,
          6,
        ], forest: forestWith({(0, 0): const ForestCard(hasSecurity: true)}));
        expect(
          card(state, 0, 0),
          equals(const ForestCard(state: ForestCardState.clearCut)),
        );
      });

      test('logs the rolled dice (F-07)', () {
        expect(
          excavate([2, 5]).log,
          equals([
            const DiceRolled([2, 5]),
          ]),
        );
      });

      group('R-100', () {
        final almostCleared = forestWith({
          (0, 0): const ForestCard(state: ForestCardState.removed),
          (0, 1): const ForestCard(state: ForestCardState.removed),
          (0, 2): const ForestCard(state: ForestCardState.removed),
          (0, 3): const ForestCard(state: ForestCardState.clearCut),
        });

        test('AC-026: removing the last card of a column loses the game', () {
          final state = excavate([1, 6], forest: almostCleared);
          expect(state.outcome, equals(GameOutcome.defeat));
          expect(state.phase, equals(GamePhase.finished));
        });

        test('the second die is not resolved after a defeat', () {
          final state = excavate([1, 6], forest: almostCleared);
          expect(card(state, 2, 0), equals(const ForestCard()));
        });
      });
    });

    group('$RerollDie', () {
      GameState withSabotage(List<int> dice) =>
          excavate(dice, assignedCards: {ActionCardId.sabotage});

      test('AC-025: sabotage offers to reroll a die before resolving', () {
        final state = withSabotage([1, 6]);
        expect(state.pendingDecision, equals(const RerollDecision([1, 6])));
        expect(card(state, 0, 0), equals(const ForestCard()));
      });

      test('AC-025: rerolls exactly one die once and resolves both', () {
        final engine = GameEngine(FakeRandomGenerator([0, 5, 2]));
        final state = engine.apply(
          engine.apply(
            buildGameState(
              phase: GamePhase.preparation,
              camp: const Camp(activists: 2, resources: 0),
              assignedCards: {ActionCardId.sabotage},
            ),
            const EndPreparation(),
          ),
          const RerollDie(0),
        );
        expect(state.pendingDecision, isNull);
        expect(card(state, 0, 0), equals(const ForestCard()));
        expect(card(state, 1, 0).state, equals(ForestCardState.clearCut));
        expect(card(state, 2, 0).state, equals(ForestCardState.clearCut));
        expect(
          state.log,
          equals([
            const DiceRolled([1, 6]),
            const DieRerolled(index: 0, value: 3),
          ]),
        );
      });

      test('R-121: $Continue keeps the dice', () {
        final state = GameEngine(FakeRandomGenerator([0, 5]))
            .apply(withSabotage([1, 6]), const Continue());
        expect(state.pendingDecision, isNull);
        expect(card(state, 0, 0).state, equals(ForestCardState.clearCut));
      });

      for (final index in [-1, 2]) {
        test('throws $InvalidDieException for index $index', () {
          expect(
            () =>
                GameEngine(FakeRandomGenerator())
                    .apply(withSabotage([1, 6]), RerollDie(index)),
            throwsA(isA<InvalidDieException>()),
          );
        });
      }

      test('R-121: throws $InvalidDecisionException without sabotage', () {
        expect(
          () =>
              GameEngine(FakeRandomGenerator())
                  .apply(excavate([1, 6]), const RerollDie(0)),
          throwsA(isA<InvalidDecisionException>()),
        );
      });
    });

    group('$ReturnActivistsToCamp', () {
      final twoActivists = forestWith({
        (1, 2): const ForestCard(hasActivist: true),
        (2, 3): const ForestCard(hasActivist: true),
      });

      test('R-124: asks whether activists on the forest return', () {
        final state = excavate([1, 1], forest: twoActivists);
        expect(state.pendingDecision, equals(const ReturnActivistsDecision()));
      });

      test('R-124: proceeds to repression without activists on the forest', () {
        final state = excavate([1, 1]);
        expect(state.pendingDecision, isNull);
        expect(state.round, equals(2), reason: 'repression ran');
      });

      test('R-124: returns the chosen activists to the camp', () {
        final state = GameEngine(FakeRandomGenerator()).apply(
          excavate([1, 1], forest: twoActivists),
          ReturnActivistsToCamp({const ForestPosition(column: 1, position: 2)}),
        );
        expect(card(state, 1, 2).hasActivist, isFalse);
        expect(card(state, 2, 3).hasActivist, isTrue);
        expect(state.camp.activists, equals(3));
        expect(state.pendingDecision, isNull);
        expect(state.round, equals(2), reason: 'repression ran');
      });

      test('R-124: $Continue leaves all activists on the forest', () {
        final state = GameEngine(FakeRandomGenerator())
            .apply(excavate([1, 1], forest: twoActivists), const Continue());
        expect(card(state, 1, 2).hasActivist, isTrue);
        expect(card(state, 2, 3).hasActivist, isTrue);
        expect(state.camp.activists, equals(2));
        expect(state.round, equals(2), reason: 'repression ran');
      });

      test('throws $InvalidForestCardException for a card '
          'without an activist', () {
        expect(
          () => GameEngine(FakeRandomGenerator()).apply(
            excavate([1, 1], forest: twoActivists),
            ReturnActivistsToCamp({
              const ForestPosition(column: 0, position: 3),
            }),
          ),
          throwsA(isA<InvalidForestCardException>()),
        );
      });

      test('throws $InvalidForestCardException outside the forest', () {
        expect(
          () => GameEngine(FakeRandomGenerator()).apply(
            excavate([1, 1], forest: twoActivists),
            ReturnActivistsToCamp({
              const ForestPosition(column: 3, position: 0),
            }),
          ),
          throwsA(isA<InvalidForestCardException>()),
        );
      });

      test('throws $InvalidDecisionException without a pending decision', () {
        expect(
          () =>
              GameEngine(FakeRandomGenerator())
                  .apply(buildGameState(), const ReturnActivistsToCamp({})),
          throwsA(isA<InvalidDecisionException>()),
        );
      });
    });
  });
}
