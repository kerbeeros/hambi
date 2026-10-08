import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(LogEntryDialog, () {
    Future<void> open(WidgetTester tester, GameLogEntry entry) async {
      await tester.pumpApp(const SizedBox());
      unawaited(
        LogEntryDialog.show(tester.element(find.byType(SizedBox)), entry),
      );
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

    testWidgets('closes with "Weiter"', (tester) async {
      await open(tester, const RepressionDieRolled(1));

      await tester.tap(find.text('Weiter'));
      await tester.pumpAndSettle();

      expect(find.byType(HambiDialog), findsNothing);
    });
  });
}
