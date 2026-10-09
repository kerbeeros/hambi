import 'package:flutter/material.dart';
import 'package:ui_kit/src/icons/icons.dart';
import 'package:ui_kit/src/tokens/tokens.dart';

/// {@template round_header}
/// Header of the board with round, phase and buttons for log and menu.
/// {@endtemplate}
class RoundHeader extends StatelessWidget {
  /// {@macro round_header}
  const new({
    required this.title,
    required this.subtitle,
    required this.logTooltip,
    required this.menuTooltip,
    required this.onLogPressed,
    required this.onMenuPressed,
    super.key,
  });

  /// Round, e.g. "Runde 3/12".
  final String title;

  /// Current phase.
  final String subtitle;

  /// Tooltip and semantic label of the log button.
  final String logTooltip;

  /// Tooltip and semantic label of the menu button.
  final String menuTooltip;

  /// Opens the round log.
  final VoidCallback onLogPressed;

  /// Opens the game menu.
  final VoidCallback onMenuPressed;

  /// Minimum header height in logical pixels; the header grows with large
  /// text (NF-04).
  static const double height = 64;

  @override
  Widget build(BuildContext context) {
    const onDark = AppColors.textOnDark;
    return Container(
      constraints: const BoxConstraints(minHeight: height),
      color: AppColors.bgBoard,
      padding: const EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.xs,
        top: AppSpacing.xxs,
        bottom: AppSpacing.xxs,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.headingH2.copyWith(color: onDark),
                ),
                Text(
                  subtitle,
                  style: AppTextStyle.caption.copyWith(color: onDark),
                ),
              ],
            ),
          ),
          _HeaderButton(
            label: logTooltip,
            onPressed: onLogPressed,
            icon: HambiIconData.log,
          ),
          _HeaderButton(
            label: menuTooltip,
            onPressed: onMenuPressed,
            icon: HambiIconData.menu,
          ),
        ],
      ),
    );
  }
}

/// An icon button whose label reaches screen readers as its description,
/// not only as a tooltip (NF-04).
class _HeaderButton extends StatelessWidget {
  const new({required this.label, required this.onPressed, required this.icon});

  final String label;
  final VoidCallback onPressed;
  final HambiIconData icon;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      excludeFromSemantics: true,
      child: Semantics(
        label: label,
        button: true,
        excludeSemantics: true,
        onTap: onPressed,
        child: IconButton(
          onPressed: onPressed,
          icon: HambiIcon(icon, color: AppColors.textOnDark),
        ),
      ),
    );
  }
}
