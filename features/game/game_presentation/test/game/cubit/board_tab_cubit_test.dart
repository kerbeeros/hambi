import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';

void main() {
  group(BoardTabCubit, () {
    test('initial tab is the action board', () {
      expect(BoardTabCubit().state, equals(BoardSection.actions));
    });

    blocTest<BoardTabCubit, BoardSection>(
      'selected switches to the chosen tab',
      build: BoardTabCubit.new,
      act: (cubit) => cubit.selected(BoardSection.forest),
      expect: () => [BoardSection.forest],
    );

    for (final (phase, tab) in [
      (GamePhase.setup, BoardSection.forest),
      (GamePhase.preparation, BoardSection.actions),
      (GamePhase.action, BoardSection.actions),
      (GamePhase.excavation, BoardSection.forest),
      (GamePhase.repression, BoardSection.forest),
      (GamePhase.finished, BoardSection.forest),
    ]) {
      blocTest<BoardTabCubit, BoardSection>(
        'ADR 0003: phase $phase shows the $tab tab',
        build: BoardTabCubit.new,
        seed: () => tab == BoardSection.forest
            ? BoardSection.actions
            : BoardSection.forest,
        act: (cubit) => cubit.phaseChanged(phase),
        expect: () => [tab],
      );
    }
  });
}
