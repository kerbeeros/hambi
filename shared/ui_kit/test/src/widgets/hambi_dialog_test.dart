import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(HambiDialog, () {
    testWidgets('renders title, content and actions', (tester) async {
      await tester.pumpApp(
        HambiDialog(
          title: 'Negative Presse',
          content: const Text('Was verliert ihr?'),
          actions: [HambiButton(label: 'U −1', onPressed: () {})],
        ),
      );

      expect(find.text('Negative Presse'), findsOneWidget);
      expect(find.text('Was verliert ihr?'), findsOneWidget);
      expect(find.text('U −1'), findsOneWidget);
    });

    testWidgets('renders plain content text in the body style', (tester) async {
      await tester.pumpApp(
        const HambiDialog(title: 'Titel', content: Text('Inhalt')),
      );

      expect(
        DefaultTextStyle.of(tester.element(find.text('Inhalt'))).style,
        equals(AppTextStyle.bodyDefault),
      );
    });

    testWidgets('show opens the dialog and returns its result', (tester) async {
      await tester.pumpApp(const SizedBox());
      final context = tester.element(find.byType(SizedBox));

      final result = HambiDialog.show<int>(
        context,
        builder: (dialogContext) => HambiDialog(
          title: 'Würfel',
          content: const SizedBox(),
          actions: [
            HambiButton(
              label: 'OK',
              onPressed: () => Navigator.of(dialogContext).pop(4),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(await result, equals(4));
    });

    testWidgets('show is not dismissible by tapping outside', (tester) async {
      await tester.pumpApp(const SizedBox());
      final context = tester.element(find.byType(SizedBox));

      unawaited(
        HambiDialog.show<void>(
          context,
          builder: (_) =>
              const HambiDialog(title: 'Pflicht', content: SizedBox()),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      expect(find.text('Pflicht'), findsOneWidget);
    });
  });

  group(HambiBottomSheet, () {
    testWidgets('renders title and child', (tester) async {
      await tester.pumpApp(
        const HambiBottomSheet(title: 'Rundenlog', child: Text('Würfel: 3, 5')),
      );

      expect(find.text('Rundenlog'), findsOneWidget);
      expect(find.text('Würfel: 3, 5'), findsOneWidget);
    });

    testWidgets('renders plain child text in the body style', (tester) async {
      await tester.pumpApp(
        const HambiBottomSheet(title: 'Titel', child: Text('Inhalt')),
      );

      expect(
        DefaultTextStyle.of(tester.element(find.text('Inhalt'))).style,
        equals(AppTextStyle.bodyDefault),
      );
    });

    testWidgets('show opens the sheet', (tester) async {
      await tester.pumpApp(const SizedBox());
      final context = tester.element(find.byType(SizedBox));

      unawaited(
        HambiBottomSheet.show<void>(
          context,
          builder: (_) =>
              const HambiBottomSheet(title: 'Menü', child: SizedBox()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Menü'), findsOneWidget);
    });
  });
}
