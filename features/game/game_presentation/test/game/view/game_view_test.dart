import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

class _MockGameBloc extends MockBloc<GameEvent, GameViewState>
    implements GameBloc;

class _MockBoardTabCubit extends MockCubit<BoardSection>
    implements BoardTabCubit;

void main() {
  group(GameView, () {
    late GameBloc gameBloc;
    late BoardTabCubit tabCubit;
    late int exits;
    late int newGames;

    setUp(() {
      gameBloc = _MockGameBloc();
      tabCubit = _MockBoardTabCubit();
      when(() => tabCubit.state).thenReturn(BoardSection.actions);
      exits = 0;
      newGames = 0;
    });

    Future<void> pumpView(WidgetTester tester) => tester.pumpApp(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: gameBloc),
          BlocProvider.value(value: tabCubit),
        ],
        child: GameView(onExit: () => exits++, onNewGame: () => newGames++),
      ),
    );

    group('renders', () {
      testWidgets('a progress indicator while loading', (tester) async {
        when(() => gameBloc.state).thenReturn(const GameLoading());
        await pumpView(tester);

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      for (final (reason, text) in [
        (GameFailureReason.noSavedGame, 'Es gibt kein gespeichertes Spiel.'),
        (
          GameFailureReason.loadFailed,
          'Der Spielstand konnte nicht geladen werden.',
        ),
      ]) {
        testWidgets('the failure $reason', (tester) async {
          when(() => gameBloc.state).thenReturn(GameFailure(reason));
          await pumpView(tester);

          expect(find.text(text), findsOneWidget);
          await tester.tap(find.text('Zum Start'));
          expect(exits, equals(1));
        });
      }

      testWidgets('$GameBoard for a running game', (tester) async {
        when(() => gameBloc.state)
            .thenReturn(GameInProgress(game: buildGameState()));
        await pumpView(tester);

        expect(find.byType(GameBoard), findsOneWidget);
      });

      testWidgets('$GameResultView for a finished game', (tester) async {
        when(() => gameBloc.state).thenReturn(
          GameFinished(
            game: buildGameState(
              phase: GamePhase.finished,
              outcome: GameOutcome.victory,
            ),
          ),
        );
        await pumpView(tester);

        await tester.tap(find.text('Neues Spiel'));
        expect(newGames, equals(1));
      });
    });

    group('moves', () {
      testWidgets('submits moves of the board', (tester) async {
        when(() => gameBloc.state)
            .thenReturn(GameInProgress(game: buildGameState()));
        await pumpView(tester);

        await tester.tap(find.text('Vorbereitung beenden'));

        verify(() => gameBloc.add(const GameCommandSubmitted(EndPreparation())))
            .called(1);
      });

      testWidgets('switches the board section', (tester) async {
        when(() => gameBloc.state)
            .thenReturn(GameInProgress(game: buildGameState()));
        await pumpView(tester);

        await tester.tap(find.text('Wald'));

        verify(() => tabCubit.selected(BoardSection.forest)).called(1);
      });
    });

    group('listens', () {
      final game = buildGameState();

      testWidgets('UX-01: shows a new log entry and acknowledges it', (
        tester,
      ) async {
        whenListen(
          gameBloc,
          Stream.value(
            GameInProgress(
              game: game,
              pendingEntries: const [RepressionDieRolled(2)],
            ),
          ),
          initialState: GameInProgress(game: game),
        );
        await pumpView(tester);
        await tester.pumpAndSettle();

        expect(find.byType(DieView), findsOneWidget);
        await tester.tap(find.text('Weiter'));
        await tester.pumpAndSettle();

        verify(() => gameBloc.add(const GameLogEntryAcknowledged())).called(1);
      });

      testWidgets('UX-03: asks for a decision and submits it', (tester) async {
        whenListen(
          gameBloc,
          Stream.value(
            GameInProgress(
              game: buildGameState(
                phase: GamePhase.repression,
                pendingDecision: const NegativePressDecision(),
              ),
            ),
          ),
          initialState: GameInProgress(game: game),
        );
        await pumpView(tester);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Unterstützung −1'));
        await tester.pumpAndSettle();

        verify(
          () => gameBloc.add(
            const GameCommandSubmitted(
              ResolveNegativePress(NegativePressChoice.support),
            ),
          ),
        ).called(1);
      });

      testWidgets('ADR 0003: follows the phase with the board section', (
        tester,
      ) async {
        whenListen(
          gameBloc,
          Stream.value(
            GameInProgress(
              game: buildGameState(
                phase: GamePhase.excavation,
                pendingDecision: const ReturnActivistsDecision(),
              ),
            ),
          ),
          initialState: GameInProgress(game: game),
        );
        await pumpView(tester);
        await tester.pump();

        verify(() => tabCubit.phaseChanged(GamePhase.excavation)).called(1);
      });
    });

    group('header', () {
      testWidgets('D-09: opens the round log', (tester) async {
        when(() => gameBloc.state).thenReturn(
          GameInProgress(
            game: buildGameState(log: const [RepressionDieRolled(5)]),
          ),
        );
        await pumpView(tester);

        await tester.tap(find.byTooltip('Rundenlog'));
        await tester.pumpAndSettle();

        expect(find.text('Würfel für Repression: 5'), findsOneWidget);
      });

      testWidgets('UX-08: leaves the game from the menu', (tester) async {
        when(() => gameBloc.state)
            .thenReturn(GameInProgress(game: buildGameState()));
        await pumpView(tester);

        await tester.tap(find.byTooltip('Spielmenü'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Spiel abbrechen'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Spiel abbrechen').last);
        await tester.pumpAndSettle();

        expect(exits, equals(1));
      });

      testWidgets('stays in the game when the menu is closed', (tester) async {
        when(() => gameBloc.state)
            .thenReturn(GameInProgress(game: buildGameState()));
        await pumpView(tester);

        await tester.tap(find.byTooltip('Spielmenü'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Zurück zum Spiel'));
        await tester.pumpAndSettle();

        expect(exits, equals(0));
      });
    });
  });
}
