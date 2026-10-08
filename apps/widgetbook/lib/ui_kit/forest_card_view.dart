import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// [ForestCardView] with selectable state, occupant and target marker.
@widgetbook.UseCase(name: 'Default', type: ForestCardView)
Widget buildForestCardViewUseCase(BuildContext context) {
  return ForestCardView(
    state: context.knobs.object.dropdown(
      label: 'State',
      options: ForestCardViewState.values,
      labelBuilder: (state) => state.name,
    ),
    occupant: context.knobs.object.dropdown(
      label: 'Occupant',
      options: ForestCardOccupant.values,
      labelBuilder: (occupant) => occupant.name,
    ),
    isTarget: context.knobs.boolean(label: 'Target'),
    onTap: () {},
  );
}
