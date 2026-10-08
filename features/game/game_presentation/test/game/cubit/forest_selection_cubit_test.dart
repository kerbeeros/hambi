import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';

void main() {
  group(ForestSelectionCubit, () {
    const a = ForestPosition(column: 0, position: 1);
    const b = ForestPosition(column: 2, position: 3);

    test('initial selection is empty', () {
      expect(ForestSelectionCubit().state, isEmpty);
    });

    blocTest<ForestSelectionCubit, Set<ForestPosition>>(
      'toggled adds a position',
      build: ForestSelectionCubit.new,
      act: (cubit) => cubit
        ..toggled(a)
        ..toggled(b),
      expect: () => [
        {a},
        {a, b},
      ],
    );

    blocTest<ForestSelectionCubit, Set<ForestPosition>>(
      'toggled removes a selected position',
      build: ForestSelectionCubit.new,
      seed: () => {a, b},
      act: (cubit) => cubit.toggled(a),
      expect: () => [
        {b},
      ],
    );
  });
}
