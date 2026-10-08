import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(PhaseStepper, () {
    const labels = ['Vorbereitung', 'Aktion', 'Bagger', 'Repression'];

    testWidgets('renders all phase labels', (tester) async {
      await tester.pumpApp(
        const SizedBox(
          width: 361,
          child: PhaseStepper(labels: labels, activeIndex: 1),
        ),
      );

      for (final label in labels) {
        expect(find.text(label), findsOneWidget);
      }
    });

    testWidgets('marks the active phase as selected', (tester) async {
      await tester.pumpApp(
        const SizedBox(
          width: 361,
          child: PhaseStepper(labels: labels, activeIndex: 2),
        ),
      );

      expect(
        tester.getSemantics(find.text('Bagger')),
        isSemantics(label: 'Bagger', isSelected: true),
      );
      expect(
        tester.getSemantics(find.text('Aktion')),
        isSemantics(label: 'Aktion', isSelected: false),
      );
    });

    testWidgets('marks no phase when activeIndex is null', (tester) async {
      await tester.pumpApp(
        const SizedBox(width: 361, child: PhaseStepper(labels: labels)),
      );

      expect(
        tester.getSemantics(find.text('Vorbereitung')),
        isSemantics(label: 'Vorbereitung', isSelected: false),
      );
    });
  });
}
