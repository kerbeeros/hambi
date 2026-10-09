import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';

import '../../helpers/helpers.dart';

void main() {
  group(RoundLogSheet, () {
    testWidgets('D-09: lists the entries of the round', (tester) async {
      await tester.pumpApp(
        const RoundLogSheet(
          log: [
            DiceRolled([2, 5]),
            RepressionDieRolled(3),
          ],
        ),
      );

      expect(find.text('Rundenlog'), findsOneWidget);
      expect(find.text('Bagger würfelt 2 und 5'), findsOneWidget);
      expect(find.text('Würfel für Repression: 3'), findsOneWidget);
    });

    testWidgets('D-09: says when nothing happened yet', (tester) async {
      await tester.pumpApp(const RoundLogSheet(log: []));

      expect(
        find.text('In dieser Runde ist noch nichts passiert.'),
        findsOneWidget,
      );
    });
  });

  group(GameMenuSheet, () {
    late Future<GameMenuAction?> result;

    Future<void> open(WidgetTester tester) async {
      await tester.pumpApp(const SizedBox());
      result = GameMenuSheet.show(tester.element(find.byType(SizedBox)));
      await tester.pumpAndSettle();
    }

    testWidgets('NF-04: screen readers open the rules', (tester) async {
      final semantics = tester.ensureSemantics();
      await open(tester);

      tester.semantics.tap(find.semantics.byLabel('Regeln'));
      await tester.pumpAndSettle();

      expect(await result, equals(GameMenuAction.rules));
      semantics.dispose();
    });

    testWidgets('UX-08: leaving the game needs a confirmation', (tester) async {
      await open(tester);

      await tester.tap(find.text('Spiel abbrechen'));
      await tester.pumpAndSettle();
      expect(find.text('Spiel abbrechen?'), findsOneWidget);

      await tester.tap(find.text('Spiel abbrechen').last);
      await tester.pumpAndSettle();
      expect(await result, equals(GameMenuAction.exit));
    });

    testWidgets('UX-08: keeps playing when leaving is cancelled', (
      tester,
    ) async {
      await open(tester);

      await tester.tap(find.text('Spiel abbrechen'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Weiterspielen'));
      await tester.pumpAndSettle();

      expect(await result, isNull);
    });

    testWidgets('returns to the game', (tester) async {
      await open(tester);

      await tester.tap(find.text('Zurück zum Spiel'));
      await tester.pumpAndSettle();

      expect(await result, isNull);
    });

    testWidgets('UX-10: opens the rules', (tester) async {
      await open(tester);

      await tester.tap(find.text('Regeln'));
      await tester.pumpAndSettle();

      expect(await result, equals(GameMenuAction.rules));
    });
  });
}
