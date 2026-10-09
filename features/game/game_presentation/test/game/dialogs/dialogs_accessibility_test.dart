import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

/// AC-060, AC-061: every dialog and sheet of the game meets the
/// accessibility guidelines and fits 200 % text.
void main() {
  /// Registers both checks for the dialog that [show] opens; [then] runs
  /// once the dialog is open.
  void checkDialog(
    String description,
    Future<void> Function(BuildContext context) show, {
    Future<void> Function(WidgetTester tester)? then,
  }) {
    Future<void> open(WidgetTester tester) async {
      await tester.pumpApp(const SizedBox());
      unawaited(show(tester.element(find.byType(SizedBox))));
      await tester.pump();
      // Lets dice stop and cards turn over (UX-04).
      await tester.pump(AppDuration.reveal);
      await tester.pumpAndSettle();
      await then?.call(tester);
    }

    testWidgets('AC-060: $description meets the guidelines', (tester) async {
      await open(tester);

      await expectMeetsAccessibilityGuidelines(tester);
    });

    testWidgets('AC-061: $description fits 200 % text', (tester) async {
      setTextScale(tester, 2);
      await open(tester);

      expect(tester.takeException(), isNull);
    });
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
      checkDialog(
        '${decision.runtimeType}',
        (context) => DecisionDialog.show(
          context,
          game: samplePreparation,
          decision: decision,
        ),
      );
    }
  });

  group(LogEntryDialog, () {
    for (final entry in const <GameLogEntry>[
      DiceRolled([3, 6]),
      DieRerolled(index: 0, value: 1),
      RepressionDieRolled(5),
      RepressionCardDrawn(RepressionCard.raid),
    ]) {
      checkDialog(
        '${entry.runtimeType}',
        (context) => LogEntryDialog.show(context, entry),
      );
    }
  });

  group(CardDetailDialog, () {
    checkDialog(
      'the action card detail',
      (context) => CardDetailDialog.showActionCard(
        context,
        game: samplePreparation,
        card: ActionCardId.demo,
      ),
    );
    checkDialog(
      'the forest card detail',
      (context) => CardDetailDialog.showForestCard(
        context,
        card: const ForestCard(
          state: ForestCardState.clearCut,
          hasActivist: true,
        ),
        position: const ForestPosition(column: 0, position: 1),
        isThreatened: true,
      ),
    );
    checkDialog(
      'the repression card detail',
      (context) => CardDetailDialog.showRepressionCard(
        context,
        card: RepressionCard.assemblyBan,
      ),
    );
  });

  group(RoundLogSheet, () {
    checkDialog(
      'the round log',
      (context) => RoundLogSheet.show(context, samplePreparation.log),
    );
  });

  group(GameMenuSheet, () {
    checkDialog('the game menu', GameMenuSheet.show);
    checkDialog(
      'the exit confirmation',
      GameMenuSheet.show,
      then: (tester) async {
        final l10n = lookupGameLocalizations(const Locale('de'));
        await tester.tap(find.text(l10n.menuExitAction));
        await tester.pumpAndSettle();
      },
    );
  });
}
