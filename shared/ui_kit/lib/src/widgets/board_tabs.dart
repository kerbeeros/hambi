import 'package:flutter/material.dart';
import 'package:ui_kit/src/tokens/tokens.dart';

/// {@template board_tab}
/// A tab of [BoardTabs].
/// {@endtemplate}
class BoardTab {
  /// {@macro board_tab}
  const new({required this.label, this.badgeCount});

  /// Tab label.
  final String label;

  /// Count shown in a badge, e.g. threatened forest cards; `null` or `0`
  /// hides the badge.
  final int? badgeCount;
}

/// {@template board_tabs}
/// Segmented control switching between forest and actions (ADR 0003).
/// {@endtemplate}
class BoardTabs extends StatelessWidget {
  /// {@macro board_tabs}
  const new({
    required this.tabs,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  /// The tabs in order.
  final List<BoardTab> tabs;

  /// Index of the selected tab.
  final int selectedIndex;

  /// Called with the index of a tapped tab.
  final ValueChanged<int> onSelected;

  /// Height in logical pixels.
  static const double height = 44;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(AppSpacing.xxs),
      decoration: BoxDecoration(
        color: AppColors.stateDisabled,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        children: [
          for (var index = 0; index < tabs.length; index++)
            Expanded(
              child: _Segment(
                tab: tabs[index],
                isSelected: index == selectedIndex,
                onTap: () => onSelected(index),
              ),
            ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const new({required this.tab, required this.isSelected, required this.onTap});

  final BoardTab tab;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final badgeCount = tab.badgeCount ?? 0;
    return Semantics(
      selected: isSelected,
      button: true,
      child: Material(
        color: isSelected ? AppColors.bgSurface : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.md),
          onTap: onTap,
          // Long labels and large text scale down instead of overflowing
          // (NF-04).
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(tab.label, style: AppTextStyle.label),
                  if (badgeCount > 0) ...[
                    const SizedBox(width: AppSpacing.xs),
                    _Badge(badgeCount),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const new(this.count);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 20),
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.stateBlocked,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        '$count',
        style: AppTextStyle.numberSmall.copyWith(color: AppColors.textOnDark),
      ),
    );
  }
}
