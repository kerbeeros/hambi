import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// [RollingDieView] that rolls until switched off.
@widgetbook.UseCase(name: 'Default', type: RollingDieView)
Widget buildRollingDieViewUseCase(BuildContext context) {
  return RollingDieView(
    value: context.knobs.int.slider(
      label: 'Value',
      initialValue: 3,
      min: 1,
      max: 6,
    ),
    rolling: context.knobs.boolean(label: 'Rolling', initialValue: true),
  );
}
