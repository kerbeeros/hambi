import 'package:game_domain/models/models.dart';

/// {@template game_exception}
/// Base class of all exceptions thrown by the rules engine (T-004).
/// {@endtemplate}
abstract class GameException implements Exception {
  /// {@macro game_exception}
  const new(this.message);

  /// Description of the violated rule.
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// {@template invalid_player_count_exception}
/// Thrown when a game is started with fewer than 1 or more than 11 players.
/// {@endtemplate}
class InvalidPlayerCountException extends GameException {
  /// {@macro invalid_player_count_exception}
  const new(int playerCount)
    : super('Player count must be between 1 and 11, was $playerCount');
}

/// {@template invalid_phase_exception}
/// Thrown when a command is not allowed in the current phase.
/// {@endtemplate}
class InvalidPhaseException extends GameException {
  /// {@macro invalid_phase_exception}
  new(Object command, GamePhase phase)
    : super('${command.runtimeType} is not allowed in phase ${phase.name}');
}

/// {@template condition_not_met_exception}
/// Thrown when the conditions of an action card cannot be met (R-042).
/// {@endtemplate}
class ConditionNotMetException extends GameException {
  /// {@macro condition_not_met_exception}
  new(ActionCardId card)
    : super('The conditions of ${card.name} cannot be met');
}

/// {@template card_blocked_exception}
/// Thrown when a blocked action card is assigned (R-083).
/// {@endtemplate}
class CardBlockedException extends GameException {
  /// {@macro card_blocked_exception}
  new(ActionCardId card) : super('${card.name} is blocked this round');
}

/// {@template card_already_assigned_exception}
/// Thrown when an action card is assigned twice in a round (R-043).
/// {@endtemplate}
class CardAlreadyAssignedException extends GameException {
  /// {@macro card_already_assigned_exception}
  new(ActionCardId card) : super('${card.name} is already assigned');
}

/// {@template card_not_assigned_exception}
/// Thrown when the assignment of an unassigned card is taken back.
/// {@endtemplate}
class CardNotAssignedException extends GameException {
  /// {@macro card_not_assigned_exception}
  new(ActionCardId card) : super('${card.name} is not assigned');
}

/// {@template invalid_decision_exception}
/// Thrown when a decision is made that the game is not waiting for.
/// {@endtemplate}
class InvalidDecisionException extends GameException {
  /// {@macro invalid_decision_exception}
  new(Object command)
    : super('The game is not waiting for ${command.runtimeType}');
}

/// {@template invalid_forest_card_exception}
/// Thrown when a forest card cannot be chosen (R-085, Q11, Q19).
/// {@endtemplate}
class InvalidForestCardException extends GameException {
  /// {@macro invalid_forest_card_exception}
  new({required int column, required int position})
    : super('Forest card ($column, $position) cannot be chosen');
}

/// {@template invalid_die_exception}
/// Thrown when a die that does not exist is rerolled (R-121).
/// {@endtemplate}
class InvalidDieException extends GameException {
  /// {@macro invalid_die_exception}
  new(int index) : super('There is no die with index $index');
}

/// {@template card_not_on_side_b_exception}
/// Thrown when legal aid restores a card that is not on side B (R-055).
/// {@endtemplate}
class CardNotOnSideBException extends GameException {
  /// {@macro card_not_on_side_b_exception}
  new(ActionCardId card) : super('${card.name} is not on side B');
}
