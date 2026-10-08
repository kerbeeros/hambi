import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:setup_presentation/setup_presentation.dart';

class _MockGameRepository extends Mock implements IGameRepository;

void main() {
  group(StartCubit, () {
    late IGameRepository repository;

    setUp(() {
      repository = _MockGameRepository();
    });

    test('initial state is loading', () {
      expect(StartCubit(repository).state, equals(const StartState()));
    });

    for (final saved in [true, false]) {
      blocTest<StartCubit, StartState>(
        'S-01: loaded reports whether a game is saved ($saved)',
        setUp: () =>
            when(repository.hasSavedGame).thenAnswer((_) async => saved),
        build: () => StartCubit(repository),
        act: (cubit) => cubit.loaded(),
        expect: () => [
          StartState(status: StartStatus.ready, hasSavedGame: saved),
        ],
      );
    }

    blocTest<StartCubit, StartState>(
      'treats an unreadable save as no saved game',
      setUp: () =>
          when(repository.hasSavedGame)
              .thenThrow(const LoadGameException('broken')),
      build: () => StartCubit(repository),
      act: (cubit) => cubit.loaded(),
      expect: () => [const StartState(status: StartStatus.ready)],
    );
  });
}
