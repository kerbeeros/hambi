import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(ActionCardView, () {
    Widget card({
      ActionCardStatus status = ActionCardStatus.available,
      String? sideLabel,
      String? statusLabel,
      VoidCallback? onTap,
      VoidCallback? onLongPress,
    }) => ActionCardView(
      category: ActionCardCategory.directAction,
      title: 'Blockade',
      sideLabel: sideLabel,
      conditions: const [CardSymbol.activist, CardSymbol.resource],
      effects: const [CardSymbol.activistToForest],
      status: status,
      statusLabel: statusLabel,
      onTap: onTap,
      onLongPress: onLongPress,
    );

    testWidgets('renders the title', (tester) async {
      await tester.pumpApp(card());

      expect(find.text('Blockade'), findsOneWidget);
    });

    testWidgets('fits a long title into the card', (tester) async {
      await tester.pumpApp(
        const ActionCardView(
          category: ActionCardCategory.support,
          title: 'Autonomes Zentrum',
          conditions: [CardSymbol.activist],
          effects: [CardSymbol.gainResource],
        ),
      );

      final text = tester.widget<Text>(find.text('Autonomes Zentrum'));
      expect(text.overflow, isNot(TextOverflow.ellipsis));
      expect(
        find.ancestor(
          of: find.text('Autonomes Zentrum'),
          matching: find.byType(FittedBox),
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders the side label', (tester) async {
      await tester.pumpApp(card(sideLabel: 'B'));

      expect(find.text('B'), findsOneWidget);
    });

    testWidgets('renders conditions and effects as symbols', (tester) async {
      await tester.pumpApp(card());

      expect(find.byType(CardSymbolView), findsNWidgets(3));
    });

    testWidgets('marks an assigned card with a check', (tester) async {
      await tester.pumpApp(card(status: ActionCardStatus.assigned));

      expect(_iconFinder(HambiIconData.check), findsOneWidget);
    });

    testWidgets('marks a blocked card with a lock', (tester) async {
      await tester.pumpApp(card(status: ActionCardStatus.blocked));

      expect(_iconFinder(HambiIconData.lock), findsOneWidget);
    });

    testWidgets('dims an unavailable card', (tester) async {
      await tester.pumpApp(card(status: ActionCardStatus.unavailable));

      final opacity = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacity.opacity, lessThan(1));
    });

    testWidgets('renders the status label', (tester) async {
      await tester.pumpApp(
        card(status: ActionCardStatus.unavailable, statusLabel: 'Zu wenig R'),
      );

      expect(find.text('Zu wenig R'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var taps = 0;
      await tester.pumpApp(card(onTap: () => taps++));

      await tester.tap(find.byType(ActionCardView));

      expect(taps, equals(1));
    });

    testWidgets('UX-07: calls onLongPress when long pressed', (tester) async {
      var longPresses = 0;
      await tester.pumpApp(card(onLongPress: () => longPresses++));

      await tester.longPress(find.byType(ActionCardView));

      expect(longPresses, equals(1));
    });

    testWidgets('UX-07: offers the long press to screen readers', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      var longPresses = 0;
      await tester.pumpApp(
        ActionCardView(
          category: ActionCardCategory.support,
          title: 'Baumarkt',
          conditions: const [CardSymbol.activist],
          effects: const [CardSymbol.gainResource],
          semanticLabel: 'Baumarkt',
          onLongPress: () => longPresses++,
        ),
      );

      tester.semantics.longPress(find.semantics.byLabel('Baumarkt'));

      expect(longPresses, equals(1));
      semantics.dispose();
    });

    testWidgets('is 113 × 96 logical pixels', (tester) async {
      await tester.pumpApp(card());

      expect(
        tester.getSize(find.byType(ActionCardView)),
        equals(const Size(113, 96)),
      );
    });

    testWidgets('exposes the semantic label', (tester) async {
      await tester.pumpApp(
        const ActionCardView(
          category: ActionCardCategory.support,
          title: 'Baumarkt',
          conditions: [CardSymbol.activist],
          effects: [CardSymbol.gainResource],
          semanticLabel: 'Baumarkt: 1 M, bringt 1 R',
        ),
      );

      expect(
        find.bySemanticsLabel('Baumarkt: 1 M, bringt 1 R'),
        findsOneWidget,
      );
    });
  });

  group(CardSymbolView, () {
    testWidgets('renders icons in the given size', (tester) async {
      await tester.pumpApp(const CardSymbolView(CardSymbol.activist, size: 14));

      expect(
        tester.getSize(find.byType(HambiIcon)),
        equals(const Size(14, 14)),
      );
    });

    for (final (symbol, icons, text) in [
      (CardSymbol.activist, [HambiIconData.activist], null),
      (CardSymbol.resource, [HambiIconData.resource], null),
      (CardSymbol.loseSupport, [HambiIconData.support], '−'),
      (CardSymbol.gainSupport, [HambiIconData.support], '+'),
      (CardSymbol.gainActivist, [HambiIconData.activist], '+'),
      (CardSymbol.gainResource, [HambiIconData.resource], '+'),
      (
        CardSymbol.activistToForest,
        [HambiIconData.activist, HambiIconData.arrow, HambiIconData.fir],
        null,
      ),
      (CardSymbol.rerollDie, [HambiIconData.die, HambiIconData.reroll], null),
      (CardSymbol.preventRepression, <HambiIconData>[], '−'),
    ]) {
      testWidgets('renders $symbol', (tester) async {
        await tester.pumpApp(CardSymbolView(symbol));

        expect(
          tester
              .widgetList<HambiIcon>(find.byType(HambiIcon))
              .map((icon) => icon.icon),
          equals(icons),
        );
        if (text != null) expect(find.text(text), findsOneWidget);
      });
    }
  });
}

Finder _iconFinder(HambiIconData icon) => find.byWidgetPredicate(
  (widget) => widget is HambiIcon && widget.icon == icon,
);
