// goldenTest registers its tests synchronously; the returned Future must not
// be awaited inside a group.
// ignore_for_file: discarded_futures

import 'package:alchemist/alchemist.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';

import '../../helpers/helpers.dart';

void main() {
  Widget board(GameState game, {BoardSection tab = BoardSection.actions}) =>
      GameBoard(
        game: game,
        tab: tab,
        onTabSelected: (_) {},
        onCommand: (_) {},
        onLogPressed: () {},
        onMenuPressed: () {},
      );

  group(GameBoard, () {
    goldenTest(
      'S-03: renders the board on a phone',
      fileName: 'game_board_phone',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        columns: 3,
        children: [
          GoldenTestScenario(
            name: 'setup',
            child: GoldenScreen(
              size: GoldenDevice.phone,
              child: board(
                buildGameState(
                  round: 0,
                  phase: GamePhase.setup,
                  camp: const Camp(activists: 4, resources: 0),
                ),
                tab: BoardSection.forest,
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'preparation, actions',
            child: GoldenScreen(
              size: GoldenDevice.phone,
              child: board(samplePreparation),
            ),
          ),
          GoldenTestScenario(
            name: 'preparation, forest',
            child: GoldenScreen(
              size: GoldenDevice.phone,
              child: board(samplePreparation, tab: BoardSection.forest),
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'UX-09: renders the board on a tablet',
      fileName: 'game_board_tablet',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'preparation',
            child: GoldenScreen(
              size: GoldenDevice.tablet,
              child: board(samplePreparation),
            ),
          ),
        ],
      ),
    );
  });

  group(GameResultView, () {
    goldenTest(
      'S-04: renders victory and defeat',
      fileName: 'game_result_view',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        columns: 3,
        children: [
          for (final (name, game) in [
            (
              'victory',
              buildGameState(
                round: 12,
                phase: GamePhase.finished,
                outcome: GameOutcome.victory,
                support: 6,
                forest: sampleForest,
              ),
            ),
            (
              'defeat after round 12',
              buildGameState(
                round: 12,
                phase: GamePhase.finished,
                outcome: GameOutcome.defeat,
                support: 1,
                forest: sampleForest,
              ),
            ),
            (
              'immediate defeat',
              buildGameState(
                round: 7,
                phase: GamePhase.finished,
                outcome: GameOutcome.defeat,
                support: 4,
                forest: Forest(
                  columns: [
                    List.filled(
                      Forest.cardsPerColumn,
                      const ForestCard(state: ForestCardState.removed),
                    ),
                    ...Forest.initial().columns.skip(1),
                  ],
                ),
              ),
            ),
          ])
            GoldenTestScenario(
              name: name,
              child: GoldenScreen(
                size: GoldenDevice.phone,
                child: GameResultView(game: game, onNewGame: () {}),
              ),
            ),
        ],
      ),
    );
  });
}
