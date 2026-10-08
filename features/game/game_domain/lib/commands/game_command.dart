import 'package:equatable/equatable.dart';
import 'package:game_domain/models/action_card_id.dart';
import 'package:game_domain/models/forest_position.dart';
import 'package:game_domain/models/negative_press_choice.dart';

/// A move or decision that changes the game state (T-003).
sealed class GameCommand extends Equatable {
  const new();
}

/// {@template start_game}
/// Starts a new game (R-110–R-112).
///
/// Not a [GameCommand]: it creates the initial state instead of changing one.
/// {@endtemplate}
final class StartGame extends Equatable {
  /// {@macro start_game}
  const new({required this.playerCount, required this.seed});

  /// Number of players (1–11).
  final int playerCount;

  /// Seed for the random generator (T-005).
  final int seed;

  @override
  List<Object> get props => [playerCount, seed];
}

/// {@template continue_command}
/// Confirms the current step and lets the game proceed (T-003).
/// {@endtemplate}
final class Continue extends GameCommand {
  /// {@macro continue_command}
  const new();

  @override
  List<Object> get props => [];
}

/// {@template assign_to_card}
/// Assigns activists, resources and support to [card] (R-081).
/// {@endtemplate}
final class AssignToCard extends GameCommand {
  /// {@macro assign_to_card}
  const new(this.card);

  /// The card to assign.
  final ActionCardId card;

  @override
  List<Object> get props => [card];
}

/// {@template undo_assignment}
/// Takes back the assignment of [card] (R-082, F-06).
/// {@endtemplate}
final class UndoAssignment extends GameCommand {
  /// {@macro undo_assignment}
  const new(this.card);

  /// The card whose assignment is taken back.
  final ActionCardId card;

  @override
  List<Object> get props => [card];
}

/// {@template end_preparation}
/// Ends the preparation phase and executes the action phase (R-084).
/// {@endtemplate}
final class EndPreparation extends GameCommand {
  /// {@macro end_preparation}
  const new();

  @override
  List<Object> get props => [];
}

/// {@template place_activist_on_forest}
/// Places an activist of a forest action on a forest card (R-085).
///
/// [column] and [position] are zero-based.
/// {@endtemplate}
final class PlaceActivistOnForest extends GameCommand {
  /// {@macro place_activist_on_forest}
  const new({required this.column, required this.position});

  /// Forest column (0 = WS1).
  final int column;

  /// Position within the column (0 = leftmost).
  final int position;

  @override
  List<Object> get props => [column, position];
}

/// {@template reroll_die}
/// Rerolls the excavator die at [index] thanks to sabotage (R-121).
/// {@endtemplate}
final class RerollDie extends GameCommand {
  /// {@macro reroll_die}
  const new(this.index);

  /// Index of the die to reroll (0 or 1).
  final int index;

  @override
  List<Object> get props => [index];
}

/// {@template return_activists_to_camp}
/// Returns the activists at [positions] from the forest to the camp (R-124).
/// {@endtemplate}
final class ReturnActivistsToCamp extends GameCommand {
  /// {@macro return_activists_to_camp}
  const new(this.positions);

  /// Forest cards whose activists return.
  final Set<ForestPosition> positions;

  @override
  List<Object> get props => [positions];
}

/// {@template resolve_negative_press}
/// Resolves the negative press card with [choice] (R-053).
/// {@endtemplate}
final class ResolveNegativePress extends GameCommand {
  /// {@macro resolve_negative_press}
  const new(this.choice);

  /// The chosen option.
  final NegativePressChoice choice;

  @override
  List<Object> get props => [choice];
}

/// {@template choose_card_to_restore}
/// Turns [card] back to side A after legal aid (R-055).
/// {@endtemplate}
final class ChooseCardToRestore extends GameCommand {
  /// {@macro choose_card_to_restore}
  const new(this.card);

  /// The card to turn back to side A.
  final ActionCardId card;

  @override
  List<Object> get props => [card];
}

/// {@template choose_security_card}
/// Places a security guard on [position] of the rolled column (R-050, Q14).
/// {@endtemplate}
final class ChooseSecurityCard extends GameCommand {
  /// {@macro choose_security_card}
  const new(this.position);

  /// Position within the rolled column (0 = leftmost).
  final int position;

  @override
  List<Object> get props => [position];
}
