import 'package:bloc/bloc.dart';
import 'package:game_domain/game_domain.dart';

/// Sections of the board shown as tabs on phones (ADR 0003).
enum BoardSection {
  /// The forest.
  forest,

  /// The action board.
  actions,
}

/// {@template board_tab_cubit}
/// The board section shown on phones. It follows the phase of the game and
/// can be switched by the players (ADR 0003).
/// {@endtemplate}
class BoardTabCubit extends Cubit<BoardSection> {
  /// {@macro board_tab_cubit}
  new() : super(BoardSection.actions);

  /// The players chose [section].
  void selected(BoardSection section) => emit(section);

  /// Shows the section that matters in [phase].
  void phaseChanged(GamePhase phase) => emit(switch (phase) {
    GamePhase.preparation || GamePhase.action => BoardSection.actions,
    GamePhase.setup ||
    GamePhase.excavation ||
    GamePhase.repression ||
    GamePhase.finished => BoardSection.forest,
  });
}
