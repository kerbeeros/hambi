import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(RepressionCardView, () {
    Widget card({
      RepressionCardKind kind = RepressionCardKind.immediate,
      bool compact = false,
    }) => RepressionCardView(
      title: 'Razzia',
      description: 'Hälfte der R im Camp entfernen',
      kind: kind,
      compact: compact,
    );

    BoxDecoration decorationOf(WidgetTester tester) =>
        tester
                .widget<Container>(
                  find
                      .descendant(
                        of: find.byType(RepressionCardView),
                        matching: find.byType(Container),
                      )
                      .first,
                )
                .decoration!
            as BoxDecoration;

    testWidgets('renders title and description', (tester) async {
      await tester.pumpApp(card());

      expect(find.text('Razzia'), findsOneWidget);
      expect(find.text('Hälfte der R im Camp entfernen'), findsOneWidget);
    });

    for (final compact in [false, true]) {
      testWidgets('fits a long title on one line (compact: $compact)', (
        tester,
      ) async {
        await tester.pumpApp(
          RepressionCardView(
            title: 'Versammlungsverbot',
            description: '',
            kind: RepressionCardKind.blocking,
            compact: compact,
          ),
        );

        expect(
          tester.widget<Text>(find.text('Versammlungsverbot')).maxLines,
          equals(1),
        );
        expect(
          find.ancestor(
            of: find.text('Versammlungsverbot'),
            matching: find.byType(FittedBox),
          ),
          findsOneWidget,
        );
      });
    }

    testWidgets('hides the description when compact', (tester) async {
      await tester.pumpApp(card(compact: true));

      expect(find.text('Hälfte der R im Camp entfernen'), findsNothing);
    });

    testWidgets('has a thick border when blocking', (tester) async {
      await tester.pumpApp(card(kind: RepressionCardKind.blocking));

      final border = decorationOf(tester).border! as Border;
      expect(border.top.width, equals(4));
    });

    testWidgets('has a thin border when immediate', (tester) async {
      await tester.pumpApp(card());

      final border = decorationOf(tester).border! as Border;
      expect(border.top.width, equals(1));
    });

    testWidgets('shows the one-time symbol only for one-time cards', (
      tester,
    ) async {
      await tester.pumpApp(card(kind: RepressionCardKind.oneTime));
      expect(_iconFinder(HambiIconData.oneTime), findsOneWidget);

      await tester.pumpApp(card());
      expect(_iconFinder(HambiIconData.oneTime), findsNothing);
    });

    testWidgets('is 200 × 280 logical pixels', (tester) async {
      await tester.pumpApp(card());

      expect(
        tester.getSize(find.byType(RepressionCardView)),
        equals(const Size(200, 280)),
      );
    });

    testWidgets('AC-061: grows with 200 % text instead of overflowing', (
      tester,
    ) async {
      setTextScale(tester, 2);
      await tester.pumpApp(
        const SingleChildScrollView(
          child: RepressionCardView(
            title: 'Razzia',
            description:
                'Die Hälfte der Ressourcen im Camp wird entfernt. '
                'Rundet dabei zu euren Ungunsten.',
            kind: RepressionCardKind.immediate,
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(
        tester.getSize(find.byType(RepressionCardView)).height,
        greaterThan(280),
      );
    });

    testWidgets('AC-061: fits 200 % text into the compact card', (
      tester,
    ) async {
      setTextScale(tester, 2);
      await tester.pumpApp(card(compact: true));

      expect(tester.takeException(), isNull);
    });

    testWidgets('UX-10: calls onTap when tapped', (tester) async {
      var taps = 0;
      await tester.pumpApp(
        RepressionCardView(
          title: 'Razzia',
          description: 'Hälfte der R im Camp entfernen',
          kind: RepressionCardKind.immediate,
          compact: true,
          onTap: () => taps++,
        ),
      );

      await tester.tap(find.byType(RepressionCardView));

      expect(taps, equals(1));
    });

    testWidgets('UX-07: calls onLongPress when long pressed', (tester) async {
      var longPresses = 0;
      await tester.pumpApp(
        RepressionCardView(
          title: 'Razzia',
          description: 'Hälfte der R im Camp entfernen',
          kind: RepressionCardKind.immediate,
          compact: true,
          onLongPress: () => longPresses++,
        ),
      );

      await tester.longPress(find.byType(RepressionCardView));

      expect(longPresses, equals(1));
    });

    testWidgets('UX-07: offers the long press to screen readers', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      var longPresses = 0;
      await tester.pumpApp(
        RepressionCardView(
          title: 'Razzia',
          description: 'Hälfte der R im Camp entfernen',
          kind: RepressionCardKind.immediate,
          compact: true,
          onLongPress: () => longPresses++,
        ),
      );

      tester.semantics.longPress(
        find.semantics.byAction(SemanticsAction.longPress),
      );

      expect(longPresses, equals(1));
      semantics.dispose();
    });

    testWidgets('is 113 × 56 logical pixels when compact', (tester) async {
      await tester.pumpApp(card(compact: true));

      expect(
        tester.getSize(find.byType(RepressionCardView)),
        equals(const Size(113, 56)),
      );
    });
  });
}

Finder _iconFinder(HambiIconData icon) => find.byWidgetPredicate(
  (widget) => widget is HambiIcon && widget.icon == icon,
);
