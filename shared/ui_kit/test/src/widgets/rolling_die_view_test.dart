import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(RollingDieView, () {
    int shownValue(WidgetTester tester) =>
        tester.widget<DieView>(find.byType(DieView)).value;

    testWidgets('shows the value when not rolling', (tester) async {
      await tester.pumpApp(const RollingDieView(value: 4, rolling: false));

      expect(shownValue(tester), equals(4));
    });

    testWidgets('changes its face while rolling', (tester) async {
      await tester.pumpApp(const RollingDieView(value: 4, rolling: true));
      final first = shownValue(tester);

      await tester.pump(AppDuration.dieFace);

      expect(shownValue(tester), isNot(equals(first)));
    });

    testWidgets('settles on the value when rolling stops', (tester) async {
      await tester.pumpApp(const RollingDieView(value: 4, rolling: true));
      await tester.pump(AppDuration.dieFace * 3);

      await tester.pumpApp(const RollingDieView(value: 4, rolling: false));
      await tester.pump(AppDuration.dieFace);

      expect(shownValue(tester), equals(4));
    });

    testWidgets('starts rolling when rolling turns on', (tester) async {
      await tester.pumpApp(const RollingDieView(value: 4, rolling: false));

      await tester.pumpApp(const RollingDieView(value: 4, rolling: true));
      await tester.pump(AppDuration.dieFace);

      expect(shownValue(tester), isNot(equals(4)));
    });

    testWidgets('exposes the semantic label when not rolling', (tester) async {
      await tester.pumpApp(
        const RollingDieView(
          value: 5,
          rolling: false,
          semanticLabel: 'Würfel zeigt 5',
        ),
      );

      expect(find.bySemanticsLabel('Würfel zeigt 5'), findsOneWidget);
    });
  });
}
