import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(RoundHeader, () {
    Widget header({VoidCallback? onLog, VoidCallback? onMenu}) => RoundHeader(
      title: 'Runde 3/12',
      subtitle: 'Vorbereitung',
      logTooltip: 'Rundenlog',
      menuTooltip: 'Spielmenü',
      onLogPressed: onLog ?? () {},
      onMenuPressed: onMenu ?? () {},
    );

    testWidgets('AC-060: meets the accessibility guidelines', (tester) async {
      await tester.pumpApp(header());

      await expectMeetsAccessibilityGuidelines(tester);
    });

    testWidgets('NF-04: labels the log and menu buttons', (tester) async {
      final semantics = tester.ensureSemantics();
      var logs = 0;
      var menus = 0;
      await tester.pumpApp(header(onLog: () => logs++, onMenu: () => menus++));

      tester.semantics
        ..tap(find.semantics.byLabel('Rundenlog'))
        ..tap(find.semantics.byLabel('Spielmenü'));

      expect((logs, menus), equals((1, 1)));
      semantics.dispose();
    });

    testWidgets('renders title and subtitle', (tester) async {
      await tester.pumpApp(header());

      expect(find.text('Runde 3/12'), findsOneWidget);
      expect(find.text('Vorbereitung'), findsOneWidget);
    });

    testWidgets('calls onLogPressed', (tester) async {
      var taps = 0;
      await tester.pumpApp(header(onLog: () => taps++));

      await tester.tap(find.byTooltip('Rundenlog'));

      expect(taps, equals(1));
    });

    testWidgets('calls onMenuPressed', (tester) async {
      var taps = 0;
      await tester.pumpApp(header(onMenu: () => taps++));

      await tester.tap(find.byTooltip('Spielmenü'));

      expect(taps, equals(1));
    });

    testWidgets('is 64 logical pixels high', (tester) async {
      await tester.pumpApp(header());

      expect(tester.getSize(find.byType(RoundHeader)).height, equals(64));
    });

    testWidgets('AC-061: grows with 200 % text instead of overflowing', (
      tester,
    ) async {
      setTextScale(tester, 2);
      await tester.pumpApp(header());

      expect(tester.takeException(), isNull);
      expect(tester.getSize(find.byType(RoundHeader)).height, greaterThan(64));
    });
  });
}
