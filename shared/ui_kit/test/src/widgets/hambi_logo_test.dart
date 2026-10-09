import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(HambiLogo, () {
    testWidgets('AC-070: renders the original logo', (tester) async {
      await tester.pumpApp(const HambiLogo(semanticLabel: 'Hambi bleibt!'));

      final image = tester.widget<Image>(find.byType(Image)).image;
      expect(
        image,
        isA<AssetImage>()
            .having(
              (image) => image.assetName,
              'assetName',
              'assets/images/logo.png',
            )
            .having((image) => image.package, 'package', 'ui_kit'),
      );
    });

    testWidgets('AC-070: exposes the semantic label', (tester) async {
      await tester.pumpApp(const HambiLogo(semanticLabel: 'Hambi bleibt!'));

      expect(find.bySemanticsLabel('Hambi bleibt!'), findsOneWidget);
    });

    testWidgets('is 280 logical pixels wide by default', (tester) async {
      await tester.pumpApp(const HambiLogo(semanticLabel: 'Hambi bleibt!'));

      expect(tester.getSize(find.byType(HambiLogo)).width, equals(280));
    });

    testWidgets('scales to the given width', (tester) async {
      await tester.pumpApp(
        const HambiLogo(semanticLabel: 'Hambi bleibt!', width: 200),
      );

      expect(tester.getSize(find.byType(HambiLogo)).width, equals(200));
    });
  });
}
