import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';

class _MockGameRepository extends Mock implements IGameRepository;

void main() {
  group(GameModule, () {
    late IGameRepository repository;

    setUpAll(() {
      registerFallbackValue(buildGameState());
    });

    setUp(() {
      repository = _MockGameRepository();
      when(() => repository.saveGame(any())).thenAnswer((_) async {});
    });

    Future<void> pumpModule(WidgetTester tester, GameLaunch launch) =>
        tester.pumpApp(
          RepositoryProvider.value(
            value: repository,
            child: GameModule(
              launch: launch,
              seed: () => 7,
              child: const GameView(
                onExit: _noop,
                onNewGame: _noop,
                onRules: _noop,
              ),
            ),
          ),
        );

    testWidgets('F-01: starts a new game for the chosen players', (
      tester,
    ) async {
      await pumpModule(tester, const NewGameLaunch(playerCount: 2));
      await tester.pump();

      final game = const GameEngine(XorShiftRandomGenerator())
          .start(const StartGame(playerCount: 2, seed: 7));
      verify(() => repository.saveGame(game)).called(1);
      expect(find.byType(GameBoard), findsOneWidget);
    });

    testWidgets('T-005: uses a random seed by default', (tester) async {
      await tester.pumpApp(
        RepositoryProvider.value(
          value: repository,
          child: const GameModule(
            launch: NewGameLaunch(playerCount: 3),
            child: GameView(onExit: _noop, onNewGame: _noop, onRules: _noop),
          ),
        ),
      );
      await tester.pump();

      final saved =
          verify(() => repository.saveGame(captureAny())).captured.single
              as GameState;
      expect(saved.playerCount, equals(3));
    });

    test('$GameLaunch supports value equality', () {
      // Non-const instances, so that equality is not decided by identity.
      // ignore: prefer_const_constructors
      expect(NewGameLaunch(playerCount: 2), equals(launchFor(2)));
      expect(launchFor(2), isNot(equals(launchFor(3))));
      // Non-const for the same reason.
      // ignore: prefer_const_constructors
      expect(ResumeGameLaunch(), equals(ResumeGameLaunch()));
    });

    testWidgets('F-04: resumes the saved game', (tester) async {
      when(repository.loadGame)
          .thenAnswer((_) async => buildGameState(round: 4));
      await pumpModule(tester, const ResumeGameLaunch());
      await tester.pump();

      expect(find.text('Runde 4/12'), findsOneWidget);
    });
  });
}

void _noop() {}

GameLaunch launchFor(int playerCount) =>
    NewGameLaunch(playerCount: playerCount);
