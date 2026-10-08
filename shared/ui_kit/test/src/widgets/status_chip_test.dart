import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(StatusChip, () {
    testWidgets('renders the label', (tester) async {
      await tester.pumpApp(
        const StatusChip(kind: StatusChipKind.resource, label: '3'),
      );

      expect(find.text('3'), findsOneWidget);
    });

    for (final (kind, icon) in [
      (StatusChipKind.activist, HambiIconData.activist),
      (StatusChipKind.resource, HambiIconData.resource),
      (StatusChipKind.support, HambiIconData.support),
    ]) {
      testWidgets('renders the ${icon.name} icon for $kind', (tester) async {
        await tester.pumpApp(StatusChip(kind: kind, label: '1'));

        final hambiIcon = tester.widget<HambiIcon>(find.byType(HambiIcon));
        expect(hambiIcon.icon, equals(icon));
      });
    }

    testWidgets('renders no icon for repression', (tester) async {
      await tester.pumpApp(
        const StatusChip(kind: StatusChipKind.repression, label: '2'),
      );

      expect(find.byType(HambiIcon), findsNothing);
    });

    testWidgets('is 28 logical pixels high', (tester) async {
      await tester.pumpApp(
        const StatusChip(kind: StatusChipKind.activist, label: '5'),
      );

      expect(tester.getSize(find.byType(StatusChip)).height, equals(28));
    });

    testWidgets('exposes the semantic label instead of the label', (
      tester,
    ) async {
      await tester.pumpApp(
        const StatusChip(
          kind: StatusChipKind.activist,
          label: '5',
          semanticLabel: '5 Mitstreiter*innen im Camp',
        ),
      );

      expect(
        find.bySemanticsLabel('5 Mitstreiter*innen im Camp'),
        findsOneWidget,
      );
    });
  });
}
