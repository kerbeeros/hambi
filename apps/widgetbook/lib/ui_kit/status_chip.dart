import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// [StatusChip] with selectable kind and label.
@widgetbook.UseCase(name: 'Default', type: StatusChip)
Widget buildStatusChipUseCase(BuildContext context) {
  return StatusChip(
    kind: context.knobs.object.dropdown(
      label: 'Kind',
      options: StatusChipKind.values,
      labelBuilder: (kind) => kind.name,
    ),
    label: context.knobs.string(label: 'Label', initialValue: '5'),
  );
}
