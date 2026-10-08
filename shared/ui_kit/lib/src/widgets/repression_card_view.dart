import 'package:flutter/material.dart';
import 'package:ui_kit/src/icons/icons.dart';
import 'package:ui_kit/src/tokens/tokens.dart';

/// How a repression card is handled (R-050–R-065).
enum RepressionCardKind {
  /// Executed at once.
  immediate,

  /// Blocks an action card for a round; shown with a thick border.
  blocking,

  /// Removed from the game after use; shown with the ⦸ symbol.
  oneTime,
}

/// {@template repression_card_view}
/// A repression card, large in dialogs or [compact] on the board.
/// {@endtemplate}
class RepressionCardView extends StatelessWidget {
  /// {@macro repression_card_view}
  const new({
    required this.title,
    required this.description,
    required this.kind,
    this.compact = false,
    super.key,
  });

  /// Card title.
  final String title;

  /// Effect of the card; hidden when [compact].
  final String description;

  /// How the card is handled.
  final RepressionCardKind kind;

  /// Whether to show the small board variant.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final (width, height) = compact ? (113.0, 56.0) : (200.0, 280.0);
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(compact ? AppSpacing.sm : AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.cardRepression,
        border: Border.all(
          color: AppColors.borderDefault,
          width: kind == RepressionCardKind.blocking ? 4 : 1,
        ),
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: compact
                        ? AppTextStyle.cardTitle
                        : AppTextStyle.headingH2,
                    maxLines: 1,
                  ),
                ),
              ),
              if (kind == RepressionCardKind.oneTime)
                HambiIcon(HambiIconData.oneTime, size: compact ? 16 : 24),
            ],
          ),
          if (!compact) ...[
            const SizedBox(height: AppSpacing.md),
            Text(description, style: AppTextStyle.bodySmall),
          ],
        ],
      ),
    );
  }
}
