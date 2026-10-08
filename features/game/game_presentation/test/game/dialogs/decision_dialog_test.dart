import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(DecisionDialog, () {
    late Future<GameCommand?> result;

    Future<void> open(
      WidgetTester tester,
      GameState game,
      PendingDecision decision,
    ) async {
      await tester.pumpApp(const SizedBox());
      result = DecisionDialog.show(
        tester.element(find.byType(SizedBox)),
        game: game,
        decision: decision,
      );
      await tester.pumpAndSettle();
    }

    testWidgets('D-01: places an activist on the tapped forest card', (
      tester,
    ) async {
      await open(
        tester,
        buildGameState(
          forest: Forest.initial().replace(
            column: 0,
            position: 0,
            card: const ForestCard(hasSecurity: true),
          ),
        ),
        const PlaceActivistsDecision(activists: 2),
      );

      expect(find.text('Wählt eine Waldkarte (2 übrig).'), findsOneWidget);
      await tester.tap(find.bySemanticsLabel(RegExp('^WS1, Karte 1')));
      await tester.pump();
      expect(find.byType(HambiDialog), findsOneWidget);

      await tester.tap(find.bySemanticsLabel(RegExp('^WS2, Karte 4')));
      await tester.pumpAndSettle();
      expect(
        await result,
        equals(const PlaceActivistOnForest(column: 1, position: 3)),
      );
    });

    testWidgets('D-01: places a security guard in the rolled column', (
      tester,
    ) async {
      await open(
        tester,
        buildGameState(),
        const SecurityPlacementDecision(column: 2),
      );

      expect(find.text('Wählt eine Karte in WS3 für den Secu.'), findsOne);
      await tester.tap(find.bySemanticsLabel(RegExp('^WS1, Karte 1')));
      await tester.pump();
      expect(find.byType(HambiDialog), findsOneWidget);

      await tester.tap(find.bySemanticsLabel(RegExp('^WS3, Karte 2')));
      await tester.pumpAndSettle();
      expect(await result, equals(const ChooseSecurityCard(1)));
    });

    for (final (label, command) in [
      ('Würfel 1 neu werfen', const RerollDie(0)),
      ('Würfel 2 neu werfen', const RerollDie(1)),
      ('Würfel behalten', const Continue()),
    ]) {
      testWidgets('D-02: "$label" returns $command', (tester) async {
        await open(tester, buildGameState(), const RerollDecision([2, 5]));

        expect(find.byType(DieView), findsNWidgets(2));
        await tester.tap(find.text(label));
        await tester.pumpAndSettle();
        expect(await result, equals(command));
      });
    }

    for (final (label, choice) in [
      ('Unterstützung −1', NegativePressChoice.support),
      ('Mitstreiter*in −1', NegativePressChoice.activist),
    ]) {
      testWidgets('D-03: "$label" resolves negative press', (tester) async {
        await open(tester, buildGameState(), const NegativePressDecision());

        await tester.tap(find.text(label));
        await tester.pumpAndSettle();
        expect(await result, equals(ResolveNegativePress(choice)));
      });
    }

    testWidgets('D-04: offers only cards on side B to restore', (tester) async {
      await open(
        tester,
        buildGameState(
          cardSides: {
            ActionCardId.internet: CardSide.b,
            ActionCardId.allies: CardSide.b,
          },
        ),
        const RestoreCardDecision(),
      );

      expect(find.byType(ActionCardView), findsNWidgets(2));
      await tester.tap(find.text('Verbündete'));
      await tester.pumpAndSettle();
      expect(
        await result,
        equals(const ChooseCardToRestore(ActionCardId.allies)),
      );
    });

    group('D-05', () {
      final game = buildGameState(
        forest: Forest.initial()
            .replace(
              column: 0,
              position: 1,
              card: const ForestCard(hasActivist: true),
            )
            .replace(
              column: 2,
              position: 2,
              card: const ForestCard(hasActivist: true),
            ),
      );

      testWidgets('returns the selected activists to the camp', (tester) async {
        await open(tester, game, const ReturnActivistsDecision());

        await tester.tap(find.bySemanticsLabel(RegExp('^WS1, Karte 2')));
        await tester.tap(find.bySemanticsLabel(RegExp('^WS2, Karte 1')));
        await tester.pump();
        await tester.tap(find.text('Auswahl zurückholen'));
        await tester.pumpAndSettle();

        expect(
          await result,
          equals(
            ReturnActivistsToCamp({
              const ForestPosition(column: 0, position: 1),
            }),
          ),
        );
      });

      testWidgets('keeps all activists on the forest', (tester) async {
        await open(tester, game, const ReturnActivistsDecision());

        await tester.tap(find.text('Alle bleiben im Wald'));
        await tester.pumpAndSettle();

        expect(await result, equals(const Continue()));
      });
    });
  });
}
