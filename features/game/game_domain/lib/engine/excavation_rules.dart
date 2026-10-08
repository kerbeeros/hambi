part of 'game_engine.dart';

extension on GameEngine {
  static const int _diceCount = 2;
  static const int _dieSides = 6;

  /// Rolls the excavator dice (R-120) and offers a reroll after sabotage
  /// (R-121).
  GameState _startExcavation(GameState state) {
    var randomState = state.randomState;
    final dice = <int>[];
    for (var i = 0; i < _diceCount; i++) {
      final (:value, state: nextState) = _rollDie(randomState);
      dice.add(value);
      randomState = nextState;
    }
    final rolled = state.copyWith(
      phase: GamePhase.excavation,
      randomState: randomState,
      log: [...state.log, DiceRolled(dice)],
    );
    if (state.activatedCards.contains(ActionCardId.sabotage)) {
      return rolled.copyWith(pendingDecision: () => RerollDecision(dice));
    }
    return _resolveDice(rolled, dice);
  }

  GameState _reroll(GameState state, GameCommand command, int index) {
    final decision = state.pendingDecision;
    if (decision is! RerollDecision) throw InvalidDecisionException(command);
    if (index < 0 || index >= decision.dice.length) {
      throw InvalidDieException(index);
    }
    final (:value, state: randomState) = _rollDie(state.randomState);
    final dice = [...decision.dice]..[index] = value;
    return _resolveDice(
      state.copyWith(
        pendingDecision: () => null,
        randomState: randomState,
        log: [
          ...state.log,
          DieRerolled(index: index, value: value),
        ],
      ),
      dice,
    );
  }

  /// Rolls one die and returns its value (1–6).
  ({int value, int state}) _rollDie(int randomState) {
    final (:value, :state) = _random.nextInt(randomState, _dieSides);
    return (value: value + 1, state: state);
  }

  /// Resolves the dice one after another (R-122) and stops on a defeat.
  GameState _resolveDice(GameState state, List<int> dice) {
    var current = state;
    for (final die in dice) {
      current = _excavate(current, _columnForDie(die));
      if (current.outcome != null) return current;
    }
    return _afterExcavation(current);
  }

  /// Maps a die value to a forest column (R-120): 1–2 → WS1, 3–4 → WS2,
  /// 5–6 → WS3.
  int _columnForDie(int die) => (die - 1) ~/ 2;

  /// Hits the first card of [column] that is not removed (R-123, Q4).
  ///
  /// A column always has such a card: once all of its cards are removed,
  /// the game is lost (R-100).
  GameState _excavate(GameState state, int column) {
    final cards = state.forest.columns[column];
    final position = cards.indexWhere(
      (card) => card.state != ForestCardState.removed,
    );
    final target = cards[position];
    final hit = target.hasActivist
        ? target.copyWith(hasActivist: false)
        : ForestCard(
            state: target.state == ForestCardState.forest
                ? ForestCardState.clearCut
                : ForestCardState.removed,
          );
    final forest = state.forest.replace(
      column: column,
      position: position,
      card: hit,
    );
    return _checkDefeat(state.copyWith(forest: forest));
  }

  /// Loses the game as soon as a whole column is removed (R-100).
  GameState _checkDefeat(GameState state) {
    final columnRemoved = state.forest.columns.any(
      (column) => column.every((card) => card.state == ForestCardState.removed),
    );
    if (!columnRemoved) return state;
    return state.copyWith(
      outcome: GameOutcome.defeat,
      phase: GamePhase.finished,
      pendingDecision: () => null,
    );
  }

  /// Asks whether activists return from the forest (R-124).
  GameState _afterExcavation(GameState state) {
    if (state.forest.cards.any((card) => card.hasActivist)) {
      return state.copyWith(
        pendingDecision: () => const ReturnActivistsDecision(),
      );
    }
    return _startRepression(state);
  }

  GameState _returnActivists(
    GameState state,
    GameCommand command,
    Set<ForestPosition> positions,
  ) {
    if (state.pendingDecision is! ReturnActivistsDecision) {
      throw InvalidDecisionException(command);
    }
    var forest = state.forest;
    for (final ForestPosition(:column, :position) in positions) {
      if (!Forest.contains(column: column, position: position) ||
          !forest.columns[column][position].hasActivist) {
        throw InvalidForestCardException(column: column, position: position);
      }
      forest = forest.replace(
        column: column,
        position: position,
        card: forest.columns[column][position].copyWith(hasActivist: false),
      );
    }
    return _startRepression(
      state.copyWith(
        forest: forest,
        camp: Camp(
          activists: state.camp.activists + positions.length,
          resources: state.camp.resources,
        ),
        pendingDecision: () => null,
      ),
    );
  }
}
