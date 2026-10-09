import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(CardFlipView, () {
    const front = Text('front');
    const back = Text('back');

    testWidgets('shows the back when not revealed', (tester) async {
      await tester.pumpApp(
        const CardFlipView(front: front, back: back, revealed: false),
      );

      expect(find.text('back'), findsOneWidget);
      expect(find.text('front'), findsNothing);
    });

    testWidgets('shows the front when revealed', (tester) async {
      await tester.pumpApp(
        const CardFlipView(front: front, back: back, revealed: true),
      );

      expect(find.text('front'), findsOneWidget);
      expect(find.text('back'), findsNothing);
    });

    group('when revealed turns on', () {
      testWidgets('still shows the back halfway through the first half', (
        tester,
      ) async {
        await tester.pumpApp(
          const CardFlipView(front: front, back: back, revealed: false),
        );

        await tester.pumpApp(
          const CardFlipView(front: front, back: back, revealed: true),
        );
        await tester.pump(AppDuration.cardFlip * 0.25);

        expect(find.text('back'), findsOneWidget);
      });

      testWidgets('shows the front once the flip is done', (tester) async {
        await tester.pumpApp(
          const CardFlipView(front: front, back: back, revealed: false),
        );

        await tester.pumpApp(
          const CardFlipView(front: front, back: back, revealed: true),
        );
        await tester.pump(AppDuration.cardFlip);

        expect(find.text('front'), findsOneWidget);
        expect(find.text('back'), findsNothing);
      });

      testWidgets('turns at once when animations are disabled', (tester) async {
        Widget flip({required bool revealed}) => MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: CardFlipView(front: front, back: back, revealed: revealed),
        );
        await tester.pumpApp(flip(revealed: false));

        await tester.pumpApp(flip(revealed: true));
        await tester.pump();

        expect(find.text('front'), findsOneWidget);
      });
    });

    testWidgets('turns back when revealed turns off', (tester) async {
      await tester.pumpApp(
        const CardFlipView(front: front, back: back, revealed: true),
      );

      await tester.pumpApp(
        const CardFlipView(front: front, back: back, revealed: false),
      );
      await tester.pump(AppDuration.cardFlip);

      expect(find.text('back'), findsOneWidget);
    });
  });
}
