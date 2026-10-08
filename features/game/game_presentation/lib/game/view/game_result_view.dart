import 'package:flutter/material.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

/// {@template game_result_view}
/// The result of a finished game (S-04, R-102).
/// {@endtemplate}
class GameResultView extends StatelessWidget {
  /// {@macro game_result_view}
  const new({required this.game, required this.onNewGame, super.key});

  /// The finished game.
  final GameState game;

  /// Starts a new game.
  final VoidCallback onNewGame;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final victory = game.outcome == GameOutcome.victory;
    final columnCleared = game.forest.columns.any(
      (column) => column.every((card) => card.state == ForestCardState.removed),
    );
    final text = victory
        ? l10n.resultVictoryText
        : columnCleared
        ? l10n.resultDefeatColumnText
        : l10n.resultDefeatSupportText;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.xxl),
            Text(
              victory ? l10n.resultVictoryTitle : l10n.resultDefeatTitle,
              style: AppTextStyle.display,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              text,
              style: AppTextStyle.bodyDefault,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            _Figure(label: l10n.resultSupport, value: game.support),
            _Figure(
              label: l10n.resultRemovedCards,
              value: game.removedForestCards,
            ),
            _Figure(label: l10n.resultRound, value: game.round),
            const SizedBox(height: AppSpacing.xl),
            HambiButton(label: l10n.newGameAction, onPressed: onNewGame),
          ],
        ),
      ),
    );
  }
}

class _Figure extends StatelessWidget {
  const new({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppTextStyle.bodyDefault)),
          Text('$value', style: AppTextStyle.numberLarge),
        ],
      ),
    );
  }
}
