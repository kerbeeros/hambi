import 'package:flutter/material.dart';
import 'package:ui_kit/src/tokens/tokens.dart';

/// {@template phase_stepper}
/// The four phases of a round with the active one highlighted (R-080–R-093).
/// {@endtemplate}
class PhaseStepper extends StatelessWidget {
  /// {@macro phase_stepper}
  const new({required this.labels, this.activeIndex, super.key});

  /// Phase names in order.
  final List<String> labels;

  /// Index of the active phase; `null` highlights none, e.g. during setup.
  final int? activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < labels.length; index++)
          Expanded(
            child: _Step(
              label: labels[index],
              isActive: index == activeIndex,
              isDone: activeIndex != null && index < activeIndex!,
            ),
          ),
      ],
    );
  }
}

class _Step extends StatelessWidget {
  const new({
    required this.label,
    required this.isActive,
    required this.isDone,
  });

  final String label;
  final bool isActive;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    final barColor = isActive || isDone
        ? AppColors.actionPrimary
        : AppColors.stateDisabled;
    return Semantics(
      selected: isActive,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: isActive ? 6 : 4,
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                style: isActive
                    ? AppTextStyle.label
                    : AppTextStyle.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
