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

  /// Header height in logical pixels.
  static const double height = 64;

  @override
  Widget build(BuildContext context) {
    const onDark = AppColors.textOnDark;
    return Container(
      height: height,
      color: AppColors.bgBoard,
      padding: const EdgeInsets.only(left: AppSpacing.lg, right: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: Column(
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
          IconButton(
            tooltip: logTooltip,
            onPressed: onLogPressed,
            icon: const HambiIcon(HambiIconData.log, color: onDark),
          ),
          IconButton(
            tooltip: menuTooltip,
            onPressed: onMenuPressed,
            icon: const HambiIcon(HambiIconData.menu, color: onDark),
          ),
        ],
      ),
    );
  }
}
