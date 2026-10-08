import 'dart:math' as math;

import 'package:game_domain/commands/commands.dart';
import 'package:game_domain/exceptions/exceptions.dart';
import 'package:game_domain/models/models.dart';
import 'package:game_domain/random/random.dart';

part 'action_rules.dart';
part 'excavation_rules.dart';
part 'preparation_rules.dart';
part 'repression_rules.dart';
part 'setup_rules.dart';

/// {@template game_engine}
/// The rules engine (T-004): derives game states from commands.
/// {@endtemplate}
class GameEngine {
  /// {@macro game_engine}
  const new(this._random);

  final IRandomGenerator _random;

  /// Sets up a new game (R-110–R-112).
  ///
  /// Throws [InvalidPlayerCountException] when the player count is not
  /// between 1 and 11.
  GameState start(StartGame command) => _start(command);

  /// Applies [command] to [state] and returns the resulting state.
  ///
  /// Throws a [GameException] when the command breaks a rule, e.g.
  /// [InvalidPhaseException], [ConditionNotMetException],
  /// [CardBlockedException] or [InvalidDecisionException].
  GameState apply(GameState state, GameCommand command) => switch (command) {
    Continue() => _continue(state, command),
    AssignToCard(:final card) => _assign(state, command, card),
    UndoAssignment(:final card) => _undo(state, command, card),
    EndPreparation() => _endPreparation(state, command),
    PlaceActivistOnForest(:final column, :final position) => _placeActivist(
      state,
      command,
      column: column,
      position: position,
    ),
    RerollDie(:final index) => _reroll(state, command, index),
    ReturnActivistsToCamp(:final positions) => _returnActivists(
      state,
      command,
      positions,
    ),
    ResolveNegativePress(:final choice) => _resolveNegativePress(
      state,
      command,
      choice,
    ),
    ChooseCardToRestore(:final card) => _restoreCard(state, command, card),
    ChooseSecurityCard(:final position) => _placeSecurity(
      state,
      command,
      position,
    ),
  };

  /// Confirms the pending decision with its default, or starts the first
  /// round after the setup.
  GameState _continue(GameState state, Continue command) =>
      switch (state.pendingDecision) {
        RerollDecision(:final dice) => _resolveDice(
          state.copyWith(pendingDecision: () => null),
          dice,
        ),
        ReturnActivistsDecision() => _startRepression(
          state.copyWith(pendingDecision: () => null),
        ),
        _ => _startFirstRound(state, command),
      };

  /// Runs the initial repression phase before round 1 (R-113).
  GameState _startFirstRound(GameState state, Continue command) {
    _requirePhase(state, command, GamePhase.setup);
    return _startRepression(state);
  }

  void _requirePhase(GameState state, GameCommand command, GamePhase phase) {
    if (state.phase != phase) throw InvalidPhaseException(command, state.phase);
  }
}
