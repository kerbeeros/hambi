import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// [ActionCardView] with selectable category, status and side.
@widgetbook.UseCase(name: 'Default', type: ActionCardView)
Widget buildActionCardViewUseCase(BuildContext context) {
  final status = context.knobs.object.dropdown(
    label: 'Status',
    options: ActionCardStatus.values,
    labelBuilder: (status) => status.name,
  );
  return ActionCardView(
    category: context.knobs.object.dropdown(
      label: 'Category',
      options: ActionCardCategory.values,
      labelBuilder: (category) => category.name,
    ),
    title: context.knobs.string(label: 'Title', initialValue: 'Blockade'),
    sideLabel: context.knobs.boolean(label: 'Side B') ? 'B' : null,
    conditions: const [CardSymbol.activist, CardSymbol.resource],
    effects: const [CardSymbol.activistToForest],
    status: status,
    statusLabel: switch (status) {
      ActionCardStatus.blocked => 'Blockiert',
      ActionCardStatus.unavailable => 'Zu wenig R',
      _ => null,
    },
    onTap: () {},
  );
}

/// All [CardSymbol]s.
@widgetbook.UseCase(name: 'All', type: CardSymbolView)
Widget buildCardSymbolViewUseCase(BuildContext context) {
  return Wrap(
    spacing: AppSpacing.md,
    runSpacing: AppSpacing.md,
    children: [for (final symbol in CardSymbol.values) CardSymbolView(symbol)],
  );
}
