import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(SuccessTrack, () {
    testWidgets('renders the value', (tester) async {
      await tester.pumpApp(
        const SuccessTrack(kind: SuccessTrackKind.activists, value: 7),
      );

      expect(find.text('7'), findsOneWidget);
    });

    for (final (kind, icon) in [
      (SuccessTrackKind.activists, HambiIconData.activist),
      (SuccessTrackKind.support, HambiIconData.support),
    ]) {
      testWidgets('renders the ${icon.name} icon for $kind', (tester) async {
        await tester.pumpApp(SuccessTrack(kind: kind, value: 0));

        expect(
          tester.widget<HambiIcon>(find.byType(HambiIcon)).icon,
          equals(icon),
        );
      });
    }

    testWidgets('marks activated repression fields', (tester) async {
      await tester.pumpApp(
        const SuccessTrack(
          kind: SuccessTrackKind.activists,
          value: 5,
          repressionFields: {2, 4, 6, 8},
          activatedFields: {2, 4},
        ),
      );

      expect(find.byType(RepressionSymbol), findsNWidgets(2));
    });

    testWidgets('uses 22 pixel cells when compact', (tester) async {
      await tester.pumpApp(
        const SuccessTrack(kind: SuccessTrackKind.support, value: 0),
      );

      expect(tester.getSize(find.byType(SuccessTrack)).height, equals(22));
    });

    testWidgets('uses 26 pixel cells when not compact', (tester) async {
      await tester.pumpApp(
        const SuccessTrack(
          kind: SuccessTrackKind.support,
          value: 0,
          compact: false,
        ),
      );

      expect(tester.getSize(find.byType(SuccessTrack)).height, equals(26));
    });

    testWidgets('exposes the semantic label', (tester) async {
      await tester.pumpApp(
        const SuccessTrack(
          kind: SuccessTrackKind.support,
          value: 3,
          semanticLabel: 'Unterstützung 3 von 11',
        ),
      );

      expect(find.bySemanticsLabel('Unterstützung 3 von 11'), findsOneWidget);
    });

    for (final value in [-1, 12]) {
      test('rejects the value $value', () {
        expect(
          () => SuccessTrack(kind: SuccessTrackKind.support, value: value),
          throwsAssertionError,
        );
      });
    }
  });
}
