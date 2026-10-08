import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(HambiButton, () {
    testWidgets('renders label', (tester) async {
      await tester.pumpApp(HambiButton(label: 'Weiter', onPressed: () {}));

      expect(find.text('Weiter'), findsOneWidget);
    });

    testWidgets('renders $FilledButton for primary style', (tester) async {
      await tester.pumpApp(HambiButton(label: 'Weiter', onPressed: () {}));

      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('renders $OutlinedButton for secondary style', (tester) async {
      await tester.pumpApp(
        HambiButton(
          label: 'Zurück',
          onPressed: () {},
          style: HambiButtonStyle.secondary,
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var pressed = 0;
      await tester.pumpApp(
        HambiButton(label: 'Weiter', onPressed: () => pressed++),
      );

      await tester.tap(find.byType(HambiButton));

      expect(pressed, equals(1));
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpApp(const HambiButton(label: 'Weiter', onPressed: null));

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.enabled, isFalse);
    });

    testWidgets('is at least 48 logical pixels high', (tester) async {
      await tester.pumpApp(HambiButton(label: 'Weiter', onPressed: () {}));

      expect(
        tester.getSize(find.byType(HambiButton)).height,
        greaterThanOrEqualTo(48),
      );
    });
  });
}
