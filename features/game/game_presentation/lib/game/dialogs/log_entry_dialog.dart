import 'package:flutter/material.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game/view_models/view_models.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

/// Dialogs showing what happened during a move (D-06, D-07, UX-01).
abstract final class LogEntryDialog {
  /// Shows [entry] until the players continue.
  static Future<void> show(BuildContext context, GameLogEntry entry) =>
      HambiDialog.show<void>(context, builder: (_) => dialogFor(entry));

  /// The dialog for [entry]; it pops when the players continue.
  static Widget dialogFor(GameLogEntry entry) => _LogEntryDialog(entry: entry);
}

class _LogEntryDialog extends StatelessWidget {
  const new({required this.entry});

  final GameLogEntry entry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (title, content) = switch (entry) {
      DiceRolled(:final dice) => (l10n.diceDialogTitle, _Dice(values: dice)),
      DieRerolled(:final value) => (
        l10n.rerollDialogTitle,
        _Dice(values: [value]),
      ),
      RepressionDieRolled(:final value) => (
        l10n.repressionDieTitle,
        Center(child: DieView(value: value)),
      ),
      RepressionCardDrawn(:final card) => (
        l10n.repressionCardDialogTitle,
        Center(
          child: RepressionCardView(
            title: card.title(l10n),
            description: card.description(l10n),
            kind: card.kind,
          ),
        ),
      ),
    };
    return HambiDialog(
      title: title,
      content: content,
      actions: [
        HambiButton(
          label: l10n.continueAction,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

/// Excavator dice with the forest column each one hits (R-120).
class _Dice extends StatelessWidget {
  const new({required this.values});

  final List<int> values;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        for (final value in values)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              children: [
                DieView(value: value),
                const SizedBox(width: AppSpacing.md),
                Text(l10n.dieHitsColumn(value, (value - 1) ~/ 2 + 1)),
              ],
            ),
          ),
      ],
    );
  }
}
