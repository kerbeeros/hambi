import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(GameBoard, () {
    const tablet = Size(1024, 1366);

    Widget board({
      GameState? game,
      BoardSection tab = BoardSection.actions,
      ValueChanged<BoardSection>? onTabSelected,
      ValueChanged<GameCommand>? onCommand,
      VoidCallback? onLogPressed,
      VoidCallback? onMenuPressed,
    }) => GameBoard(
      game: game ?? buildGameState(round: 3),
      tab: tab,
      onTabSelected: onTabSelected ?? (_) {},
      onCommand: onCommand ?? (_) {},
      onLogPressed: onLogPressed ?? () {},
      onMenuPressed: onMenuPressed ?? () {},
    );

    testWidgets('shows round and phase in the header', (tester) async {
      await tester.pumpApp(board());

      expect(find.text('Runde 3/12'), findsOneWidget);
      expect(find.text('Vorbereitung'), findsWidgets);
    });

    testWidgets('shows the setup title before round 1', (tester) async {
      await tester.pumpApp(
        board(game: buildGameState(round: 0, phase: GamePhase.setup)),
      );

      expect(find.text('Spielaufbau'), findsOneWidget);
    });

    testWidgets('ADR 0003: shows the action board on the actions tab', (
      tester,
    ) async {
      await tester.pumpApp(board());

      expect(find.byType(ActionBoard), findsOneWidget);
      expect(find.byType(ForestGrid), findsNothing);
    });

    testWidgets('ADR 0003: shows the forest on the forest tab', (tester) async {
      await tester.pumpApp(board(tab: BoardSection.forest));

      expect(find.byType(ForestGrid), findsOneWidget);
      expect(find.byType(ActionBoard), findsNothing);
    });

    testWidgets('ADR 0003: the forest tab shows the threatened cards', (
      tester,
    ) async {
      await tester.pumpApp(board());

      final tabs = tester.widget<BoardTabs>(find.byType(BoardTabs));
      expect(tabs.tabs.first.badgeCount, equals(3));
    });

    testWidgets('reports tab changes', (tester) async {
      final tabs = <BoardSection>[];
      await tester.pumpApp(board(onTabSelected: tabs.add));

      await tester.tap(find.text('Wald'));

      expect(tabs, equals([BoardSection.forest]));
    });

    testWidgets('UX-09: shows forest and actions side by side on tablets', (
      tester,
    ) async {
      await tester.pumpApp(board(), size: tablet);

      expect(find.byType(ForestGrid), findsOneWidget);
      expect(find.byType(ActionBoard), findsOneWidget);
      expect(find.byType(BoardTabs), findsNothing);
    });

    testWidgets('UX-01: ends the preparation with the primary action', (
      tester,
    ) async {
      final commands = <GameCommand>[];
      await tester.pumpApp(board(onCommand: commands.add));

      await tester.tap(find.text('Vorbereitung beenden'));

      expect(commands, equals([const EndPreparation()]));
    });

    testWidgets('R-113: starts the initial repression from the setup', (
      tester,
    ) async {
      final commands = <GameCommand>[];
      await tester.pumpApp(
        board(
          game: buildGameState(round: 0, phase: GamePhase.setup),
          onCommand: commands.add,
        ),
      );

      await tester.tap(find.text('Start-Repression ausführen'));

      expect(commands, equals([const Continue()]));
    });

    testWidgets('disables the primary action while a decision is open', (
      tester,
    ) async {
      await tester.pumpApp(
        board(
          game: buildGameState(
            phase: GamePhase.excavation,
            pendingDecision: const ReturnActivistsDecision(),
          ),
        ),
      );

      final button = tester.widget<HambiButton>(find.byType(HambiButton));
      expect(button.label, equals('Weiter'));
      expect(button.onPressed, isNull);
    });

    testWidgets('forwards card taps as moves', (tester) async {
      final commands = <GameCommand>[];
      await tester.pumpApp(board(onCommand: commands.add));

      await tester.tap(find.text('Sabotage'));

      expect(commands, equals([const AssignToCard(ActionCardId.sabotage)]));
    });

    testWidgets('opens log and menu from the header', (tester) async {
      var log = 0;
      var menu = 0;
      await tester.pumpApp(
        board(onLogPressed: () => log++, onMenuPressed: () => menu++),
      );

      await tester.tap(find.byTooltip('Rundenlog'));
      await tester.tap(find.byTooltip('Spielmenü'));

      expect((log, menu), equals((1, 1)));
    });
  });
}
