import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rules_presentation/l10n/l10n.dart';
import 'package:rules_presentation/rules/cubit/cubit.dart';
import 'package:rules_presentation/rules/widgets/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

/// {@template rules_view}
/// The rules (S-05, F-05): idea, flow, symbols and cards as tabs (UX-10).
///
/// Needs a [RulesCubit] above it, see `RulesModule`.
/// {@endtemplate}
class RulesView extends StatelessWidget {
  /// {@macro rules_view}
  const new({required this.onBack, super.key});

  /// Returns to the screen the rules were opened from.
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.watch<RulesCubit>();
    final section = cubit.state;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.rulesTitle, style: AppTextStyle.headingH1),
              const SizedBox(height: AppSpacing.md),
              BoardTabs(
                tabs: [
                  for (final section in RulesSection.values)
                    BoardTab(label: _label(l10n, section)),
                ],
                selectedIndex: section.index,
                onSelected: (index) =>
                    cubit.selected(RulesSection.values[index]),
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: SingleChildScrollView(
                  child: switch (section) {
                    RulesSection.idea => const IdeaSection(),
                    RulesSection.flow => const FlowSection(),
                    RulesSection.symbols => const SymbolsSection(),
                    RulesSection.cards => const CardsSection(),
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              HambiButton(
                label: l10n.backAction,
                style: HambiButtonStyle.secondary,
                onPressed: onBack,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _label(RulesLocalizations l10n, RulesSection section) =>
      switch (section) {
        RulesSection.idea => l10n.tabIdea,
        RulesSection.flow => l10n.tabFlow,
        RulesSection.symbols => l10n.tabSymbols,
        RulesSection.cards => l10n.tabCards,
      };
}
