part of 'game_engine.dart';

extension on GameEngine {
  static const int _minPlayers = 1;
  static const int _maxPlayers = GameState.maxActivists;

  GameState _start(StartGame command) {
    final playerCount = command.playerCount;
    if (playerCount < _minPlayers || playerCount > _maxPlayers) {
      throw InvalidPlayerCountException(playerCount);
    }
    final (:deck, :randomState) = _shuffle(
      RepressionCard.fullDeck,
      _random.seed(command.seed),
    );
    return GameState(
      playerCount: playerCount,
      forest: Forest.initial(),
      cardSides: {for (final card in ActionCardId.values) card: CardSide.a},
      camp: Camp(
        activists: playerCount,
        resources: _startingResources(playerCount),
      ),
      support: 0,
      round: 0,
      phase: GamePhase.setup,
      repressionDeck: deck,
      randomState: randomState,
    );
  }

  int _startingResources(int playerCount) => switch (playerCount) {
    1 => 2,
    2 => 1,
    _ => 0,
  };

  /// Fisher–Yates shuffle driven by the injected generator.
  ({List<RepressionCard> deck, int randomState}) _shuffle(
    List<RepressionCard> cards,
    int randomState,
  ) {
    final deck = [...cards];
    var state = randomState;
    for (var i = deck.length - 1; i > 0; i--) {
      final (:value, state: nextState) = _random.nextInt(state, i + 1);
      state = nextState;
      final card = deck[i];
      deck[i] = deck[value];
      deck[value] = card;
    }
    return (deck: deck, randomState: state);
  }
}
