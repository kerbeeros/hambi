import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

import '../helpers/helpers.dart';

void main() {
  group('assignmentStatus', () {
    AssignmentStatus statusOf(
      ActionCardId card, {
      Camp camp = const Camp(activists: 5, resources: 1),
      int support = 1,
      Set<ActionCardId> assignedCards = const {},
      List<RepressionCard> repressionInPlay = const [],
      Map<ActionCardId, CardSide> cardSides = const {},
    }) => buildGameState(
      phase: GamePhase.preparation,
      camp: camp,
      support: support,
      assignedCards: assignedCards,
      repressionInPlay: repressionInPlay,
      cardSides: cardSides,
    ).assignmentStatus(card);

    test('UX-02: a card with met conditions is available', () {
      expect(
        statusOf(ActionCardId.blockade),
        equals(AssignmentStatus.available),
      );
    });

    test('R-043: an assigned card is assigned', () {
      expect(
        statusOf(ActionCardId.blockade, assignedCards: {ActionCardId.blockade}),
        equals(AssignmentStatus.assigned),
      );
    });

    test('R-083: a blocked card is blocked', () {
      expect(
        statusOf(
          ActionCardId.demo,
          repressionInPlay: [RepressionCard.assemblyBan],
        ),
        equals(AssignmentStatus.blocked),
      );
    });

    test('R-042: missing activists are reported first', () {
      expect(
        statusOf(
          ActionCardId.demo,
          camp: const Camp(activists: 4, resources: 0),
        ),
        equals(AssignmentStatus.notEnoughActivists),
      );
    });

    test('AC-010: missing resources are reported', () {
      expect(
        statusOf(
          ActionCardId.blockade,
          camp: const Camp(activists: 5, resources: 0),
        ),
        equals(AssignmentStatus.notEnoughResources),
      );
    });

    test('AC-016: missing support is reported', () {
      expect(
        statusOf(ActionCardId.civilDisobedience, support: 0),
        equals(AssignmentStatus.notEnoughSupport),
      );
    });

    test('AC-013: the face-up side decides the conditions', () {
      expect(
        statusOf(
          ActionCardId.publicity,
          camp: const Camp(activists: 1, resources: 1),
          cardSides: {ActionCardId.publicity: CardSide.b},
        ),
        equals(AssignmentStatus.notEnoughActivists),
      );
    });

    test('is not in preparation outside the preparation phase', () {
      expect(
        buildGameState().assignmentStatus(ActionCardId.sabotage),
        equals(AssignmentStatus.notInPreparation),
      );
    });
  });

  group('targetPosition', () {
    test('R-123/Q4: is the first card of a column that is not removed', () {
      final forest = forestWith({
        (1, 0): const ForestCard(state: ForestCardState.removed),
      });
      expect(forest.targetPosition(0), equals(0));
      expect(forest.targetPosition(1), equals(1));
    });

    test('is null when the whole column is removed', () {
      final forest = forestWith({
        for (var p = 0; p < Forest.cardsPerColumn; p++)
          (2, p): const ForestCard(state: ForestCardState.removed),
      });
      expect(forest.targetPosition(2), isNull);
    });
  });

  group('threatenedPositions', () {
    test('are the targets of all columns without an activist', () {
      final forest = forestWith({
        (0, 0): const ForestCard(hasActivist: true),
        (1, 0): const ForestCard(state: ForestCardState.removed),
      });
      expect(
        forest.threatenedPositions,
        equals({
          const ForestPosition(column: 1, position: 1),
          const ForestPosition(column: 2, position: 0),
        }),
      );
    });
  });

  group('upcomingRepressionDraws', () {
    test('R-092: equals the activated repression fields', () {
      expect(
        buildGameState(
          camp: const Camp(activists: 7, resources: 0),
          support: 5,
        ).upcomingRepressionDraws,
        equals(3),
      );
    });

    for (final (description, assigned, activated) in [
      ('assigned', {ActionCardId.legalTeam}, <ActionCardId>{}),
      ('activated', <ActionCardId>{}, {ActionCardId.legalTeam}),
    ]) {
      test('R-092: an $description legal team prevents one draw', () {
        expect(
          buildGameState(
            camp: const Camp(activists: 6, resources: 0),
            assignedCards: assigned,
            activatedCards: activated,
          ).upcomingRepressionDraws,
          equals(2),
        );
      });
    }

    test('R-092: is never below 0', () {
      expect(
        buildGameState(
          camp: const Camp(activists: 0, resources: 0),
          activatedCards: {ActionCardId.legalTeam},
        ).upcomingRepressionDraws,
        equals(0),
      );
    });
  });

  group('logEntriesSince', () {
    const dice = DiceRolled([2, 5]);
    const drawn = RepressionCardDrawn(RepressionCard.raid);

    test('F-07: returns the entries added to the log', () {
      final previous = buildGameState(phase: GamePhase.repression, log: [dice]);
      final next = buildGameState(
        phase: GamePhase.repression,
        log: [dice, drawn],
      );
      expect(next.logEntriesSince(previous), equals([drawn]));
    });

    test('F-07: returns the whole log once a new action phase started', () {
      final previous = buildGameState(
        phase: GamePhase.preparation,
        log: [dice],
      );
      final next = buildGameState(phase: GamePhase.excavation, log: [dice]);
      expect(next.logEntriesSince(previous), equals([dice]));
    });

    test('returns nothing while preparing', () {
      final previous = buildGameState(
        phase: GamePhase.preparation,
        log: [dice],
      );
      final next = buildGameState(phase: GamePhase.preparation, log: [dice]);
      expect(next.logEntriesSince(previous), isEmpty);
    });
  });
}
