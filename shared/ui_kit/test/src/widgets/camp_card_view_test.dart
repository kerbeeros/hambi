import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(CampCardView, () {
    testWidgets('renders title and counts', (tester) async {
      await tester.pumpApp(
        const CampCardView(title: 'Camp', activists: 4, resources: 2),
      );

      expect(find.text('Camp'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('renders activist and resource icons', (tester) async {
      await tester.pumpApp(
        const CampCardView(title: 'Camp', activists: 4, resources: 2),
      );

      final icons = tester
          .widgetList<HambiIcon>(find.byType(HambiIcon))
          .map((icon) => icon.icon);
      expect(icons, equals([HambiIconData.activist, HambiIconData.resource]));
    });

    testWidgets('is 113 × 96 logical pixels', (tester) async {
      await tester.pumpApp(
        const CampCardView(title: 'Camp', activists: 0, resources: 0),
      );

      expect(
        tester.getSize(find.byType(CampCardView)),
        equals(const Size(113, 96)),
      );
    });
  });
}
