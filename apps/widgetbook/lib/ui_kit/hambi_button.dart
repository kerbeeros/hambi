import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Primary [HambiButton] with editable label and enabled state.
@widgetbook.UseCase(name: 'Primary', type: HambiButton)
Widget buildHambiButtonPrimaryUseCase(BuildContext context) {
  return HambiButton(
    label: context.knobs.string(label: 'Label', initialValue: 'Weiter'),
    onPressed: context.knobs.boolean(label: 'Enabled', initialValue: true)
        ? () {}
        : null,
  );
}

/// Secondary [HambiButton] with editable label and enabled state.
@widgetbook.UseCase(name: 'Secondary', type: HambiButton)
Widget buildHambiButtonSecondaryUseCase(BuildContext context) {
  return HambiButton(
    label: context.knobs.string(label: 'Label', initialValue: 'Zurück'),
    style: HambiButtonStyle.secondary,
    onPressed: context.knobs.boolean(label: 'Enabled', initialValue: true)
        ? () {}
        : null,
  );
}
