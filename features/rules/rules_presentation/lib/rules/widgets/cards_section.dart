import 'package:flutter/material.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:game_presentation/l10n/l10n.dart' show GameLocalizations;
import 'package:rules_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

/// {@template cards_section}
/// All action cards on side A and all repression cards; tapping a card
/// shows its detail (UX-10, D-08).
/// {@endtemplate}
class CardsSection extends StatelessWidget {
  /// {@macro cards_section}
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final gameL10n = GameLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.cardsHint, style: AppTextStyle.bodyDefault),
        for (final (category, title) in [
          (ActionCardCategory.directAction, gameL10n.sectionDirectActions),
          (ActionCardCategory.campaign, gameL10n.sectionCampaigns),
          (ActionCardCategory.support, gameL10n.sectionSupport),
        ])
          _CardGroup(
            title: title,
            children: [
              for (final card in ActionCardId.values)
                if (card.category == category)
                  ActionCardView(
                    category: category,
                    title: card.title(gameL10n),
                    conditions: card.conditions(CardSide.a),
                    effects: card.effects(CardSide.a),
                    // Without a game there is no status (UX-10).
                    semanticLabel: card.semanticLabel(
                      gameL10n,
                      side: CardSide.a,
                      status: AssignmentStatus.available,
                    ),
                    onTap: () =>
                        CardDetailDialog.showActionCard(context, card: card),
                  ),
            ],
          ),
        _CardGroup(
          title: l10n.cardsRepressionTitle,
          children: [
            for (final card in RepressionCard.values)
              RepressionCardView(
                title: card.title(gameL10n),
                description: card.description(gameL10n),
                kind: card.kind,
                compact: true,
                onTap: () =>
                    CardDetailDialog.showRepressionCard(context, card: card),
              ),
          ],
        ),
      ],
    );
  }
}

class _CardGroup extends StatelessWidget {
  const new({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyle.label),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: children,
          ),
        ],
      ),
    );
  }
}
