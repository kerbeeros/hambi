import 'package:flutter/material.dart';
import 'package:ui_kit/src/icons/icons.dart';
import 'package:ui_kit/src/tokens/tokens.dart';

/// State shown by a [ForestCardView] (R-001).
enum ForestCardViewState {
  /// Green, untouched forest.
  intact,

  /// Brown, cleared forest.
  cleared,

  /// Removed by the excavator.
  removed,
}

/// Piece standing on a [ForestCardView].
enum ForestCardOccupant {
  /// Nothing.
  none,

  /// An activist protects the card.
  activist,

  /// A security guard blocks the card.
  secu,
}

/// {@template forest_card_view}
/// A forest card with its state and the piece standing on it.
/// {@endtemplate}
class ForestCardView extends StatelessWidget {
  /// {@macro forest_card_view}
  const new({
    required this.state,
    this.occupant = ForestCardOccupant.none,
    this.isTarget = false,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  /// State of the card.
  final ForestCardViewState state;

  /// Piece standing on the card.
  final ForestCardOccupant occupant;

  /// Whether the card is threatened or chosen as a target; shown with a red
  /// border and a badge.
  final bool isTarget;

  /// Description for screen readers.
  final String? semanticLabel;

  /// Called when the card is tapped, e.g. to choose it as a target.
  final VoidCallback? onTap;

  /// Called when the card is long pressed, e.g. to show its details (UX-07).
  final VoidCallback? onLongPress;

  /// Card width in logical pixels.
  static const double width = 78;

  /// Card height in logical pixels.
  static const double height = 104;

  @override
  Widget build(BuildContext context) {
    final (background, symbol) = switch (state) {
      ForestCardViewState.intact => (
        AppColors.forestIntact,
        (HambiIconData.deciduousTree, HambiIconData.fir),
      ),
      ForestCardViewState.cleared => (
        AppColors.forestCleared,
        (HambiIconData.stump, HambiIconData.stump),
      ),
      ForestCardViewState.removed => (AppColors.forestRemoved, null),
    };
    final occupantIcon = switch (occupant) {
      ForestCardOccupant.none => null,
      ForestCardOccupant.activist => HambiIconData.activist,
      ForestCardOccupant.secu => HambiIconData.secu,
    };
    final borderRadius = BorderRadius.circular(AppRadius.card);
    return Semantics(
      label: semanticLabel,
      button: onTap != null,
      onLongPress: onLongPress,
      excludeSemantics: true,
      child: SizedBox(
        width: width,
        height: height,
        child: Material(
          color: background,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: isTarget
                ? const BorderSide(color: AppColors.stateBlocked, width: 3)
                : const BorderSide(color: AppColors.borderDefault),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Stack(
              children: [
                if (symbol case (final first, final second))
                  Positioned(
                    top: AppSpacing.sm,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [HambiIcon(first), HambiIcon(second)],
                    ),
                  ),
                if (occupantIcon != null)
                  Positioned(
                    bottom: AppSpacing.md,
                    left: 0,
                    right: 0,
                    child: Center(child: HambiIcon(occupantIcon, size: 36)),
                  ),
                if (isTarget)
                  const Positioned(
                    top: AppSpacing.xs,
                    right: AppSpacing.xs,
                    child: _TargetBadge(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TargetBadge extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.stateBlocked,
        shape: BoxShape.circle,
      ),
      child: Text(
        '!',
        style: AppTextStyle.numberSmall.copyWith(color: AppColors.textOnDark),
      ),
    );
  }
}
