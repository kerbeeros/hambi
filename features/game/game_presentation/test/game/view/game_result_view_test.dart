import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';

import '../../helpers/helpers.dart';

void main() {
  group(GameResultView, () {
    Forest forestWithRemoved(Set<(int, int)> removed) => Forest(
      columns: [
        for (var c = 0; c < Forest.columnCount; c++)
          [
            for (var p = 0; p < Forest.cardsPerColumn; p++)
              ForestCard(
                state: removed.contains((c, p))
                    ? ForestCardState.removed
                    : ForestCardState.forest,
              ),
          ],
      ],
    );

    testWidgets(
      'R-102: shows a victory with support, removed cards and round',
      (tester) async {
        await tester.pumpApp(
          GameResultView(
            game: buildGameState(
              round: 12,
              phase: GamePhase.finished,
              outcome: GameOutcome.victory,
              support: 4,
              forest: forestWithRemoved({(0, 0), (1, 0), (2, 0)}),
            ),
            onNewGame: () {},
          ),
        );

        expect(find.text('Hambi bleibt!'), findsOneWidget);
        expect(
          find.text('Ihr habt mehr Unterstützung als entfernte Waldkarten.'),
          findsOneWidget,
        );
        expect(find.text('4'), findsOneWidget);
        expect(find.text('3'), findsOneWidget);
        expect(find.text('12'), findsOneWidget);
      },
    );

    testWidgets('R-100: explains an immediate defeat', (tester) async {
      await tester.pumpApp(
        GameResultView(
          game: buildGameState(
            round: 6,
            phase: GamePhase.finished,
            outcome: GameOutcome.defeat,
            forest: forestWithRemoved({(1, 0), (1, 1), (1, 2), (1, 3)}),
          ),
          onNewGame: () {},
        ),
      );

      expect(find.text('Der Wald ist verloren'), findsOneWidget);
      expect(
        find.text('Eine Waldspalte wurde vollständig gerodet.'),
        findsOneWidget,
      );
    });

    testWidgets('R-101: explains a defeat after round 12', (tester) async {
      await tester.pumpApp(
        GameResultView(
          game: buildGameState(
            round: 12,
            phase: GamePhase.finished,
            outcome: GameOutcome.defeat,
            support: 2,
            forest: forestWithRemoved({(0, 0), (1, 0)}),
          ),
          onNewGame: () {},
        ),
      );

      expect(
        find.text(
          'Die Unterstützung reicht nicht gegen die entfernten Waldkarten.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('starts a new game', (tester) async {
      var newGames = 0;
      await tester.pumpApp(
        GameResultView(
          game: buildGameState(
            phase: GamePhase.finished,
            outcome: GameOutcome.victory,
          ),
          onNewGame: () => newGames++,
        ),
      );

      await tester.tap(find.text('Neues Spiel'));

      expect(newGames, equals(1));
    });
  });
}
