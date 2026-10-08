import 'dart:math';

import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

void main() {
  group('simulation', () {
    late GameEngine engine;

    setUp(() {
      engine = const GameEngine(XorShiftRandomGenerator());
    });

    test('T-042: 1000 seeded games end without exceptions '
        'and keep all invariants', () {
      for (var seed = 0; seed < 1000; seed++) {
        final states = _play(engine, seed)..forEach(_checkInvariants);
        expect(states.last.phase, equals(GamePhase.finished));
      }
    });

    test('AC-043: the same seed and moves produce identical states', () {
      for (var seed = 0; seed < 20; seed++) {
        expect(_play(engine, seed), equals(_play(engine, seed)));
      }
    });
  });
}

const _maxCommands = 5000;

/// Plays a whole game with random valid moves and returns every state.
List<GameState> _play(GameEngine engine, int seed) {
  final random = Random(seed);
  var state = engine.start(
    StartGame(playerCount: random.nextInt(11) + 1, seed: seed),
  );
  final states = [state];
  for (var i = 0; i < _maxCommands; i++) {
    if (state.phase == GamePhase.finished) return states;
    state = _move(engine, state, random);
    states.add(state);
  }
  fail('Game $seed did not finish after $_maxCommands commands');
}

/// Applies a random valid command.
GameState _move(GameEngine engine, GameState state, Random random) {
  T pick<T>(List<T> options) => options[random.nextInt(options.length)];

  final forest = state.forest;
  List<ForestPosition> positionsWhere(bool Function(ForestCard) test) => [
    for (var c = 0; c < Forest.columnCount; c++)
      for (var p = 0; p < Forest.cardsPerColumn; p++)
        if (test(forest.columns[c][p])) ForestPosition(column: c, position: p),
  ];

  final command = switch (state.pendingDecision) {
    PlaceActivistsDecision() => pick([
      for (final position in positionsWhere((card) => card.canHoldActivist))
        PlaceActivistOnForest(
          column: position.column,
          position: position.position,
        ),
    ]),
    RerollDecision() => pick(const [RerollDie(0), RerollDie(1), Continue()]),
    ReturnActivistsDecision() => ReturnActivistsToCamp({
      for (final position in positionsWhere((card) => card.hasActivist))
        if (random.nextBool()) position,
    }),
    NegativePressDecision() => ResolveNegativePress(
      pick(NegativePressChoice.values),
    ),
    RestoreCardDecision() => ChooseCardToRestore(
      pick([
        for (final MapEntry(key: card, value: side) in state.cardSides.entries)
          if (side == CardSide.b) card,
      ]),
    ),
    SecurityPlacementDecision(:final column) => ChooseSecurityCard(
      pick([
        for (var p = 0; p < Forest.cardsPerColumn; p++)
          if (forest.columns[column][p].state != ForestCardState.removed &&
              !forest.columns[column][p].hasSecurity)
            p,
      ]),
    ),
    null when state.phase == GamePhase.preparation => _preparationMove(
      engine,
      state,
      random,
    ),
    null => const Continue(),
  };
  return engine.apply(state, command);
}

/// Assigns or undoes a random card, or ends the preparation.
GameCommand _preparationMove(
  GameEngine engine,
  GameState state,
  Random random,
) {
  if (random.nextInt(4) == 0) return const EndPreparation();
  final card = ActionCardId.values[random.nextInt(ActionCardId.values.length)];
  if (state.assignedCards.contains(card)) {
    return random.nextInt(3) == 0
        ? UndoAssignment(card)
        : const EndPreparation();
  }
  try {
    engine.apply(state, AssignToCard(card));
    return AssignToCard(card);
  } on GameException {
    return const EndPreparation();
  }
}

void _checkInvariants(GameState state) {
  final cards = state.forest.cards.toList();
  expect(cards, hasLength(12));
  expect(state.activistsInPlay, inInclusiveRange(0, GameState.maxActivists));
  expect(state.camp.activists, greaterThanOrEqualTo(0));
  expect(state.camp.resources, inInclusiveRange(0, GameState.maxResources));
  expect(state.support, inInclusiveRange(0, GameState.maxSupport));
  expect(state.round, inInclusiveRange(0, GameState.lastRound));
  expect(
    cards.where((card) => card.hasSecurity),
    hasLength(lessThanOrEqualTo(GameState.maxSecurityGuards)),
  );
  for (final card in cards) {
    expect(card.hasActivist && card.hasSecurity, isFalse);
    if (card.state == ForestCardState.removed) {
      expect(card.hasActivist || card.hasSecurity, isFalse);
    }
  }
  final repressionCards = [...state.repressionDeck, ...state.repressionInPlay];
  for (final card in RepressionCard.values) {
    final count = repressionCards.where((c) => c == card).length;
    final expected = card.copies;
    if (card.type == RepressionCardType.oneTime) {
      expect(count, anyOf(equals(0), equals(expected)));
      if (count == 0) expect(state.cardSides[card.flips], isNotNull);
    } else {
      expect(count, equals(expected), reason: '$card must stay in the game');
    }
  }
  expect(state.outcome != null, equals(state.phase == GamePhase.finished));
  if (state.phase == GamePhase.preparation) {
    expect(state.pendingDecision, isNull);
  }
}
