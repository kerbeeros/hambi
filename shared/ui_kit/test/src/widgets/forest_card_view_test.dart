import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(ForestCardView, () {
    List<HambiIconData> iconsOf(WidgetTester tester) => tester
        .widgetList<HambiIcon>(find.byType(HambiIcon))
        .map((icon) => icon.icon)
        .toList();

    String? motifOf(WidgetTester tester) => tester
        .widgetList<SvgPicture>(find.byType(SvgPicture))
        .map((picture) => picture.bytesLoader)
        .whereType<SvgAssetLoader>()
        .map((loader) => 'packages/${loader.packageName}/${loader.assetName}')
        .singleOrNull;

    testWidgets('AC-071: renders the original motif on an intact card', (
      tester,
    ) async {
      await tester.pumpApp(
        const ForestCardView(state: ForestCardViewState.intact, motif: 5),
      );

      expect(
        motifOf(tester),
        equals('packages/ui_kit/assets/images/forest/forest_intact_05.svg'),
      );
    });

    testWidgets('AC-071: renders the original motif on a cleared card', (
      tester,
    ) async {
      await tester.pumpApp(
        const ForestCardView(state: ForestCardViewState.cleared, motif: 11),
      );

      expect(
        motifOf(tester),
        equals('packages/ui_kit/assets/images/forest/forest_cleared_11.svg'),
      );
    });

    testWidgets('AC-071: renders no motif on a removed card', (tester) async {
      await tester.pumpApp(
        const ForestCardView(state: ForestCardViewState.removed, motif: 3),
      );

      expect(motifOf(tester), isNull);
    });

    for (final state in [
      ForestCardViewState.intact,
      ForestCardViewState.cleared,
    ]) {
      testWidgets('AC-071: renders the motif instead of symbols when '
          '${state.name}', (tester) async {
        await tester.pumpApp(ForestCardView(state: state, motif: 0));

        expect(find.byType(HambiIcon), findsNothing);
      });
    }

    for (final (occupant, icon) in [
      (ForestCardOccupant.activist, HambiIconData.activist),
      (ForestCardOccupant.secu, HambiIconData.secu),
    ]) {
      testWidgets('renders the ${icon.name} on the card', (tester) async {
        await tester.pumpApp(
          ForestCardView(
            state: ForestCardViewState.cleared,
            occupant: occupant,
          ),
        );

        expect(iconsOf(tester), contains(icon));
      });
    }

    testWidgets('marks a target with a badge', (tester) async {
      await tester.pumpApp(
        const ForestCardView(state: ForestCardViewState.intact, isTarget: true),
      );

      expect(find.text('!'), findsOneWidget);
    });

    testWidgets('has no badge when it is not a target', (tester) async {
      await tester.pumpApp(
        const ForestCardView(state: ForestCardViewState.intact),
      );

      expect(find.text('!'), findsNothing);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var taps = 0;
      await tester.pumpApp(
        ForestCardView(state: ForestCardViewState.intact, onTap: () => taps++),
      );

      await tester.tap(find.byType(ForestCardView));

      expect(taps, equals(1));
    });

    testWidgets('UX-07: calls onLongPress when long pressed', (tester) async {
      var longPresses = 0;
      await tester.pumpApp(
        ForestCardView(
          state: ForestCardViewState.intact,
          onLongPress: () => longPresses++,
        ),
      );

      await tester.longPress(find.byType(ForestCardView));

      expect(longPresses, equals(1));
    });

    testWidgets('UX-07: offers the long press to screen readers', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      var longPresses = 0;
      await tester.pumpApp(
        ForestCardView(
          state: ForestCardViewState.intact,
          semanticLabel: 'Waldkarte',
          onLongPress: () => longPresses++,
        ),
      );

      tester.semantics.longPress(find.semantics.byLabel('Waldkarte'));

      expect(longPresses, equals(1));
      semantics.dispose();
    });

    testWidgets('AC-062: offers the tap to screen readers', (tester) async {
      final semantics = tester.ensureSemantics();
      var taps = 0;
      await tester.pumpApp(
        ForestCardView(
          state: ForestCardViewState.intact,
          semanticLabel: 'Waldkarte',
          onTap: () => taps++,
        ),
      );

      tester.semantics.tap(find.semantics.byLabel('Waldkarte'));

      expect(taps, equals(1));
      semantics.dispose();
    });

    testWidgets('is 78 × 104 logical pixels', (tester) async {
      await tester.pumpApp(
        const ForestCardView(state: ForestCardViewState.removed),
      );

      expect(
        tester.getSize(find.byType(ForestCardView)),
        equals(const Size(78, 104)),
      );
    });

    testWidgets('exposes the semantic label', (tester) async {
      await tester.pumpApp(
        const ForestCardView(
          state: ForestCardViewState.cleared,
          semanticLabel: 'WS1, Karte 2: abgeholzt',
        ),
      );

      expect(find.bySemanticsLabel('WS1, Karte 2: abgeholzt'), findsOneWidget);
    });
  });
}
