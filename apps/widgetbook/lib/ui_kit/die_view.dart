import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// [DieView] with selectable value.
@widgetbook.UseCase(name: 'Default', type: DieView)
Widget buildDieViewUseCase(BuildContext context) {
  return DieView(
    value: context.knobs.int.slider(
      label: 'Value',
      initialValue: 3,
      min: 1,
      max: 6,
    ),
  );
}
