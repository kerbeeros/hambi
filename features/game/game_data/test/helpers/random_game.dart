import 'dart:math';

import 'package:game_domain/game_domain.dart';

/// Plays a seeded game with random valid moves and returns every state.
List<GameState> playRandomGame(int seed) {
  const engine = GameEngine(XorShiftRandomGenerator());
  final random = Random(seed);
  T pick<T>(List<T> options) => options[random.nextInt(options.length)];

  var state = engine.start(
    StartGame(playerCount: random.nextInt(11) + 1, seed: seed),
  );
  final states = [state];
  while (state.phase != GamePhase.finished) {
    final forest = state.forest;
    final positions = [
      for (var c = 0; c < Forest.columnCount; c++)
        for (var p = 0; p < Forest.cardsPerColumn; p++)
          (column: c, position: p, card: forest.columns[c][p]),
    ];
    final command = switch (state.pendingDecision) {
      PlaceActivistsDecision() => pick([
        for (final (:column, :position, :card) in positions)
          if (card.canHoldActivist)
            PlaceActivistOnForest(column: column, position: position),
      ]),
      RerollDecision() => const RerollDie(0),
      ReturnActivistsDecision() => ReturnActivistsToCamp({
        for (final (:column, :position, :card) in positions)
          if (card.hasActivist && random.nextBool())
            ForestPosition(column: column, position: position),
      }),
      NegativePressDecision() => ResolveNegativePress(
        pick(NegativePressChoice.values),
      ),
      RestoreCardDecision() => ChooseCardToRestore(
        state.cardSides.entries
            .firstWhere((entry) => entry.value == CardSide.b)
            .key,
      ),
      SecurityPlacementDecision(:final column) => ChooseSecurityCard(
        positions.indexWhere(
              (entry) =>
                  entry.column == column &&
                  entry.card.state != ForestCardState.removed &&
                  !entry.card.hasSecurity,
            ) -
            column * Forest.cardsPerColumn,
      ),
      null when state.phase == GamePhase.preparation => _assignOrEnd(
        engine,
        state,
        pick(ActionCardId.values),
      ),
      null => const Continue(),
    };
    state = engine.apply(state, command);
    states.add(state);
  }
  return states;
}

GameCommand _assignOrEnd(
  GameEngine engine,
  GameState state,
  ActionCardId card,
) {
  try {
    engine.apply(state, AssignToCard(card));
    return AssignToCard(card);
  } on GameException {
    return const EndPreparation();
  }
}
