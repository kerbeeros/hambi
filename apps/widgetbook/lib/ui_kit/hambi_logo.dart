import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// [HambiLogo] with adjustable width.
@widgetbook.UseCase(name: 'Default', type: HambiLogo)
Widget buildHambiLogoUseCase(BuildContext context) {
  return HambiLogo(
    semanticLabel: 'Hambi bleibt!',
    width: context.knobs.double.slider(
      label: 'Width',
      initialValue: HambiLogo.defaultWidth,
      min: 120,
      max: 400,
    ),
  );
}
