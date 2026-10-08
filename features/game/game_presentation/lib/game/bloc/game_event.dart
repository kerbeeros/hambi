part of 'game_bloc.dart';

/// Event of the [GameBloc].
sealed class GameEvent extends Equatable {
  const new();
}

/// {@template game_started}
/// Starts a new game for [playerCount] players (F-01).
/// {@endtemplate}
final class GameStarted extends GameEvent {
  /// {@macro game_started}
  const new({required this.playerCount});

  /// Number of players (1–11).
  final int playerCount;

  @override
  List<Object> get props => [playerCount];
}

/// {@template game_resumed}
/// Continues the saved game (F-04).
/// {@endtemplate}
final class GameResumed extends GameEvent {
  /// {@macro game_resumed}
  const new();

  @override
  List<Object> get props => [];
}

/// {@template game_command_submitted}
/// The players made a move or decision.
/// {@endtemplate}
final class GameCommandSubmitted extends GameEvent {
  /// {@macro game_command_submitted}
  const new(this.command);

  /// The move or decision.
  final GameCommand command;

  @override
  List<Object> get props => [command];
}

/// {@template game_log_entry_acknowledged}
/// The players have seen the first pending log entry (UX-01).
/// {@endtemplate}
final class GameLogEntryAcknowledged extends GameEvent {
  /// {@macro game_log_entry_acknowledged}
  const new();

  @override
  List<Object> get props => [];
}
