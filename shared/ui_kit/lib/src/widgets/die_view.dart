import 'package:flutter/material.dart';
import 'package:ui_kit/src/tokens/tokens.dart';

/// {@template die_view}
/// An excavator die showing [value] pips.
/// {@endtemplate}
class DieView extends StatelessWidget {
  /// {@macro die_view}
  const new({required this.value, this.semanticLabel, super.key})
    : assert(value >= 1 && value <= 6, 'A die shows 1 to 6 pips');

  /// Shown value (1–6).
  final int value;

  /// Description for screen readers, e.g. "Die shows 3".
  final String? semanticLabel;

  static const double _size = 40;
  static const double _pipSize = 7;

  // Pip positions on a 3 × 3 grid, index = row * 3 + column.
  static const Map<int, List<int>> _pips = {
    1: [4],
    2: [2, 6],
    3: [2, 4, 6],
    4: [0, 2, 6, 8],
    5: [0, 2, 4, 6, 8],
    6: [0, 2, 3, 5, 6, 8],
  };

  @override
  Widget build(BuildContext context) {
    final pips = _pips[value]!;
    return Semantics(
      label: semanticLabel,
      excludeSemantics: true,
      child: Container(
        width: _size,
        height: _size,
        padding: const EdgeInsets.all(AppSpacing.xs + AppSpacing.xxs),
        decoration: BoxDecoration(
          color: AppColors.bgSurface,
          border: Border.all(color: AppColors.borderDefault, width: 1.5),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: GridView.count(
          crossAxisCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (var index = 0; index < 9; index++)
              Center(
                child: pips.contains(index)
                    ? const _Pip()
                    : const SizedBox(width: _pipSize, height: _pipSize),
              ),
          ],
        ),
      ),
    );
  }
}

class _Pip extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        shape: BoxShape.circle,
      ),
      child: SizedBox(width: DieView._pipSize, height: DieView._pipSize),
    );
  }
}
