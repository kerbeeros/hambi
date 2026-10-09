import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// [CardFlipView] turning a repression card over.
@widgetbook.UseCase(name: 'Repression card', type: CardFlipView)
Widget buildCardFlipViewUseCase(BuildContext context) {
  return CardFlipView(
    revealed: context.knobs.boolean(label: 'Revealed'),
    back: const RepressionCardBackView(),
    front: const RepressionCardView(
      title: 'Razzia',
      description: 'Die Hälfte der Ressourcen im Camp wird entfernt.',
      kind: RepressionCardKind.immediate,
    ),
  );
}
