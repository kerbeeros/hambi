import 'package:flutter/material.dart';
import 'package:ui_kit/src/icons/icons.dart';
import 'package:ui_kit/src/tokens/tokens.dart';
import 'package:ui_kit/src/widgets/repression_symbol.dart';

/// Which success track is shown (R-007, R-008).
enum SuccessTrackKind {
  /// Activists in play.
  activists,

  /// Public support.
  support,
}

/// {@template success_track}
/// A success track with the fields 1–11, its value and its repression
/// fields (R-090).
/// {@endtemplate}
class SuccessTrack extends StatelessWidget {
  /// {@macro success_track}
  const new({
    required this.kind,
    required this.value,
    this.repressionFields = const {},
    this.activatedFields = const {},
    this.compact = true,
    this.semanticLabel,
    super.key,
  }) : assert(value >= 0 && value <= maxValue, 'Value must be 0–11');

  /// Highest value of a track.
  static const int maxValue = 11;

  /// Which track is shown.
  final SuccessTrackKind kind;

  /// Current value (0–11).
  final int value;

  /// Fields marked as repression fields.
  final Set<int> repressionFields;

  /// Repression fields that are activated.
  final Set<int> activatedFields;

  /// Whether to use the small 22 pixel cells instead of 26 pixels.
  final bool compact;

  /// Description for screen readers.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final cellSize = compact ? 22.0 : 26.0;
    final (icon, fillColor) = switch (kind) {
      SuccessTrackKind.activists => (
        HambiIconData.activist,
        AppColors.trackActivists,
      ),
      SuccessTrackKind.support => (
        HambiIconData.support,
        AppColors.trackSupport,
      ),
    };
    return Semantics(
      label: semanticLabel,
      excludeSemantics: true,
      child: SizedBox(
        height: cellSize,
        child: Row(
          children: [
            HambiIcon(icon, size: cellSize - 4),
            const SizedBox(width: AppSpacing.xs),
            for (var field = 1; field <= maxValue; field++)
              Expanded(
                child: _Cell(
                  filled: field <= value,
                  fillColor: fillColor,
                  isRepressionField: repressionFields.contains(field),
                  isActivated: activatedFields.contains(field),
                ),
              ),
            SizedBox(
              width: cellSize + AppSpacing.xs,
              child: Text(
                '$value',
                textAlign: TextAlign.end,
                style: AppTextStyle.numberSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const new({
    required this.filled,
    required this.fillColor,
    required this.isRepressionField,
    required this.isActivated,
  });

  final bool filled;
  final Color fillColor;
  final bool isRepressionField;
  final bool isActivated;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: filled ? fillColor : AppColors.stateDisabled,
        border: isRepressionField
            ? Border.all(color: AppColors.trackRepressionField, width: 2)
            : null,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: isActivated ? const RepressionSymbol() : null,
    );
  }
}
