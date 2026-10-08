import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Single [HambiIcon] with selectable icon and size.
@widgetbook.UseCase(name: 'Single', type: HambiIcon)
Widget buildHambiIconSingleUseCase(BuildContext context) {
  return HambiIcon(
    context.knobs.object.dropdown(
      label: 'Icon',
      options: HambiIconData.values,
      labelBuilder: (icon) => icon.name,
    ),
    size: context.knobs.double.slider(
      label: 'Size',
      initialValue: 24,
      min: 16,
      max: 96,
    ),
  );
}

/// All [HambiIconData] icons side by side.
@widgetbook.UseCase(name: 'All', type: HambiIcon)
Widget buildHambiIconAllUseCase(BuildContext context) {
  return Wrap(
    spacing: AppSpacing.md,
    runSpacing: AppSpacing.md,
    children: [
      for (final icon in HambiIconData.values)
        HambiIcon(icon, size: 40, semanticLabel: icon.name),
    ],
  );
}
