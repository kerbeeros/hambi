import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

/// AC-060: every dialog and sheet of the game meets the accessibility
/// guidelines.
void main() {
  Future<void> open(
    WidgetTester tester,
    Future<void> Function(BuildContext context) show,
  ) async {
    await tester.pumpApp(const SizedBox());
    unawaited(show(tester.element(find.byType(SizedBox))));
    await tester.pumpAndSettle();
  }

  group(DecisionDialog, () {
    for (final decision in const <PendingDecision>[
      PlaceActivistsDecision(activists: 2),
      SecurityPlacementDecision(column: 1),
      RerollDecision([2, 5]),
      NegativePressDecision(),
      RestoreCardDecision(),
      ReturnActivistsDecision(),
    ]) {
      testWidgets('AC-060: ${decision.runtimeType} meets the guidelines', (
        tester,
      ) async {
        await open(
          tester,
          (context) => DecisionDialog.show(
            context,
            game: samplePreparation,
            decision: decision,
          ),
        );

        await expectMeetsAccessibilityGuidelines(tester);
      });
    }
  });

  group(LogEntryDialog, () {
    for (final entry in const <GameLogEntry>[
      DiceRolled([3, 6]),
      DieRerolled(index: 0, value: 1),
      RepressionDieRolled(5),
      RepressionCardDrawn(RepressionCard.raid),
    ]) {
      testWidgets('AC-060: ${entry.runtimeType} meets the guidelines', (
        tester,
      ) async {
        await open(tester, (context) => LogEntryDialog.show(context, entry));
        await tester.pump(AppDuration.reveal);
        await tester.pumpAndSettle();

        await expectMeetsAccessibilityGuidelines(tester);
      });
    }
  });

  group(CardDetailDialog, () {
    testWidgets('AC-060: the action card detail meets the guidelines', (
      tester,
    ) async {
      await open(
        tester,
        (context) => CardDetailDialog.showActionCard(
          context,
          game: samplePreparation,
          card: ActionCardId.demo,
        ),
      );

      await expectMeetsAccessibilityGuidelines(tester);
    });

    testWidgets('AC-060: the forest card detail meets the guidelines', (
      tester,
    ) async {
      await open(
        tester,
        (context) => CardDetailDialog.showForestCard(
          context,
          card: const ForestCard(state: ForestCardState.clearCut),
          position: const ForestPosition(column: 0, position: 1),
          isThreatened: true,
        ),
      );

      await expectMeetsAccessibilityGuidelines(tester);
    });

    testWidgets('AC-060: the repression card detail meets the guidelines', (
      tester,
    ) async {
      await open(
        tester,
        (context) => CardDetailDialog.showRepressionCard(
          context,
          card: RepressionCard.assemblyBan,
        ),
      );

      await expectMeetsAccessibilityGuidelines(tester);
    });
  });

  group(RoundLogSheet, () {
    testWidgets('AC-060: meets the guidelines', (tester) async {
      await open(
        tester,
        (context) => RoundLogSheet.show(context, samplePreparation.log),
      );

      await expectMeetsAccessibilityGuidelines(tester);
    });
  });

  group(GameMenuSheet, () {
    testWidgets('AC-060: meets the guidelines', (tester) async {
      await open(tester, GameMenuSheet.show);

      await expectMeetsAccessibilityGuidelines(tester);
    });

    testWidgets('AC-060: the exit confirmation meets the guidelines', (
      tester,
    ) async {
      await open(tester, GameMenuSheet.show);
      final l10n = lookupGameLocalizations(const Locale('de'));
      await tester.tap(find.text(l10n.menuExitAction));
      await tester.pumpAndSettle();

      await expectMeetsAccessibilityGuidelines(tester);
    });
  });
}
