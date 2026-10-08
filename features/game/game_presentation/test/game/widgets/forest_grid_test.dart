import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(ForestGrid, () {
    testWidgets('R-020: renders 3 columns of 4 forest cards', (tester) async {
      await tester.pumpApp(ForestGrid(forest: Forest.initial()));

      expect(find.byType(ForestCardView), findsNWidgets(12));
      for (final label in ['WS1', 'WS2', 'WS3']) {
        expect(find.text(label), findsOneWidget);
      }
    });

    testWidgets('marks threatened cards as targets', (tester) async {
      await tester.pumpApp(
        ForestGrid(
          forest: Forest.initial().replace(
            column: 0,
            position: 0,
            card: const ForestCard(hasActivist: true),
          ),
        ),
      );

      final targets = tester
          .widgetList<ForestCardView>(find.byType(ForestCardView))
          .where((card) => card.isTarget);
      expect(targets, hasLength(2));
    });

    testWidgets('calls onCardTap with the position of selectable cards', (
      tester,
    ) async {
      final tapped = <ForestPosition>[];
      await tester.pumpApp(
        ForestGrid(
          forest: Forest.initial(),
          isSelectable: (position) => position.column == 1,
          onCardTap: tapped.add,
        ),
      );

      await tester.tap(find.bySemanticsLabel(RegExp('^WS2, Karte 3')));
      await tester.tap(find.bySemanticsLabel(RegExp('^WS1, Karte 1')));

      expect(tapped, equals([const ForestPosition(column: 1, position: 2)]));
    });

    testWidgets('dims cards that cannot be selected', (tester) async {
      await tester.pumpApp(
        ForestGrid(
          forest: Forest.initial(),
          isSelectable: (position) => position.column == 0,
          onCardTap: (_) {},
        ),
      );

      final dimmed = tester
          .widgetList<Opacity>(find.byType(Opacity))
          .where((opacity) => opacity.opacity < 1);
      expect(dimmed, hasLength(8));
    });

    testWidgets('does not dim cards outside a selection', (tester) async {
      await tester.pumpApp(ForestGrid(forest: Forest.initial()));

      expect(find.byType(Opacity), findsNothing);
    });

    testWidgets('marks selected cards as targets', (tester) async {
      await tester.pumpApp(
        ForestGrid(
          forest: Forest.initial(),
          showThreats: false,
          selected: {const ForestPosition(column: 2, position: 3)},
        ),
      );

      final targets = tester
          .widgetList<ForestCardView>(find.byType(ForestCardView))
          .where((card) => card.isTarget);
      expect(targets, hasLength(1));
    });

    testWidgets('UX-07: long pressing a card shows its detail', (tester) async {
      await tester.pumpApp(
        ForestGrid(forest: Forest.initial(), showsDetails: true),
      );

      await tester.longPress(find.byType(ForestCardView).at(5));
      await tester.pumpAndSettle();

      final detail = tester.widget<ForestCardDetail>(
        find.byType(ForestCardDetail),
      );
      expect(
        detail.position,
        equals(const ForestPosition(column: 1, position: 1)),
      );
      expect(detail.isThreatened, isFalse);
    });

    testWidgets('UX-07: marks a threatened card in its detail', (tester) async {
      await tester.pumpApp(
        ForestGrid(forest: Forest.initial(), showsDetails: true),
      );

      await tester.longPress(find.byType(ForestCardView).first);
      await tester.pumpAndSettle();

      expect(
        tester
            .widget<ForestCardDetail>(find.byType(ForestCardDetail))
            .isThreatened,
        isTrue,
      );
    });

    testWidgets('shows no detail unless showsDetails', (tester) async {
      await tester.pumpApp(ForestGrid(forest: Forest.initial()));

      await tester.longPress(find.byType(ForestCardView).first);
      await tester.pumpAndSettle();

      expect(find.byType(ForestCardDetail), findsNothing);
    });
  });
}
