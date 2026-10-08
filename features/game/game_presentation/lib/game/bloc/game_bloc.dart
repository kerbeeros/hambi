import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:game_domain/game_domain.dart';

part 'game_event.dart';
part 'game_view_state.dart';

/// {@template game_bloc}
/// Runs a game: translates UI events into rule engine commands, saves the
/// game after every move (T-020) and hands out the log entries of each move
/// one by one (UX-01, F-07).
/// {@endtemplate}
class GameBloc extends Bloc<GameEvent, GameViewState> {
  /// {@macro game_bloc}
  new({required this._engine, required this._repository, required this._seed})
    : super(const GameLoading()) {
    // Moves and saves must never interleave.
    on<GameEvent>(_onEvent, transformer: sequential());
  }

  final GameEngine _engine;
  final IGameRepository _repository;
  final int Function() _seed;

  Future<void> _onEvent(GameEvent event, Emitter<GameViewState> emit) =>
      switch (event) {
        GameStarted(:final playerCount) => _onStarted(playerCount, emit),
        GameResumed() => _onResumed(emit),
        GameCommandSubmitted(:final command) => _onCommand(command, emit),
        GameLogEntryAcknowledged() => _onAcknowledged(emit),
      };

  Future<void> _onStarted(int playerCount, Emitter<GameViewState> emit) async {
    final game = _engine.start(
      StartGame(playerCount: playerCount, seed: _seed()),
    );
    emit(GameInProgress(game: game));
    await _save(game);
  }

  Future<void> _onResumed(Emitter<GameViewState> emit) async {
    emit(const GameLoading());
    try {
      final game = await _repository.loadGame();
      if (game == null) {
        emit(const GameFailure(GameFailureReason.noSavedGame));
        return;
      }
      emit(_stateFor(game, const []));
    } on LoadGameException catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(const GameFailure(GameFailureReason.loadFailed));
    }
  }

  Future<void> _onCommand(
    GameCommand command,
    Emitter<GameViewState> emit,
  ) async {
    final current = state;
    if (current is! GameInProgress || current.pendingEntries.isNotEmpty) {
      return;
    }
    final GameState game;
    try {
      game = _engine.apply(current.game, command);
    } on GameException catch (error, stackTrace) {
      addError(error, stackTrace);
      return;
    }
    emit(_stateFor(game, game.logEntriesSince(current.game)));
    await _save(game);
  }

  Future<void> _onAcknowledged(Emitter<GameViewState> emit) async {
    final current = state;
    if (current is! GameInProgress || current.pendingEntries.isEmpty) return;
    emit(_stateFor(current.game, current.pendingEntries.sublist(1)));
  }

  GameViewState _stateFor(GameState game, List<GameLogEntry> entries) =>
      game.phase == GamePhase.finished && entries.isEmpty
      ? GameFinished(game: game)
      : GameInProgress(game: game, pendingEntries: entries);

  /// Saves a running game and deletes a finished one, so that only running
  /// games can be resumed.
  Future<void> _save(GameState game) async {
    try {
      if (game.phase == GamePhase.finished) {
        await _repository.deleteGame();
      } else {
        await _repository.saveGame(game);
      }
    } on SaveGameException catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  }
}
