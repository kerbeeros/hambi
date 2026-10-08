part of 'game_engine.dart';

extension on GameEngine {
  /// Starts the repression phase (R-090–R-093).
  GameState _startRepression(GameState state) {
    var deck = state.repressionDeck;
    var randomState = state.randomState;
    if (state.repressionInPlay.isNotEmpty) {
      (:deck, :randomState) = _shuffle([
        ...deck,
        ...state.repressionInPlay,
      ], randomState);
    }
    final draws = state.upcomingRepressionDraws;
    return _drawRepressionCards(
      state.copyWith(
        phase: GamePhase.repression,
        repressionDeck: deck,
        repressionInPlay: [],
        repressionCardsToDraw: draws,
        randomState: randomState,
      ),
    );
  }

  /// Draws and resolves cards one by one until a decision is needed or all
  /// cards are drawn (R-067, R-068).
  GameState _drawRepressionCards(GameState state) {
    var current = state;
    while (current.repressionCardsToDraw > 0 &&
        current.repressionDeck.isNotEmpty) {
      final [card, ...deck] = current.repressionDeck;
      current = _resolveRepressionCard(
        current.copyWith(
          repressionDeck: deck,
          repressionInPlay: [
            ...current.repressionInPlay,
            if (card.type != RepressionCardType.oneTime) card,
          ],
          repressionCardsToDraw: current.repressionCardsToDraw - 1,
          log: [...current.log, RepressionCardDrawn(card)],
        ),
        card,
      );
      if (current.pendingDecision != null || current.outcome != null) {
        return current;
      }
    }
    return _startNextRound(current.copyWith(repressionCardsToDraw: 0));
  }

  /// Starts the next round (R-080), or evaluates the game after the last
  /// round (R-101, Q9, Q16).
  GameState _startNextRound(GameState state) {
    if (state.round == GameState.lastRound) {
      return state.copyWith(
        phase: GamePhase.finished,
        outcome: state.support > state.removedForestCards
            ? GameOutcome.victory
            : GameOutcome.defeat,
      );
    }
    return state.copyWith(
      round: state.round + 1,
      phase: GamePhase.preparation,
      activatedCards: {},
    );
  }

  GameState _resolveRepressionCard(GameState state, RepressionCard card) {
    if (card.flips case final target?) {
      return state.copyWith(
        cardSides: {...state.cardSides, target: CardSide.b},
      );
    }
    return switch (card) {
      RepressionCard.security => _startSecurity(state),
      RepressionCard.raid => _withResources(state, state.camp.resources ~/ 2),
      RepressionCard.nightShift => _nightShift(state),
      RepressionCard.negativePress => _negativePress(state),
      RepressionCard.publicProtection => _withResources(
        state,
        math.min(state.camp.resources + 1, GameState.maxResources),
      ),
      RepressionCard.legalAid => _legalAid(state),
      _ => state,
    };
  }

  GameState _withResources(GameState state, int resources) => state.copyWith(
    camp: Camp(activists: state.camp.activists, resources: resources),
  );

  ({int value, GameState state}) _rollRepressionDie(GameState state) {
    final (:value, state: randomState) = _rollDie(state.randomState);
    return (
      value: value,
      state: state.copyWith(
        randomState: randomState,
        log: [...state.log, RepressionDieRolled(value)],
      ),
    );
  }

  /// Night shift: one excavator die (R-052).
  GameState _nightShift(GameState state) {
    final (:value, state: rolled) = _rollRepressionDie(state);
    return _excavate(rolled, _columnForDie(value));
  }

  /// Negative press: lower support or remove an activist (R-053, Q18).
  GameState _negativePress(GameState state) {
    final canLowerSupport = state.support > 0;
    final canRemoveActivist = state.activistsInPlay > 0;
    if (canLowerSupport && canRemoveActivist) {
      return state.copyWith(
        pendingDecision: () => const NegativePressDecision(),
      );
    }
    if (canLowerSupport) return state.copyWith(support: state.support - 1);
    if (canRemoveActivist) return _removeActivist(state);
    return state;
  }

  GameState _resolveNegativePress(
    GameState state,
    GameCommand command,
    NegativePressChoice choice,
  ) {
    if (state.pendingDecision is! NegativePressDecision) {
      throw InvalidDecisionException(command);
    }
    final resolved = state.copyWith(pendingDecision: () => null);
    return _drawRepressionCards(switch (choice) {
      NegativePressChoice.support => resolved.copyWith(
        support: state.support - 1,
      ),
      NegativePressChoice.activist => _removeActivist(resolved),
    });
  }

  /// Removes an activist from the camp, or else the first one on the
  /// forest (Q20).
  GameState _removeActivist(GameState state) {
    final camp = state.camp;
    if (camp.activists > 0) {
      return state.copyWith(
        camp: Camp(activists: camp.activists - 1, resources: camp.resources),
      );
    }
    for (var column = 0; column < Forest.columnCount; column++) {
      for (var position = 0; position < Forest.cardsPerColumn; position++) {
        final card = state.forest.columns[column][position];
        if (card.hasActivist) {
          return state.copyWith(
            forest: state.forest.replace(
              column: column,
              position: position,
              card: card.copyWith(hasActivist: false),
            ),
          );
        }
      }
    }
    return state;
  }

  /// Legal aid: turn a card on side B back to side A (R-055).
  GameState _legalAid(GameState state) {
    if (!state.cardSides.containsValue(CardSide.b)) return state;
    return state.copyWith(pendingDecision: () => const RestoreCardDecision());
  }

  GameState _restoreCard(
    GameState state,
    GameCommand command,
    ActionCardId card,
  ) {
    if (state.pendingDecision is! RestoreCardDecision) {
      throw InvalidDecisionException(command);
    }
    if (state.cardSides[card] != CardSide.b) {
      throw CardNotOnSideBException(card);
    }
    return _drawRepressionCards(
      state.copyWith(
        cardSides: {...state.cardSides, card: CardSide.a},
        pendingDecision: () => null,
      ),
    );
  }

  /// Security: roll a column with a free card and let the players choose
  /// the card (R-050, Q7, Q14, Q17).
  GameState _startSecurity(GameState state) {
    final guards = state.forest.cards.where((card) => card.hasSecurity);
    final hasFreeCard = state.forest.cards.any(_canHoldSecurity);
    if (guards.length >= GameState.maxSecurityGuards || !hasFreeCard) {
      return state;
    }
    var current = state;
    while (true) {
      final (:value, state: rolled) = _rollRepressionDie(current);
      final column = _columnForDie(value);
      if (rolled.forest.columns[column].any(_canHoldSecurity)) {
        return rolled.copyWith(
          pendingDecision: () => SecurityPlacementDecision(column: column),
        );
      }
      current = rolled;
    }
  }

  bool _canHoldSecurity(ForestCard card) =>
      card.state != ForestCardState.removed && !card.hasSecurity;

  GameState _placeSecurity(GameState state, GameCommand command, int position) {
    final decision = state.pendingDecision;
    if (decision is! SecurityPlacementDecision) {
      throw InvalidDecisionException(command);
    }
    final column = decision.column;
    if (!Forest.contains(column: column, position: position) ||
        !_canHoldSecurity(state.forest.columns[column][position])) {
      throw InvalidForestCardException(column: column, position: position);
    }
    return _drawRepressionCards(
      state.copyWith(
        forest: state.forest.replace(
          column: column,
          position: position,
          card: state.forest.columns[column][position].copyWith(
            hasSecurity: true,
            hasActivist: false,
          ),
        ),
        pendingDecision: () => null,
      ),
    );
  }
}
