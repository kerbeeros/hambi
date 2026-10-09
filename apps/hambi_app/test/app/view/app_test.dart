import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:hambi_app/app/app.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rules_presentation/rules_presentation.dart';
import 'package:setup_presentation/setup_presentation.dart';
import 'package:ui_kit/ui_kit.dart';

class _MockGameRepository extends Mock implements IGameRepository;

void main() {
  group(App, () {
    late IGameRepository repository;

    setUpAll(() {
      registerFallbackValue(
        const GameEngine(XorShiftRandomGenerator())
            .start(const StartGame(playerCount: 3, seed: 1)),
      );
    });

    setUp(() {
      repository = _MockGameRepository();
      when(repository.hasSavedGame).thenAnswer((_) async => false);
      when(() => repository.saveGame(any())).thenAnswer((_) async {});
    });

    Future<void> pumpApp(WidgetTester tester) async {
      tester.view
        ..physicalSize = const Size(393, 852)
        ..devicePixelRatio = 1;
      tester.platformDispatcher.localesTestValue = const [Locale('de')];
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);
      await tester.pumpWidget(App(gameRepository: repository));
      await tester.pumpAndSettle();
    }

    testWidgets('uses $AppTheme', (tester) async {
      await pumpApp(tester);

      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app.theme, equals(AppTheme.light));
    });

    testWidgets('S-01: opens on the start screen', (tester) async {
      await pumpApp(tester);

      expect(find.byType(StartView), findsOneWidget);
      expect(find.text('Hambi bleibt!'), findsOneWidget);
    });

    testWidgets('F-01: starts a new game through the setup', (tester) async {
      await pumpApp(tester);

      await tester.tap(find.text('Neues Spiel'));
      await tester.pumpAndSettle();
      expect(find.byType(SetupView), findsOneWidget);

      await tester.tap(find.text('Spiel starten'));
      await tester.pumpAndSettle();
      expect(find.byType(GameView), findsOneWidget);
      expect(find.text('Spielaufbau'), findsOneWidget);
    });

    testWidgets('returns from the setup to the start', (tester) async {
      await pumpApp(tester);

      await tester.tap(find.text('Neues Spiel'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Zurück'));
      await tester.pumpAndSettle();

      expect(find.byType(StartView), findsOneWidget);
    });

    testWidgets('F-04: continues the saved game', (tester) async {
      when(repository.hasSavedGame).thenAnswer((_) async => true);
      when(repository.loadGame).thenAnswer(
        (_) async =>
            const GameEngine(XorShiftRandomGenerator())
                .start(const StartGame(playerCount: 2, seed: 3))
                .copyWith(round: 4, phase: GamePhase.preparation),
      );
      await pumpApp(tester);

      await tester.tap(find.text('Fortsetzen'));
      await tester.pumpAndSettle();

      expect(find.text('Runde 4/12'), findsOneWidget);
    });

    testWidgets('UX-08: leaving the game returns to the start', (tester) async {
      await pumpApp(tester);
      await tester.tap(find.text('Neues Spiel'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Spiel starten'));
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Spielmenü'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Spiel abbrechen'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Spiel abbrechen').last);
      await tester.pumpAndSettle();

      expect(find.byType(StartView), findsOneWidget);
    });

    testWidgets('UX-10: opens the rules from the start and goes back', (
      tester,
    ) async {
      await pumpApp(tester);

      await tester.tap(find.text('Regeln'));
      await tester.pumpAndSettle();
      expect(find.byType(RulesView), findsOneWidget);

      await tester.tap(find.text('Zurück'));
      await tester.pumpAndSettle();
      expect(find.byType(StartView), findsOneWidget);
    });

    testWidgets('UX-10: opens the rules from the game and returns to it', (
      tester,
    ) async {
      await pumpApp(tester);
      await tester.tap(find.text('Neues Spiel'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Spiel starten'));
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Spielmenü'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Regeln'));
      await tester.pumpAndSettle();
      expect(find.byType(RulesView), findsOneWidget);

      await tester.tap(find.text('Zurück'));
      await tester.pumpAndSettle();
      expect(find.byType(GameView), findsOneWidget);
      expect(find.text('Spielaufbau'), findsOneWidget);
    });

    testWidgets('S-04: a new game after the result opens the setup', (
      tester,
    ) async {
      when(repository.hasSavedGame).thenAnswer((_) async => true);
      when(repository.loadGame).thenAnswer(
        (_) async => const GameEngine(XorShiftRandomGenerator())
            .start(const StartGame(playerCount: 2, seed: 3))
            .copyWith(
              round: 12,
              phase: GamePhase.finished,
              outcome: GameOutcome.defeat,
            ),
      );
      await pumpApp(tester);

      await tester.tap(find.text('Fortsetzen'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Neues Spiel'));
      await tester.pumpAndSettle();

      expect(find.byType(SetupView), findsOneWidget);
    });

    testWidgets('a failed resume leads back to the start', (tester) async {
      when(repository.hasSavedGame).thenAnswer((_) async => true);
      when(repository.loadGame).thenAnswer((_) async => null);
      await pumpApp(tester);

      await tester.tap(find.text('Fortsetzen'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Zum Start'));
      await tester.pumpAndSettle();

      expect(find.byType(StartView), findsOneWidget);
    });
  });
}
