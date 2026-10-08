import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(DieView, () {
    testWidgets('is 40 × 40 logical pixels', (tester) async {
      await tester.pumpApp(const DieView(value: 3));

      expect(tester.getSize(find.byType(DieView)), equals(const Size(40, 40)));
    });

    testWidgets('exposes the semantic label', (tester) async {
      await tester.pumpApp(
        const DieView(value: 5, semanticLabel: 'Würfel zeigt 5'),
      );

      expect(find.bySemanticsLabel('Würfel zeigt 5'), findsOneWidget);
    });

    for (final value in [0, 7]) {
      test('rejects the value $value', () {
        expect(() => DieView(value: value), throwsAssertionError);
      });
    }
  });
}
