import 'package:flutter/material.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game/dialogs/card_detail_dialog.dart';
import 'package:game_presentation/game/view_models/view_models.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

/// {@template action_board}
/// The action board (R-021): direct actions, campaigns with the camp,
/// support and the repression cards in play.
///
/// In the preparation phase, tapping a card assigns it or takes the
/// assignment back (UX-02, F-06). Long pressing a card shows its detail
/// (UX-07).
/// {@endtemplate}
class ActionBoard extends StatelessWidget {
  /// {@macro action_board}
  const new({required this.game, this.onCommand, super.key});

  /// The game to show.
  final GameState game;

  /// Called with the move of a tapped card.
  final ValueChanged<GameCommand>? onCommand;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    List<ActionCardId> cardsOf(ActionCardCategory category) => [
      for (final card in ActionCardId.values)
        if (card.category == category) card,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Section(
          title: l10n.sectionDirectActions,
          children: [
            for (final card in cardsOf(ActionCardCategory.directAction))
              _BoardActionCard(card: card, game: game, onCommand: onCommand),
          ],
        ),
        _Section(
          title: l10n.sectionCampaigns,
          children: [
            for (final card in cardsOf(ActionCardCategory.campaign))
              _BoardActionCard(card: card, game: game, onCommand: onCommand),
            CampCardView(
              title: l10n.campTitle,
              activists: game.camp.activists,
              resources: game.camp.resources,
            ),
          ],
        ),
        _Section(
          title: l10n.sectionSupport,
          children: [
            for (final card in cardsOf(ActionCardCategory.support))
              _BoardActionCard(card: card, game: game, onCommand: onCommand),
          ],
        ),
        if (game.repressionInPlay.isNotEmpty)
          _Section(
            title: l10n.sectionRepressionInPlay,
            children: [
              for (final card in game.repressionInPlay)
                RepressionCardView(
                  title: card.title(l10n),
                  description: card.description(l10n),
                  kind: card.kind,
                  compact: true,
                  onLongPress: () =>
                      CardDetailDialog.showRepressionCard(context, card: card),
                ),
            ],
          ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const new({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
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

class _BoardActionCard extends StatelessWidget {
  const new({required this.card, required this.game, required this.onCommand});

  final ActionCardId card;
  final GameState game;
  final ValueChanged<GameCommand>? onCommand;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final side = game.cardSides[card]!;
    final status = game.assignmentStatus(card);
    final onCommand = this.onCommand;
    final command = switch (status) {
      AssignmentStatus.available => AssignToCard(card),
      AssignmentStatus.assigned => UndoAssignment(card),
      _ => null,
    };
    return ActionCardView(
      category: card.category,
      title: card.title(l10n),
      sideLabel: side == CardSide.b ? l10n.cardSideB : null,
      conditions: card.conditions(side),
      effects: card.effects(side),
      status: status.viewStatus,
      statusLabel: status.label(l10n),
      semanticLabel: card.semanticLabel(l10n, side: side, status: status),
      onTap: command != null && onCommand != null
          ? () => onCommand(command)
          : null,
      onLongPress: () =>
          CardDetailDialog.showActionCard(context, game: game, card: card),
    );
  }
}
