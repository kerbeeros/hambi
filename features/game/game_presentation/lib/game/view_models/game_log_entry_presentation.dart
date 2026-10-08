import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game/view_models/repression_card_presentation.dart';
import 'package:game_presentation/l10n/l10n.dart';

/// How a [GameLogEntry] is shown in the round log (F-07).
extension GameLogEntryPresentation on GameLogEntry {
  /// One-line description.
  String describe(GameLocalizations l10n) => switch (this) {
    DiceRolled(:final dice) => l10n.logDiceRolled(dice[0], dice[1]),
    DieRerolled(:final index, :final value) => l10n.logDieRerolled(
      index + 1,
      value,
    ),
    RepressionCardDrawn(:final card) => l10n.logRepressionCardDrawn(
      card.title(l10n),
    ),
    RepressionDieRolled(:final value) => l10n.logRepressionDieRolled(value),
  };
}
