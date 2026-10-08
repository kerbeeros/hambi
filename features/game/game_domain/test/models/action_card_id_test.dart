import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

void main() {
  group(ActionCardId, () {
    group('cost', () {
      const expectedCosts = {
        ActionCardId.sabotage: (
          'R-030',
          ActionCardCost(activists: 1),
          ActionCardCost(activists: 1),
        ),
        ActionCardId.legalTeam: (
          'R-031',
          ActionCardCost(activists: 1),
          ActionCardCost(activists: 1),
        ),
        ActionCardId.civilDisobedience: (
          'R-032',
          ActionCardCost(activists: 1, support: 1),
          ActionCardCost(activists: 1, support: 1),
        ),
        ActionCardId.blockade: (
          'R-033',
          ActionCardCost(activists: 1, resources: 1),
          ActionCardCost(activists: 1, resources: 1),
        ),
        ActionCardId.treeHouse: (
          'R-034',
          ActionCardCost(activists: 1, resources: 1),
          ActionCardCost(activists: 1, resources: 1),
        ),
        ActionCardId.demo: (
          'R-035',
          ActionCardCost(activists: 5, resources: 1),
          ActionCardCost(activists: 5, resources: 1),
        ),
        ActionCardId.publicity: (
          'R-036',
          ActionCardCost(activists: 1, resources: 1),
          ActionCardCost(activists: 2, resources: 1),
        ),
        ActionCardId.internet: (
          'R-037',
          ActionCardCost(activists: 1, resources: 1),
          ActionCardCost(activists: 1, resources: 1),
        ),
        ActionCardId.hardwareStore: (
          'R-038',
          ActionCardCost(activists: 1),
          ActionCardCost(activists: 2),
        ),
        ActionCardId.ruralCommune: (
          'R-039',
          ActionCardCost(activists: 1),
          ActionCardCost(activists: 2),
        ),
        ActionCardId.autonomousCentre: (
          'R-040',
          ActionCardCost(activists: 2),
          ActionCardCost(activists: 2),
        ),
        ActionCardId.allies: (
          'R-041',
          ActionCardCost(activists: 1),
          ActionCardCost(activists: 2),
        ),
      };

      for (final MapEntry(key: card, value: (rule, sideA, sideB))
          in expectedCosts.entries) {
        test('$rule: $card costs $sideA on side A and $sideB on side B', () {
          expect(card.cost(CardSide.a), equals(sideA));
          expect(card.cost(CardSide.b), equals(sideB));
        });
      }
    });
  });
}
