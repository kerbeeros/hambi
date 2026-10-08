import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:setup_presentation/setup_presentation.dart';

class _MockGameRepository extends Mock implements IGameRepository;

void main() {
  group(SetupCubit, () {
    late IGameRepository repository;

    setUp(() {
      repository = _MockGameRepository();
    });

    SetupCubit build() => SetupCubit(repository);

    test('starts with 3 players', () {
      expect(build().state, equals(const SetupState()));
      expect(build().state.playerCount, equals(3));
    });

    group('player count', () {
      blocTest<SetupCubit, SetupState>(
        'F-01: playersIncreased adds a player',
        build: build,
        act: (cubit) => cubit.playersIncreased(),
        expect: () => [const SetupState(playerCount: 4)],
      );

      blocTest<SetupCubit, SetupState>(
        'F-01: playersDecreased removes a player',
        build: build,
        act: (cubit) => cubit.playersDecreased(),
        expect: () => [const SetupState(playerCount: 2)],
      );

      blocTest<SetupCubit, SetupState>(
        'F-01: stays at 11 players',
        build: build,
        seed: () => const SetupState(playerCount: 11),
        act: (cubit) => cubit.playersIncreased(),
        expect: () => <SetupState>[],
      );

      blocTest<SetupCubit, SetupState>(
        'F-01: stays at 1 player',
        build: build,
        seed: () => const SetupState(playerCount: 1),
        act: (cubit) => cubit.playersDecreased(),
        expect: () => <SetupState>[],
      );

      test('R-111: exposes the starting camp', () {
        expect(
          const SetupState(playerCount: 1).startingCamp,
          equals(const Camp(activists: 1, resources: 2)),
        );
      });
    });

    group('startRequested', () {
      blocTest<SetupCubit, SetupState>(
        'starts without a saved game',
        setUp: () =>
            when(repository.hasSavedGame).thenAnswer((_) async => false),
        build: build,
        act: (cubit) => cubit.startRequested(),
        expect: () => [const SetupState(status: SetupStatus.started)],
      );

      blocTest<SetupCubit, SetupState>(
        'D-11: asks before overwriting a saved game',
        setUp: () =>
            when(repository.hasSavedGame).thenAnswer((_) async => true),
        build: build,
        act: (cubit) => cubit.startRequested(),
        expect: () => [const SetupState(status: SetupStatus.confirmOverwrite)],
      );

      blocTest<SetupCubit, SetupState>(
        'starts when the saved game cannot be read',
        setUp: () =>
            when(repository.hasSavedGame)
                .thenThrow(const LoadGameException('broken')),
        build: build,
        act: (cubit) => cubit.startRequested(),
        expect: () => [const SetupState(status: SetupStatus.started)],
      );
    });

    blocTest<SetupCubit, SetupState>(
      'D-11: overwriteConfirmed starts the game',
      build: build,
      seed: () => const SetupState(status: SetupStatus.confirmOverwrite),
      act: (cubit) => cubit.overwriteConfirmed(),
      expect: () => [const SetupState(status: SetupStatus.started)],
    );

    blocTest<SetupCubit, SetupState>(
      'D-11: overwriteCancelled returns to editing',
      build: build,
      seed: () => const SetupState(status: SetupStatus.confirmOverwrite),
      act: (cubit) => cubit.overwriteCancelled(),
      expect: () => [const SetupState()],
    );
  });
}
