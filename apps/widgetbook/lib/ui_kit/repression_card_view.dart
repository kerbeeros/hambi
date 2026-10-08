import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// [RepressionCardView] with selectable kind and size.
@widgetbook.UseCase(name: 'Default', type: RepressionCardView)
Widget buildRepressionCardViewUseCase(BuildContext context) {
  return RepressionCardView(
    title: context.knobs.string(label: 'Title', initialValue: 'Razzia'),
    description: context.knobs.string(
      label: 'Description',
      initialValue: 'Die Hälfte der Ressourcen im Camp wird entfernt.',
    ),
    kind: context.knobs.object.dropdown(
      label: 'Kind',
      options: RepressionCardKind.values,
      labelBuilder: (kind) => kind.name,
    ),
    compact: context.knobs.boolean(label: 'Compact'),
  );
}
