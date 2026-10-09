import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rules_presentation/rules_presentation.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// The rules (S-05) on a selectable section.
@widgetbook.UseCase(name: 'Rules', type: RulesView)
Widget buildRulesViewUseCase(BuildContext context) {
  final section = context.knobs.object.dropdown(
    label: 'Section',
    options: RulesSection.values,
    labelBuilder: (section) => section.name,
  );
  return BlocProvider(
    key: ValueKey(section),
    create: (_) => RulesCubit()..selected(section),
    child: RulesView(onBack: () {}),
  );
}
