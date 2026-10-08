import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(ActionBoard, () {
    ActionCardView cardTitled(WidgetTester tester, String title) => tester
        .widgetList<ActionCardView>(find.byType(ActionCardView))
        .firstWhere((card) => card.title == title);

    testWidgets('R-021: renders all action cards and the camp', (tester) async {
      await tester.pumpApp(ActionBoard(game: buildGameState()));

      expect(find.byType(ActionCardView), findsNWidgets(12));
      expect(find.byType(CampCardView), findsOneWidget);
    });

    testWidgets('UX-02: shows why a card cannot be assigned', (tester) async {
      await tester.pumpApp(
        ActionBoard(
          game: buildGameState(
            camp: const Camp(activists: 4, resources: 0),
            repressionInPlay: [RepressionCard.assemblyBan],
          ),
        ),
      );

      expect(
        cardTitled(tester, 'Blockade').status,
        equals(ActionCardStatus.unavailable),
      );
      expect(cardTitled(tester, 'Blockade').statusLabel, equals('Zu wenig R'));
      expect(
        cardTitled(tester, 'Demo').status,
        equals(ActionCardStatus.blocked),
      );
    });

    testWidgets('shows the side B label', (tester) async {
      await tester.pumpApp(
        ActionBoard(
          game: buildGameState(cardSides: {ActionCardId.allies: CardSide.b}),
        ),
      );

      expect(cardTitled(tester, 'Verbündete').sideLabel, equals('B'));
      expect(cardTitled(tester, 'Baumarkt').sideLabel, isNull);
    });

    testWidgets('UX-02: tapping an available card assigns it', (tester) async {
      final commands = <GameCommand>[];
      await tester.pumpApp(
        ActionBoard(game: buildGameState(), onCommand: commands.add),
      );

      await tester.tap(find.text('Sabotage'));

      expect(commands, equals([const AssignToCard(ActionCardId.sabotage)]));
    });

    testWidgets('F-06: tapping an assigned card undoes it', (tester) async {
      final commands = <GameCommand>[];
      await tester.pumpApp(
        ActionBoard(
          game: buildGameState(assignedCards: {ActionCardId.sabotage}),
          onCommand: commands.add,
        ),
      );

      await tester.tap(find.text('Sabotage'));

      expect(commands, equals([const UndoAssignment(ActionCardId.sabotage)]));
    });

    testWidgets('unavailable cards cannot be tapped', (tester) async {
      final commands = <GameCommand>[];
      await tester.pumpApp(
        ActionBoard(
          game: buildGameState(camp: const Camp(activists: 0, resources: 0)),
          onCommand: commands.add,
        ),
      );

      await tester.tap(find.text('Sabotage'));

      expect(commands, isEmpty);
    });

    testWidgets('shows the repression cards in play', (tester) async {
      await tester.pumpApp(
        ActionBoard(
          game: buildGameState(
            repressionInPlay: [RepressionCard.raid, RepressionCard.assemblyBan],
          ),
        ),
      );

      expect(find.byType(RepressionCardView), findsNWidgets(2));
      expect(find.text('Liegende Repressionskarten'), findsOneWidget);
    });

    testWidgets('hides the repression section when none are in play', (
      tester,
    ) async {
      await tester.pumpApp(ActionBoard(game: buildGameState()));

      expect(find.text('Liegende Repressionskarten'), findsNothing);
    });
  });
}
