import 'package:flutter/material.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game/view_models/view_models.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

/// {@template round_log_sheet}
/// The round log (D-09, F-07).
/// {@endtemplate}
class RoundLogSheet extends StatelessWidget {
  /// {@macro round_log_sheet}
  const new({required this.log, super.key});

  /// Entries of the current round.
  final List<GameLogEntry> log;

  /// Shows the round log as a bottom sheet.
  static Future<void> show(BuildContext context, List<GameLogEntry> log) =>
      HambiBottomSheet.show<void>(
        context,
        builder: (_) => RoundLogSheet(log: log),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return HambiBottomSheet(
      title: l10n.logTooltip,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (log.isEmpty) Text(l10n.logEmpty),
          for (final entry in log)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text(entry.describe(l10n)),
            ),
        ],
      ),
    );
  }
}

/// What the players chose in the game menu (D-10).
enum GameMenuAction {
  /// Open the rules (UX-10).
  rules,

  /// Leave the game after confirming it (UX-08).
  exit,
}

/// {@template game_menu_sheet}
/// The game menu (D-10, UX-08).
/// {@endtemplate}
class GameMenuSheet extends StatelessWidget {
  /// {@macro game_menu_sheet}
  const new({super.key});

  /// Shows the menu and returns the chosen action, or `null` to keep
  /// playing; the game stays saved.
  static Future<GameMenuAction?> show(BuildContext context) =>
      HambiBottomSheet.show<GameMenuAction>(
        context,
        builder: (_) => const GameMenuSheet(),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final navigator = Navigator.of(context);
    return HambiBottomSheet(
      title: l10n.menuTooltip,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HambiButton(
            label: l10n.menuRulesAction,
            style: HambiButtonStyle.secondary,
            onPressed: () => navigator.pop(GameMenuAction.rules),
          ),
          const SizedBox(height: AppSpacing.sm),
          HambiButton(
            label: l10n.menuExitAction,
            style: HambiButtonStyle.secondary,
            onPressed: () async {
              final confirmed = await _confirmExit(context);
              navigator.pop(confirmed ? GameMenuAction.exit : null);
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          HambiButton(label: l10n.menuCloseAction, onPressed: navigator.pop),
        ],
      ),
    );
  }

  Future<bool> _confirmExit(BuildContext context) async {
    final l10n = context.l10n;
    return await HambiDialog.show<bool>(
          context,
          builder: (dialogContext) => HambiDialog(
            title: l10n.exitConfirmTitle,
            content: Text(l10n.exitConfirmBody),
            actions: [
              HambiButton(
                label: l10n.exitConfirmAction,
                onPressed: () => Navigator.of(dialogContext).pop(true),
              ),
              HambiButton(
                label: l10n.exitCancelAction,
                style: HambiButtonStyle.secondary,
                onPressed: () => Navigator.of(dialogContext).pop(false),
              ),
            ],
          ),
        ) ??
        false;
  }
}
