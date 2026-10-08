import 'package:bloc/bloc.dart';
import 'package:game_domain/game_domain.dart';

/// {@template forest_selection_cubit}
/// Forest cards selected in a dialog, e.g. activists returning to the camp
/// (R-124).
/// {@endtemplate}
class ForestSelectionCubit extends Cubit<Set<ForestPosition>> {
  /// {@macro forest_selection_cubit}
  new() : super(const {});

  /// Selects [position], or deselects it when it is already selected.
  void toggled(ForestPosition position) => emit(
    state.contains(position)
        ? ({...state}..remove(position))
        : {...state, position},
  );
}
