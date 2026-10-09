import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(CardDetailDialog, () {
    Future<void> open(
      WidgetTester tester,
      Future<void> Function(BuildContext context) show,
    ) async {
      await tester.pumpApp(const SizedBox());
      unawaited(show(tester.element(find.byType(SizedBox))));
      await tester.pumpAndSettle();
    }

    group('showActionCard', () {
      Future<void> openDemo(WidgetTester tester, GameState game) => open(
        tester,
        (context) => CardDetailDialog.showActionCard(
          context,
          game: game,
          card: ActionCardId.demo,
        ),
      );

      testWidgets('D-08: renders the card enlarged with its title', (
        tester,
      ) async {
        await openDemo(tester, buildGameState());

        expect(find.byType(ActionCardDetail), findsOneWidget);
        expect(find.byType(ActionCardView), findsOneWidget);
        expect(
          tester.getRect(find.byType(ActionCardView)).width,
          greaterThan(ActionCardView.width),
        );
        expect(find.text('Demo'), findsWidgets);
      });

      testWidgets('UX-07: explains conditions and effects with counts', (
        tester,
      ) async {
        await openDemo(tester, buildGameState());

        expect(find.text('Bedingungen'), findsOneWidget);
        expect(find.text('Effekte'), findsOneWidget);
        expect(find.text('5 ×'), findsOneWidget);
        expect(find.text('2 ×'), findsOneWidget);
        expect(
          find.text('Ihr müsst eine*n Mitstreiter*in einsetzen.'),
          findsOneWidget,
        );
        expect(
          find.text('Ihr müsst eine Ressource einsetzen.'),
          findsOneWidget,
        );
        expect(
          find.text('Steigert die öffentliche Unterstützung um ein Feld.'),
          findsOneWidget,
        );
        expect(
          find.text('Stellt eine*n neue*n Mitstreiter*in ins Camp.'),
          findsOneWidget,
        );
      });

      testWidgets('UX-07: explains the current side', (tester) async {
        await open(
          tester,
          (context) => CardDetailDialog.showActionCard(
            context,
            game: buildGameState(
              cardSides: {ActionCardId.internet: CardSide.b},
            ),
            card: ActionCardId.internet,
          ),
        );

        expect(
          tester.widget<ActionCardView>(find.byType(ActionCardView)).sideLabel,
          equals('B'),
        );
        expect(find.text('Legt eine Ressource in das Camp.'), findsNothing);
      });

      testWidgets('UX-07: shows why the card cannot be assigned', (
        tester,
      ) async {
        await openDemo(
          tester,
          buildGameState(camp: const Camp(activists: 1, resources: 1)),
        );

        expect(find.text('Zu wenig M'), findsWidgets);
      });

      testWidgets('UX-07: shows that the card is assigned', (tester) async {
        await openDemo(
          tester,
          buildGameState(assignedCards: {ActionCardId.demo}),
        );

        expect(find.text('Belegt'), findsOneWidget);
      });

      testWidgets('UX-10: shows side A without status when there is no game', (
        tester,
      ) async {
        await open(
          tester,
          (context) =>
              CardDetailDialog.showActionCard(context, card: ActionCardId.demo),
        );

        final view = tester.widget<ActionCardView>(find.byType(ActionCardView));
        expect(view.sideLabel, isNull);
        expect(view.status, equals(ActionCardStatus.available));
        expect(view.statusLabel, isNull);
        expect(find.text('5 ×'), findsOneWidget);
      });

      testWidgets('closes with the close button', (tester) async {
        await openDemo(tester, buildGameState());

        await tester.tap(find.text('Schließen'));
        await tester.pumpAndSettle();

        expect(find.byType(ActionCardDetail), findsNothing);
      });

      testWidgets('closes when tapping outside', (tester) async {
        await openDemo(tester, buildGameState());

        await tester.tapAt(Offset.zero);
        await tester.pumpAndSettle();

        expect(find.byType(ActionCardDetail), findsNothing);
      });
    });

    group('showForestCard', () {
      testWidgets('D-08: renders the card with its position and state', (
        tester,
      ) async {
        await open(
          tester,
          (context) => CardDetailDialog.showForestCard(
            context,
            card: const ForestCard(hasActivist: true),
            position: const ForestPosition(column: 0, position: 1),
            isThreatened: true,
          ),
        );

        expect(find.text('Waldspalte 1, Karte 2'), findsOneWidget);
        expect(
          tester.widget<ForestCardView>(find.byType(ForestCardView)).occupant,
          equals(ForestCardOccupant.activist),
        );
        expect(
          find.text('Wald: Wird die Karte getroffen, wird sie abgeholzt.'),
          findsOneWidget,
        );
        expect(
          find.text(
            'Bedroht: Der nächste Bagger in dieser Waldspalte trifft diese '
            'Karte.',
          ),
          findsOneWidget,
        );
      });

      testWidgets('closes with the close button', (tester) async {
        await open(
          tester,
          (context) => CardDetailDialog.showForestCard(
            context,
            card: const ForestCard(),
            position: const ForestPosition(column: 0, position: 0),
            isThreatened: false,
          ),
        );

        await tester.tap(find.text('Schließen'));
        await tester.pumpAndSettle();

        expect(find.byType(ForestCardDetail), findsNothing);
      });
    });

    group('showRepressionCard', () {
      testWidgets('D-08: renders the large card and explains its kind', (
        tester,
      ) async {
        await open(
          tester,
          (context) => CardDetailDialog.showRepressionCard(
            context,
            card: RepressionCard.assemblyBan,
          ),
        );

        final view = tester.widget<RepressionCardView>(
          find.byType(RepressionCardView),
        );
        expect(view.compact, isFalse);
        expect(view.kind, equals(RepressionCardKind.blocking));
        expect(
          find.text(
            'Blockierend: Die Karte gilt bis zur nächsten Repressionsphase.',
          ),
          findsOneWidget,
        );
      });

      testWidgets('closes with the close button', (tester) async {
        await open(
          tester,
          (context) => CardDetailDialog.showRepressionCard(
            context,
            card: RepressionCard.raid,
          ),
        );

        await tester.tap(find.text('Schließen'));
        await tester.pumpAndSettle();

        expect(find.byType(RepressionCardDetail), findsNothing);
      });
    });
  });
}
