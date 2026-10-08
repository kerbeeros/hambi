import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockGameRepository extends Mock implements IGameRepository;

void main() {
  group(GameBloc, () {
    const seed = 42;
    const rules = GameEngine(XorShiftRandomGenerator());
    late GameEngine engine;
    late IGameRepository repository;

    setUpAll(() {
      registerFallbackValue(buildGameState());
    });

    setUp(() {
      engine = const GameEngine(XorShiftRandomGenerator());
      repository = _MockGameRepository();
      when(() => repository.saveGame(any())).thenAnswer((_) async {});
      when(repository.deleteGame).thenAnswer((_) async {});
    });

    GameBloc buildBloc() =>
        GameBloc(engine: engine, repository: repository, seed: () => seed);

    test('initial state is $GameLoading', () {
      expect(buildBloc().state, equals(const GameLoading()));
    });

    group('$GameStarted', () {
      final started = rules.start(const StartGame(playerCount: 4, seed: seed));

      blocTest<GameBloc, GameViewState>(
        'emits $GameInProgress with a new game',
        build: buildBloc,
        act: (bloc) => bloc.add(const GameStarted(playerCount: 4)),
        expect: () => [GameInProgress(game: started)],
      );

      blocTest<GameBloc, GameViewState>(
        'T-020: saves the new game',
        build: buildBloc,
        act: (bloc) => bloc.add(const GameStarted(playerCount: 4)),
        verify: (_) => verify(() => repository.saveGame(started)).called(1),
      );

      blocTest<GameBloc, GameViewState>(
        'keeps playing when saving fails',
        setUp: () =>
            when(() => repository.saveGame(any()))
                .thenThrow(const SaveGameException('full')),
        build: buildBloc,
        act: (bloc) => bloc.add(const GameStarted(playerCount: 4)),
        expect: () => [GameInProgress(game: started)],
        errors: () => [isA<SaveGameException>()],
      );
    });

    group('$GameResumed', () {
      final saved = buildGameState(round: 5);

      blocTest<GameBloc, GameViewState>(
        'F-04: emits $GameInProgress with the saved game',
        setUp: () => when(repository.loadGame).thenAnswer((_) async => saved),
        build: buildBloc,
        act: (bloc) => bloc.add(const GameResumed()),
        expect: () => [const GameLoading(), GameInProgress(game: saved)],
      );

      blocTest<GameBloc, GameViewState>(
        'emits $GameFailure without a saved game',
        setUp: () => when(repository.loadGame).thenAnswer((_) async => null),
        build: buildBloc,
        act: (bloc) => bloc.add(const GameResumed()),
        expect: () => [
          const GameLoading(),
          const GameFailure(GameFailureReason.noSavedGame),
        ],
      );

      blocTest<GameBloc, GameViewState>(
        'emits $GameFailure when the saved game cannot be loaded',
        setUp: () =>
            when(repository.loadGame)
                .thenThrow(const LoadGameException('broken')),
        build: buildBloc,
        act: (bloc) => bloc.add(const GameResumed()),
        expect: () => [
          const GameLoading(),
          const GameFailure(GameFailureReason.loadFailed),
        ],
      );

      final finished = buildGameState(
        phase: GamePhase.finished,
        outcome: GameOutcome.victory,
      );

      blocTest<GameBloc, GameViewState>(
        'emits $GameFinished for a finished saved game',
        setUp: () =>
            when(repository.loadGame).thenAnswer((_) async => finished),
        build: buildBloc,
        act: (bloc) => bloc.add(const GameResumed()),
        expect: () => [const GameLoading(), GameFinished(game: finished)],
      );
    });

    group('$GameCommandSubmitted', () {
      final setup = buildGameState(
        round: 0,
        phase: GamePhase.setup,
        camp: const Camp(activists: 7, resources: 0),
        repressionDeck: List.filled(4, RepressionCard.surveillance),
      );
      final afterSetup = rules.apply(setup, const Continue());

      blocTest<GameBloc, GameViewState>(
        'applies the command and shows the new log entries',
        build: buildBloc,
        seed: () => GameInProgress(game: setup),
        act: (bloc) => bloc.add(const GameCommandSubmitted(Continue())),
        expect: () => [
          GameInProgress(
            game: afterSetup,
            pendingEntries: afterSetup.logEntriesSince(setup),
          ),
        ],
        verify: (_) => verify(() => repository.saveGame(afterSetup)).called(1),
      );

      blocTest<GameBloc, GameViewState>(
        'keeps the state when the command breaks a rule',
        build: buildBloc,
        seed: () => GameInProgress(game: setup),
        act: (bloc) => bloc.add(
          const GameCommandSubmitted(AssignToCard(ActionCardId.sabotage)),
        ),
        expect: () => <GameViewState>[],
        errors: () => [isA<InvalidPhaseException>()],
        verify: (_) => verifyNever(() => repository.saveGame(any())),
      );

      blocTest<GameBloc, GameViewState>(
        'ignores commands while log entries are shown',
        build: buildBloc,
        seed: () => GameInProgress(
          game: setup,
          pendingEntries: const [
            DiceRolled([1, 2]),
          ],
        ),
        act: (bloc) => bloc.add(const GameCommandSubmitted(Continue())),
        expect: () => <GameViewState>[],
      );

      blocTest<GameBloc, GameViewState>(
        'ignores commands without a running game',
        build: buildBloc,
        act: (bloc) => bloc.add(const GameCommandSubmitted(Continue())),
        expect: () => <GameViewState>[],
      );

      final lastRound = buildGameState(
        round: 12,
        phase: GamePhase.excavation,
        support: 1,
        pendingDecision: const ReturnActivistsDecision(),
      );
      final finished = rules.apply(lastRound, const Continue());

      blocTest<GameBloc, GameViewState>(
        'emits $GameFinished when the game ends without new entries',
        build: buildBloc,
        seed: () => GameInProgress(game: lastRound),
        act: (bloc) => bloc.add(const GameCommandSubmitted(Continue())),
        expect: () => [GameFinished(game: finished)],
      );

      blocTest<GameBloc, GameViewState>(
        'deletes the saved game when the game ends',
        build: buildBloc,
        seed: () => GameInProgress(game: lastRound),
        act: (bloc) => bloc.add(const GameCommandSubmitted(Continue())),
        verify: (_) {
          verify(repository.deleteGame).called(1);
          verifyNever(() => repository.saveGame(any()));
        },
      );
    });

    group('$GameLogEntryAcknowledged', () {
      final game = buildGameState();
      const first = DiceRolled([1, 2]);
      const second = RepressionCardDrawn(RepressionCard.raid);

      blocTest<GameBloc, GameViewState>(
        'removes the first pending entry',
        build: buildBloc,
        seed: () =>
            GameInProgress(game: game, pendingEntries: const [first, second]),
        act: (bloc) => bloc.add(const GameLogEntryAcknowledged()),
        expect: () => [
          GameInProgress(game: game, pendingEntries: const [second]),
        ],
      );

      final finished = buildGameState(
        phase: GamePhase.finished,
        outcome: GameOutcome.defeat,
      );

      blocTest<GameBloc, GameViewState>(
        'emits $GameFinished after the last entry of a finished game',
        build: buildBloc,
        seed: () =>
            GameInProgress(game: finished, pendingEntries: const [first]),
        act: (bloc) => bloc.add(const GameLogEntryAcknowledged()),
        expect: () => [GameFinished(game: finished)],
      );

      blocTest<GameBloc, GameViewState>(
        'does nothing without pending entries',
        build: buildBloc,
        seed: () => GameInProgress(game: game),
        act: (bloc) => bloc.add(const GameLogEntryAcknowledged()),
        expect: () => <GameViewState>[],
      );
    });
  });
}
