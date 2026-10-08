import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// [CampCardView] with editable counts.
@widgetbook.UseCase(name: 'Default', type: CampCardView)
Widget buildCampCardViewUseCase(BuildContext context) {
  return CampCardView(
    title: 'Camp',
    activists: context.knobs.int.slider(
      label: 'Activists',
      initialValue: 3,
      max: 11,
    ),
    resources: context.knobs.int.slider(
      label: 'Resources',
      initialValue: 1,
      max: 8,
    ),
  );
}
