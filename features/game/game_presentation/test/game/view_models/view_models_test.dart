import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  late GameLocalizations l10n;

  setUpAll(() {
    l10n = lookupGameLocalizations(const Locale('de'));
  });

  group('ActionCardPresentation', () {
    for (final (card, category) in [
      (ActionCardId.sabotage, ActionCardCategory.directAction),
      (ActionCardId.legalTeam, ActionCardCategory.directAction),
      (ActionCardId.civilDisobedience, ActionCardCategory.directAction),
      (ActionCardId.blockade, ActionCardCategory.directAction),
      (ActionCardId.treeHouse, ActionCardCategory.directAction),
      (ActionCardId.demo, ActionCardCategory.campaign),
      (ActionCardId.publicity, ActionCardCategory.campaign),
      (ActionCardId.internet, ActionCardCategory.campaign),
      (ActionCardId.hardwareStore, ActionCardCategory.support),
      (ActionCardId.ruralCommune, ActionCardCategory.support),
      (ActionCardId.autonomousCentre, ActionCardCategory.support),
      (ActionCardId.allies, ActionCardCategory.support),
    ]) {
      test('R-021: $card belongs to $category', () {
        expect(card.category, equals(category));
      });
    }

    test('every card has a German title', () {
      expect({
        for (final card in ActionCardId.values) card.title(l10n),
      }, hasLength(ActionCardId.values.length));
      expect(ActionCardId.autonomousCentre.title(l10n), 'Autonomes Zentrum');
    });

    test('R-035: demo needs 5 activists and a resource', () {
      expect(
        ActionCardId.demo.conditions(CardSide.a),
        equals([...List.filled(5, CardSymbol.activist), CardSymbol.resource]),
      );
    });

    test('R-032: civil disobedience costs support', () {
      expect(
        ActionCardId.civilDisobedience.conditions(CardSide.a),
        equals([CardSymbol.activist, CardSymbol.loseSupport]),
      );
    });

    test('R-035: demo brings 2 support and an activist', () {
      expect(
        ActionCardId.demo.effects(CardSide.a),
        equals([
          CardSymbol.gainSupport,
          CardSymbol.gainSupport,
          CardSymbol.gainActivist,
        ]),
      );
    });

    test('R-040: the autonomous centre brings a resource and an activist', () {
      expect(
        ActionCardId.autonomousCentre.effects(CardSide.a),
        equals([CardSymbol.gainResource, CardSymbol.gainActivist]),
      );
    });

    test('R-033: blockade moves the activist onto the forest', () {
      expect(
        ActionCardId.blockade.effects(CardSide.a),
        equals([CardSymbol.activistToForest]),
      );
    });

    test('R-030: sabotage rerolls a die', () {
      expect(
        ActionCardId.sabotage.effects(CardSide.a),
        equals([CardSymbol.rerollDie]),
      );
    });

    test('R-031: the legal team prevents a repression card', () {
      expect(
        ActionCardId.legalTeam.effects(CardSide.a),
        equals([CardSymbol.preventRepression]),
      );
    });

    test('R-037: internet on side B only brings support', () {
      expect(
        ActionCardId.internet.effects(CardSide.b),
        equals([CardSymbol.gainSupport]),
      );
    });
  });

  group('AssignmentStatusPresentation', () {
    for (final (status, viewStatus, label) in [
      (AssignmentStatus.available, ActionCardStatus.available, null),
      (AssignmentStatus.assigned, ActionCardStatus.assigned, null),
      (AssignmentStatus.blocked, ActionCardStatus.blocked, 'Blockiert'),
      (
        AssignmentStatus.notEnoughActivists,
        ActionCardStatus.unavailable,
        'Zu wenig M',
      ),
      (
        AssignmentStatus.notEnoughResources,
        ActionCardStatus.unavailable,
        'Zu wenig R',
      ),
      (
        AssignmentStatus.notEnoughSupport,
        ActionCardStatus.unavailable,
        'Zu wenig U',
      ),
      (AssignmentStatus.notInPreparation, ActionCardStatus.available, null),
    ]) {
      test('UX-02: $status is shown as $viewStatus with "$label"', () {
        expect(status.viewStatus, equals(viewStatus));
        expect(status.label(l10n), equals(label));
      });
    }
  });

  group('ForestCardPresentation', () {
    for (final (card, state, occupant) in [
      (const ForestCard(), ForestCardViewState.intact, ForestCardOccupant.none),
      (
        const ForestCard(state: ForestCardState.clearCut, hasActivist: true),
        ForestCardViewState.cleared,
        ForestCardOccupant.activist,
      ),
      (
        const ForestCard(state: ForestCardState.removed),
        ForestCardViewState.removed,
        ForestCardOccupant.none,
      ),
      (
        const ForestCard(hasSecurity: true),
        ForestCardViewState.intact,
        ForestCardOccupant.secu,
      ),
    ]) {
      test('R-001: $card is shown as $state with $occupant', () {
        expect(card.viewState, equals(state));
        expect(card.occupant, equals(occupant));
      });
    }

    test('NF-04: describes a card for screen readers', () {
      expect(
        const ForestCard(
          state: ForestCardState.clearCut,
          hasActivist: true,
        ).semanticLabel(l10n, column: 0, position: 2, isThreatened: true),
        equals('WS1, Karte 3: abgeholzt, mit Mitstreiter*in, bedroht'),
      );
      expect(
        const ForestCard(hasSecurity: true)
            .semanticLabel(l10n, column: 2, position: 0, isThreatened: false),
        equals('WS3, Karte 1: Wald, mit Secu'),
      );
      expect(
        const ForestCard(state: ForestCardState.removed)
            .semanticLabel(l10n, column: 1, position: 3, isThreatened: false),
        equals('WS2, Karte 4: entfernt'),
      );
    });
  });

  group('RepressionCardPresentation', () {
    test('every card has a title and a description', () {
      for (final card in RepressionCard.values) {
        expect(card.title(l10n), isNotEmpty);
        expect(card.description(l10n), isNotEmpty);
      }
      expect({
        for (final card in RepressionCard.values) card.title(l10n),
      }, hasLength(RepressionCard.values.length));
    });

    for (final (card, kind) in [
      (RepressionCard.raid, RepressionCardKind.immediate),
      (RepressionCard.assemblyBan, RepressionCardKind.blocking),
      (RepressionCard.threat, RepressionCardKind.oneTime),
    ]) {
      test('$card is shown as $kind', () {
        expect(card.kind, equals(kind));
      });
    }
  });

  group('GamePhasePresentation', () {
    for (final (phase, label, index) in [
      (GamePhase.setup, 'Start-Repression', 3),
      (GamePhase.preparation, 'Vorbereitung', 0),
      (GamePhase.action, 'Aktion', 1),
      (GamePhase.excavation, 'Bagger', 2),
      (GamePhase.repression, 'Repression', 3),
      (GamePhase.finished, 'Spielende', null),
    ]) {
      test('$phase is "$label" at step $index', () {
        expect(phase.label(l10n), equals(label));
        expect(phase.stepIndex, equals(index));
      });
    }
  });

  group('GameLogEntryPresentation', () {
    for (final (entry, text) in [
      (const DiceRolled([2, 5]), 'Bagger würfelt 2 und 5'),
      (
        const DieRerolled(index: 1, value: 6),
        'Sabotage: Würfel 2 neu geworfen, zeigt 6',
      ),
      (
        const RepressionCardDrawn(RepressionCard.raid),
        'Repressionskarte gezogen: Razzia',
      ),
      (const RepressionDieRolled(4), 'Würfel für Repression: 4'),
    ]) {
      test('F-07: describes $entry', () {
        expect(entry.describe(l10n), equals(text));
      });
    }
  });
}
