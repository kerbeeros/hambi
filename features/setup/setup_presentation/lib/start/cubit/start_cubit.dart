import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_domain/game_domain.dart';

part 'start_state.dart';

/// {@template start_cubit}
/// Finds out whether a saved game can be continued (S-01, F-04).
/// {@endtemplate}
class StartCubit extends Cubit<StartState> {
  /// {@macro start_cubit}
  new(this._repository) : super(const StartState());

  final IGameRepository _repository;

  /// Checks for a saved game; an unreadable one counts as none.
  Future<void> loaded() async {
    var hasSavedGame = false;
    try {
      hasSavedGame = await _repository.hasSavedGame();
    } on LoadGameException catch (error, stackTrace) {
      addError(error, stackTrace);
    }
    emit(StartState(status: StartStatus.ready, hasSavedGame: hasSavedGame));
  }
}
