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
  const dialogWidth = BoxConstraints(maxWidth: 393);

  group(DecisionDialog, () {
    final game = samplePreparation.copyWith(
      cardSides: {
        ...samplePreparation.cardSides,
        ActionCardId.allies: CardSide.b,
      },
    );

    goldenTest(
      'D-01–D-05: renders every decision',
      fileName: 'decision_dialog',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        columns: 3,
        scenarioConstraints: dialogWidth,
        children: [
          for (final decision in const <PendingDecision>[
            PlaceActivistsDecision(activists: 2),
            SecurityPlacementDecision(column: 1),
            RerollDecision([2, 5]),
            NegativePressDecision(),
            RestoreCardDecision(),
            ReturnActivistsDecision(),
          ])
            GoldenTestScenario(
              name: decision.runtimeType.toString(),
              child: GoldenScreen(
                child: DecisionDialog.dialogFor(game: game, decision: decision),
              ),
            ),
        ],
      ),
    );
  });

  group(LogEntryDialog, () {
    goldenTest(
      'D-06, D-07: renders every log entry',
      fileName: 'log_entry_dialog',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        columns: 4,
        scenarioConstraints: dialogWidth,
        children: [
          for (final entry in const <GameLogEntry>[
            DiceRolled([3, 6]),
            DieRerolled(index: 0, value: 1),
            RepressionDieRolled(5),
            RepressionCardDrawn(RepressionCard.publicityCensorship),
          ])
            GoldenTestScenario(
              name: entry.runtimeType.toString(),
              child: GoldenScreen(child: LogEntryDialog.dialogFor(entry)),
            ),
        ],
      ),
    );
  });

  group(RoundLogSheet, () {
    goldenTest(
      'D-09: renders the round log',
      fileName: 'round_log_sheet',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        scenarioConstraints: dialogWidth,
        children: [
          GoldenTestScenario(
            name: 'entries',
            child: GoldenScreen(
              child: RoundLogSheet(log: samplePreparation.log),
            ),
          ),
        ],
      ),
    );
  });
}
