import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// [SuccessTrack] with the repression fields of the board (R-090).
@widgetbook.UseCase(name: 'Default', type: SuccessTrack)
Widget buildSuccessTrackUseCase(BuildContext context) {
  final kind = context.knobs.object.dropdown(
    label: 'Kind',
    options: SuccessTrackKind.values,
    labelBuilder: (kind) => kind.name,
  );
  final value = context.knobs.int.slider(
    label: 'Value',
    initialValue: 5,
    max: SuccessTrack.maxValue,
  );
  final fields = switch (kind) {
    SuccessTrackKind.activists => {2, 4, 6, 8},
    SuccessTrackKind.support => {4, 6, 7, 10},
  };
  return SizedBox(
    width: 361,
    child: SuccessTrack(
      kind: kind,
      value: value,
      repressionFields: fields,
      activatedFields: {
        for (final field in fields)
          if (field <= value) field,
      },
      compact: context.knobs.boolean(label: 'Compact', initialValue: true),
    ),
  );
}
