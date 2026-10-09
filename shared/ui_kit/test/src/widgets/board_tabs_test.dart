import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(BoardTabs, () {
    Widget tabs({int selectedIndex = 0, ValueChanged<int>? onSelected}) =>
        SizedBox(
          width: 361,
          child: BoardTabs(
            tabs: const [
              BoardTab(label: 'Wald', badgeCount: 2),
              BoardTab(label: 'Aktionen'),
            ],
            selectedIndex: selectedIndex,
            onSelected: onSelected ?? (_) {},
          ),
        );

    testWidgets('renders all tab labels', (tester) async {
      await tester.pumpApp(tabs());

      expect(find.text('Wald'), findsOneWidget);
      expect(find.text('Aktionen'), findsOneWidget);
    });

    testWidgets('renders the badge count', (tester) async {
      await tester.pumpApp(tabs());

      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('calls onSelected with the tapped index', (tester) async {
      int? selected;
      await tester.pumpApp(tabs(onSelected: (index) => selected = index));

      await tester.tap(find.text('Aktionen'));

      expect(selected, equals(1));
    });

    testWidgets('marks the selected tab', (tester) async {
      await tester.pumpApp(tabs(selectedIndex: 1));

      expect(
        tester.getSemantics(find.text('Aktionen')),
        isSemantics(
          label: 'Aktionen',
          isSelected: true,
          isButton: true,
          hasTapAction: true,
        ),
      );
    });

    testWidgets('NF-04: fits four labels at twice the text size', (
      tester,
    ) async {
      await tester.pumpApp(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2)),
          child: SizedBox(
            width: 361,
            child: BoardTabs(
              tabs: const [
                BoardTab(label: 'Spielidee'),
                BoardTab(label: 'Ablauf'),
                BoardTab(label: 'Symbole', badgeCount: 3),
                BoardTab(label: 'Karten'),
              ],
              selectedIndex: 0,
              onSelected: (_) {},
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    });

    testWidgets('is 44 logical pixels high', (tester) async {
      await tester.pumpApp(tabs());

      expect(tester.getSize(find.byType(BoardTabs)).height, equals(44));
    });
  });
}
