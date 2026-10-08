import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

void main() {
  group(GameEngine, () {
    late GameEngine engine;

    setUp(() {
      engine = const GameEngine(XorShiftRandomGenerator());
    });

    group('start', () {
      GameState start(int playerCount, {int seed = 1}) =>
          engine.start(StartGame(playerCount: playerCount, seed: seed));

      test('AC-001/R-023: 1 player starts with 1 activist and 2 resources', () {
        expect(start(1).camp, equals(const Camp(activists: 1, resources: 2)));
      });

      test('AC-002: 2 players start with 2 activists and 1 resource', () {
        expect(start(2).camp, equals(const Camp(activists: 2, resources: 1)));
      });

      test('AC-003: 5 players start with 5 activists and 0 resources', () {
        expect(start(5).camp, equals(const Camp(activists: 5, resources: 0)));
      });

      test('R-111: 11 players start with 11 activists and 0 resources', () {
        expect(start(11).camp, equals(const Camp(activists: 11, resources: 0)));
      });

      for (final playerCount in [0, 12]) {
        test(
          'throws $InvalidPlayerCountException for $playerCount players',
          () {
            expect(
              () => start(playerCount),
              throwsA(isA<InvalidPlayerCountException>()),
            );
          },
        );
      }

      test('AC-004/R-001/R-020/R-110: all 12 forest cards are untouched', () {
        final cards = start(3).forest.columns.expand((column) => column);
        expect(cards, hasLength(12));
        expect(cards, everyElement(equals(const ForestCard())));
      });

      test('AC-004/R-009/R-022: all action cards are on side A', () {
        expect(start(3).cardSides.values, everyElement(equals(CardSide.a)));
        expect(start(3).cardSides.keys, equals(ActionCardId.values));
      });

      test('AC-004/R-006: the clock is on 12 in the setup phase', () {
        final state = start(3);
        expect(state.clock, equals(12));
        expect(state.phase, equals(GamePhase.setup));
      });

      test('R-112: support starts at 0 (Q13)', () {
        expect(start(3).support, equals(0));
      });

      test('R-112: the activist track equals the player count', () {
        expect(start(7).activistsInPlay, equals(7));
      });

      test('R-010/R-066/R-112: the repression deck holds all 18 cards', () {
        final deck = start(3).repressionDeck;
        expect(deck, hasLength(18));
        expect(
          deck.where((card) => card == RepressionCard.security),
          hasLength(3),
        );
        expect(deck.toSet(), equals(RepressionCard.values.toSet()));
      });

      test('R-112: the repression deck is shuffled by seed', () {
        expect(
          start(3, seed: 3).repressionDeck,
          isNot(equals(start(3, seed: 2).repressionDeck)),
        );
      });

      test('T-005: the same seed yields the same state', () {
        expect(start(3, seed: 9), equals(start(3, seed: 9)));
      });
    });
  });
}
