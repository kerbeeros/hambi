import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_domain/game_domain.dart';

part 'setup_state.dart';

/// {@template setup_cubit}
/// Chooses the number of players and starts a new game (S-02, F-01),
/// asking before a saved game is overwritten (D-11).
/// {@endtemplate}
class SetupCubit extends Cubit<SetupState> {
  /// {@macro setup_cubit}
  new(this._repository) : super(const SetupState());

  final IGameRepository _repository;

  static const int _minPlayers = 1;
  static const int _maxPlayers = GameState.maxActivists;

  /// Adds a player, up to 11.
  void playersIncreased() {
    if (state.playerCount >= _maxPlayers) return;
    emit(state.copyWith(playerCount: state.playerCount + 1));
  }

  /// Removes a player, down to 1.
  void playersDecreased() {
    if (state.playerCount <= _minPlayers) return;
    emit(state.copyWith(playerCount: state.playerCount - 1));
  }

  /// Starts the game, or asks first when a saved game would be overwritten.
  Future<void> startRequested() async {
    var hasSavedGame = false;
    try {
      hasSavedGame = await _repository.hasSavedGame();
    } on LoadGameException catch (error, stackTrace) {
      addError(error, stackTrace);
    }
    emit(
      state.copyWith(
        status: hasSavedGame
            ? SetupStatus.confirmOverwrite
            : SetupStatus.started,
      ),
    );
  }

  /// The players agreed to replace the saved game.
  void overwriteConfirmed() =>
      emit(state.copyWith(status: SetupStatus.started));

  /// The players keep the saved game.
  void overwriteCancelled() =>
      emit(state.copyWith(status: SetupStatus.editing));
}
