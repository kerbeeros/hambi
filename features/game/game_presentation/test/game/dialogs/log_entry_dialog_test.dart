import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(LogEntryDialog, () {
    /// Opens the dialog for [entry] and waits until it shows the result.
    Future<void> open(WidgetTester tester, GameLogEntry entry) async {
      await tester.pumpApp(const SizedBox());
      unawaited(
        LogEntryDialog.show(tester.element(find.byType(SizedBox)), entry),
      );
      await tester.pump();
      await tester.pump(AppDuration.reveal);
      await tester.pumpAndSettle();
    }

    testWidgets('D-07: shows both excavator dice and their columns', (
      tester,
    ) async {
      await open(tester, const DiceRolled([3, 6]));

      expect(find.text('Baggerwürfel'), findsOneWidget);
      expect(find.byType(DieView), findsNWidgets(2));
      expect(find.text('3 trifft WS2'), findsOneWidget);
      expect(find.text('6 trifft WS3'), findsOneWidget);
    });

    testWidgets('D-07: shows a rerolled die', (tester) async {
      await open(tester, const DieRerolled(index: 0, value: 4));

      expect(find.byType(DieView), findsOneWidget);
      expect(find.text('4 trifft WS2'), findsOneWidget);
    });

    testWidgets('D-07: shows a repression die', (tester) async {
      await open(tester, const RepressionDieRolled(1));

      expect(find.text('Würfel'), findsOneWidget);
      expect(find.byType(DieView), findsOneWidget);
    });

    testWidgets('D-06: shows the drawn repression card', (tester) async {
      await open(tester, const RepressionCardDrawn(RepressionCard.raid));

      expect(find.text('Repressionskarte'), findsOneWidget);
      expect(find.text('Razzia'), findsOneWidget);
    });

    group('animation (UX-04)', () {
      Future<void> openAnimated(WidgetTester tester, GameLogEntry entry) async {
        await tester.pumpApp(const SizedBox());
        unawaited(
          LogEntryDialog.show(tester.element(find.byType(SizedBox)), entry),
        );
        await tester.pump();
        await tester.pump();
      }

      List<bool> rolling(WidgetTester tester) => [
        for (final die in tester.widgetList<RollingDieView>(
          find.byType(RollingDieView),
        ))
          die.rolling,
      ];

      bool revealed(WidgetTester tester) =>
          tester.widget<CardFlipView>(find.byType(CardFlipView)).revealed;

      testWidgets('AC-050: rolls the dice and hides their columns', (
        tester,
      ) async {
        await openAnimated(tester, const DiceRolled([3, 6]));

        expect(rolling(tester), equals([true, true]));
        expect(find.text('3 trifft WS2'), findsNothing);
        expect(find.text('Überspringen'), findsOneWidget);
        expect(find.text('Weiter'), findsNothing);
      });

      testWidgets('AC-050: shows the result once the dice stop', (
        tester,
      ) async {
        await openAnimated(tester, const DiceRolled([3, 6]));

        await tester.pump(AppDuration.reveal);

        expect(rolling(tester), equals([false, false]));
        expect(find.text('3 trifft WS2'), findsOneWidget);
        expect(find.text('Weiter'), findsOneWidget);
      });

      testWidgets('AC-051: "Überspringen" shows the result at once', (
        tester,
      ) async {
        await openAnimated(tester, const DieRerolled(index: 0, value: 4));

        await tester.tap(find.text('Überspringen'));
        await tester.pump();

        expect(rolling(tester), equals([false]));
        expect(find.text('4 trifft WS2'), findsOneWidget);
        expect(find.byType(HambiDialog), findsOneWidget);
      });

      testWidgets('AC-051: tapping a die shows the result at once', (
        tester,
      ) async {
        await openAnimated(tester, const RepressionDieRolled(2));

        await tester.tap(find.byType(RollingDieView));
        await tester.pump();

        expect(rolling(tester), equals([false]));
        expect(find.text('Weiter'), findsOneWidget);
      });

      testWidgets('AC-052: turns the drawn card over after a while', (
        tester,
      ) async {
        await openAnimated(
          tester,
          const RepressionCardDrawn(RepressionCard.raid),
        );
        expect(revealed(tester), isFalse);

        await tester.pump(AppDuration.reveal);

        expect(revealed(tester), isTrue);
      });

      testWidgets('AC-052: tapping the card turns it over at once', (
        tester,
      ) async {
        await openAnimated(
          tester,
          const RepressionCardDrawn(RepressionCard.raid),
        );

        await tester.tap(find.byType(CardFlipView));
        await tester.pump();

        expect(revealed(tester), isTrue);
      });

      testWidgets('AC-063: labels a rolling die', (tester) async {
        await openAnimated(tester, const RepressionDieRolled(2));

        // Lets the dialog finish its entrance while the die still rolls.
        await tester.pump(AppDuration.reveal ~/ 2);

        expect(find.bySemanticsLabel('Würfel rollt'), findsOneWidget);
      });

      testWidgets('AC-063: labels an excavator die with its column', (
        tester,
      ) async {
        await openAnimated(tester, const DiceRolled([3, 6]));

        await tester.pump(AppDuration.reveal);

        expect(
          find.bySemanticsLabel('Würfel zeigt 3, trifft WS2'),
          findsOneWidget,
        );
      });

      testWidgets('AC-063: labels a repression die with its value', (
        tester,
      ) async {
        await openAnimated(tester, const RepressionDieRolled(2));

        await tester.pump(AppDuration.reveal);

        expect(find.bySemanticsLabel('Würfel zeigt 2'), findsOneWidget);
      });

      testWidgets('AC-053: shows the result at once with reduced motion', (
        tester,
      ) async {
        tester.platformDispatcher.accessibilityFeaturesTestValue =
            const FakeAccessibilityFeatures(disableAnimations: true);
        addTearDown(
          tester.platformDispatcher.clearAccessibilityFeaturesTestValue,
        );

        await openAnimated(tester, const DiceRolled([3, 6]));

        expect(rolling(tester), equals([false, false]));
        expect(find.text('Weiter'), findsOneWidget);
      });
    });

    testWidgets('closes with "Weiter"', (tester) async {
      await open(tester, const RepressionDieRolled(1));

      await tester.tap(find.text('Weiter'));
      await tester.pumpAndSettle();

      expect(find.byType(HambiDialog), findsNothing);
    });
  });
}
