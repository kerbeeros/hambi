import 'package:flutter/material.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game/dialogs/card_detail_dialog.dart';
import 'package:game_presentation/game/view_models/view_models.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

/// {@template forest_grid}
/// The forest: one row of 4 cards per forest column (R-020).
///
/// Excavator targets without an activist are marked as threatened unless
/// [showThreats] is false; [selected] cards are marked as chosen. With
/// [showsDetails], long pressing a card shows its detail (UX-07).
/// {@endtemplate}
class ForestGrid extends StatelessWidget {
  /// {@macro forest_grid}
  const new({
    required this.forest,
    this.showThreats = true,
    this.selected = const {},
    this.isSelectable,
    this.onCardTap,
    this.showsDetails = false,
    super.key,
  });

  /// The forest to show.
  final Forest forest;

  /// Whether to mark threatened cards.
  final bool showThreats;

  /// Cards marked as chosen, e.g. in a selection dialog.
  final Set<ForestPosition> selected;

  /// Which cards can be tapped; all cards when `null`. Other cards are
  /// dimmed.
  final bool Function(ForestPosition position)? isSelectable;

  /// Called with the position of a tapped card.
  final ValueChanged<ForestPosition>? onCardTap;

  /// Whether long pressing a card shows its detail (D-08).
  final bool showsDetails;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final threatened = showThreats
        ? forest.threatenedPositions
        : const <ForestPosition>{};
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var column = 0; column < Forest.columnCount; column++) ...[
          if (column > 0) const SizedBox(height: AppSpacing.md),
          Text(l10n.columnLabel(column + 1), style: AppTextStyle.label),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (
                var position = 0;
                position < Forest.cardsPerColumn;
                position++
              ) ...[
                if (position > 0) const SizedBox(width: AppSpacing.sm),
                _ForestGridCard(
                  card: forest.columns[column][position],
                  position: ForestPosition(column: column, position: position),
                  isMarked:
                      threatened.contains(
                        ForestPosition(column: column, position: position),
                      ) ||
                      selected.contains(
                        ForestPosition(column: column, position: position),
                      ),
                  isThreatened: threatened.contains(
                    ForestPosition(column: column, position: position),
                  ),
                  isSelectable: isSelectable,
                  onTap: onCardTap,
                  showsDetails: showsDetails,
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}

class _ForestGridCard extends StatelessWidget {
  const new({
    required this.card,
    required this.position,
    required this.isMarked,
    required this.isThreatened,
    required this.isSelectable,
    required this.onTap,
    required this.showsDetails,
  });

  final ForestCard card;
  final ForestPosition position;
  final bool isMarked;
  final bool isThreatened;
  final bool Function(ForestPosition position)? isSelectable;
  final ValueChanged<ForestPosition>? onTap;
  final bool showsDetails;

  static const double _dimmedOpacity = 0.4;

  @override
  Widget build(BuildContext context) {
    final onTap = this.onTap;
    final selectable = isSelectable?.call(position) ?? true;
    final canTap = onTap != null && selectable;
    final view = ForestCardView(
      state: card.viewState,
      motif: position.motif,
      occupant: card.occupant,
      isTarget: isMarked,
      semanticLabel: card.semanticLabel(
        context.l10n,
        column: position.column,
        position: position.position,
        isThreatened: isThreatened,
      ),
      onTap: canTap ? () => onTap(position) : null,
      onLongPress: showsDetails
          ? () => CardDetailDialog.showForestCard(
              context,
              card: card,
              position: position,
              isThreatened: isThreatened,
            )
          : null,
    );
    return selectable ? view : Opacity(opacity: _dimmedOpacity, child: view);
  }
}
