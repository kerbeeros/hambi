import 'dart:async';

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

/// Rolls the dice or keeps the drawn card face down until
/// [AppDuration.reveal] has passed or the players skip ahead (UX-04).
class _LogEntryDialog extends StatefulWidget {
  const new({required this.entry});

  final GameLogEntry entry;

  @override
  State<_LogEntryDialog> createState() => _LogEntryDialogState();
}

class _LogEntryDialogState extends State<_LogEntryDialog> {
  Timer? _timer;
  bool _revealed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_revealed || _timer != null) return;
    if (MediaQuery.disableAnimationsOf(context)) {
      _revealed = true;
    } else {
      _timer = Timer(AppDuration.reveal, _reveal);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _reveal() {
    _timer?.cancel();
    if (!_revealed) setState(() => _revealed = true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (title, content) = switch (widget.entry) {
      DiceRolled(:final dice) => (
        l10n.diceDialogTitle,
        _Dice(values: dice, revealed: _revealed),
      ),
      DieRerolled(:final value) => (
        l10n.rerollDialogTitle,
        _Dice(values: [value], revealed: _revealed),
      ),
      RepressionDieRolled(:final value) => (
        l10n.repressionDieTitle,
        Center(
          child: RollingDieView(
            value: value,
            rolling: !_revealed,
            semanticLabel: l10n.dieShowsLabel(value),
            rollingSemanticLabel: l10n.dieRollingLabel,
          ),
        ),
      ),
      RepressionCardDrawn(:final card) => (
        l10n.repressionCardDialogTitle,
        Center(
          child: CardFlipView(
            revealed: _revealed,
            back: const RepressionCardBackView(),
            front: RepressionCardView(
              title: card.title(l10n),
              description: card.description(l10n),
              kind: card.kind,
            ),
          ),
        ),
      ),
    };
    return HambiDialog(
      title: title,
      // Screen readers skip with the button, so the dice and the card keep
      // their own labels instead of merging into one tappable node.
      content: GestureDetector(
        onTap: _reveal,
        excludeFromSemantics: true,
        child: content,
      ),
      actions: [
        if (_revealed)
          HambiButton(
            label: l10n.continueAction,
            onPressed: () => Navigator.of(context).pop(),
          )
        else
          HambiButton(label: l10n.skipAction, onPressed: _reveal),
      ],
    );
  }
}

/// Excavator dice with the forest column each one hits once [revealed]
/// (R-120).
class _Dice extends StatelessWidget {
  const new({required this.values, required this.revealed});

  final List<int> values;
  final bool revealed;

  /// Forest column (1–3) a die hits (R-120).
  static int _columnOf(int value) => (value - 1) ~/ 2 + 1;

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
                RollingDieView(
                  value: value,
                  rolling: !revealed,
                  semanticLabel: l10n.dieHitsColumnLabel(
                    value,
                    _columnOf(value),
                  ),
                  rollingSemanticLabel: l10n.dieRollingLabel,
                ),
                const SizedBox(width: AppSpacing.md),
                // The die already tells screen readers the column.
                if (revealed)
                  ExcludeSemantics(
                    child: Text(l10n.dieHitsColumn(value, _columnOf(value))),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
