import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(HambiIcon, () {
    testWidgets('renders the icon as $SvgPicture', (tester) async {
      await tester.pumpApp(const HambiIcon(HambiIconData.activist));

      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('is 24 logical pixels by default', (tester) async {
      await tester.pumpApp(const HambiIcon(HambiIconData.resource));

      expect(
        tester.getSize(find.byType(HambiIcon)),
        equals(const Size(24, 24)),
      );
    });

    testWidgets('uses the given size', (tester) async {
      await tester.pumpApp(const HambiIcon(HambiIconData.secu, size: 40));

      expect(
        tester.getSize(find.byType(HambiIcon)),
        equals(const Size(40, 40)),
      );
    });

    testWidgets('tints the icon with the given color', (tester) async {
      await tester.pumpApp(
        const HambiIcon(HambiIconData.menu, color: AppColors.textOnDark),
      );

      final picture = tester.widget<SvgPicture>(find.byType(SvgPicture));
      expect(
        picture.colorFilter,
        equals(const ColorFilter.mode(AppColors.textOnDark, BlendMode.srcIn)),
      );
    });

    testWidgets('exposes the semantic label', (tester) async {
      await tester.pumpApp(
        const HambiIcon(HambiIconData.support, semanticLabel: 'Unterstützung'),
      );

      expect(find.bySemanticsLabel('Unterstützung'), findsOneWidget);
    });
  });
}
