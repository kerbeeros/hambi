part of 'game_bloc.dart';

/// State of the [GameBloc] (T-030).
sealed class GameViewState extends Equatable {
  const new();
}

/// {@template game_loading}
/// A game is being loaded.
/// {@endtemplate}
final class GameLoading extends GameViewState {
  /// {@macro game_loading}
  const new();

  @override
  List<Object> get props => [];
}

/// {@template game_in_progress}
/// A game is running.
/// {@endtemplate}
final class GameInProgress extends GameViewState {
  /// {@macro game_in_progress}
  new({required this.game, List<GameLogEntry> pendingEntries = const []})
    : pendingEntries = List.unmodifiable(pendingEntries);

  /// The current game state.
  final GameState game;

  /// Log entries of the last move the players have not seen yet, oldest
  /// first. Moves are only accepted once they are all acknowledged.
  final List<GameLogEntry> pendingEntries;

  @override
  List<Object> get props => [game, pendingEntries];
}

/// {@template game_finished}
/// The game is over (R-100, R-101).
/// {@endtemplate}
final class GameFinished extends GameViewState {
  /// {@macro game_finished}
  const new({required this.game});

  /// The final game state with its outcome.
  final GameState game;

  @override
  List<Object> get props => [game];
}

/// Why no game could be shown.
enum GameFailureReason {
  /// There is no saved game to continue.
  noSavedGame,

  /// The saved game could not be read.
  loadFailed,
}

/// {@template game_failure}
/// No game could be shown.
/// {@endtemplate}
final class GameFailure extends GameViewState {
  /// {@macro game_failure}
  const new(this.reason);

  /// Why no game could be shown.
  final GameFailureReason reason;

  @override
  List<Object> get props => [reason];
}
