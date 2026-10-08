import 'package:flutter/material.dart';
import 'package:ui_kit/src/icons/icons.dart';
import 'package:ui_kit/src/tokens/tokens.dart';
import 'package:ui_kit/src/widgets/repression_symbol.dart';

/// What a [StatusChip] shows.
enum StatusChipKind {
  /// Free activists in the camp.
  activist,

  /// Resources in the camp.
  resource,

  /// Public support.
  support,

  /// Repression cards threatening in the next repression phase.
  repression,
}

/// {@template status_chip}
/// Compact counter with a symbol, used in the status bar of the board.
/// {@endtemplate}
class StatusChip extends StatelessWidget {
  /// {@macro status_chip}
  const new({
    required this.kind,
    required this.label,
    this.semanticLabel,
    super.key,
  });

  /// What the chip shows.
  final StatusChipKind kind;

  /// Short text, usually a number.
  final String label;

  /// Full description for screen readers, e.g. "5 activists in the camp".
  final String? semanticLabel;

  static const double _height = 28;
  static const double _iconSize = 18;

  @override
  Widget build(BuildContext context) {
    final icon = switch (kind) {
      StatusChipKind.activist => HambiIconData.activist,
      StatusChipKind.resource => HambiIconData.resource,
      StatusChipKind.support => HambiIconData.support,
      StatusChipKind.repression => null,
    };
    final chip = Container(
      height: _height,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        border: Border.all(
          color: kind == StatusChipKind.repression
              ? AppColors.trackRepressionField
              : AppColors.borderSubtle,
        ),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            HambiIcon(icon, size: _iconSize)
          else
            const RepressionSymbol(),
          const SizedBox(width: AppSpacing.xs),
          Text(label, style: AppTextStyle.numberSmall),
        ],
      ),
    );
    final semanticLabel = this.semanticLabel;
    if (semanticLabel == null) return chip;
    return Semantics(label: semanticLabel, excludeSemantics: true, child: chip);
  }
}
