part of 'game_engine.dart';

extension on GameEngine {
  /// Executes the effects of all assigned cards (R-084–R-087).
  GameState _endPreparation(GameState state, GameCommand command) {
    _requirePhase(state, command, GamePhase.preparation);
    var returningActivists = 0;
    var activistsToPlace = 0;
    var gainedActivists = 0;
    var gainedResources = 0;
    var gainedSupport = 0;
    for (final card in state.assignedCards) {
      final side = state.cardSides[card]!;
      final cost = card.cost(side);
      final effect = card.effect(side);
      if (effect.placesActivistOnForest) {
        activistsToPlace++;
        returningActivists += cost.activists - 1;
      } else {
        returningActivists += cost.activists;
      }
      gainedActivists += effect.activists;
      gainedResources += effect.resources;
      gainedSupport += effect.support;
    }
    final newActivists = math.min(
      gainedActivists,
      GameState.maxActivists - state.activistsInPlay,
    );
    final camp = state.camp;
    return _resolvePlacements(
      state.copyWith(
        camp: Camp(
          activists: camp.activists + returningActivists + newActivists,
          resources: math.min(
            camp.resources + gainedResources,
            GameState.maxResources,
          ),
        ),
        support: math.min(state.support + gainedSupport, GameState.maxSupport),
        assignedCards: {},
        activatedCards: state.assignedCards,
        phase: GamePhase.action,
        log: [],
        pendingDecision: () => activistsToPlace > 0
            ? PlaceActivistsDecision(activists: activistsToPlace)
            : null,
      ),
    );
  }

  GameState _placeActivist(
    GameState state,
    GameCommand command, {
    required int column,
    required int position,
  }) {
    final decision = state.pendingDecision;
    if (decision is! PlaceActivistsDecision) {
      throw InvalidDecisionException(command);
    }
    if (!Forest.contains(column: column, position: position) ||
        !state.forest.columns[column][position].canHoldActivist) {
      throw InvalidForestCardException(column: column, position: position);
    }
    final remaining = decision.activists - 1;
    return _resolvePlacements(
      state.copyWith(
        forest: state.forest.replace(
          column: column,
          position: position,
          card: state.forest.columns[column][position].copyWith(
            hasActivist: true,
          ),
        ),
        pendingDecision: () =>
            remaining > 0 ? PlaceActivistsDecision(activists: remaining) : null,
      ),
    );
  }

  /// Returns activists to the camp when no forest card is free (Q19) and
  /// proceeds to the excavation phase once all activists are placed.
  GameState _resolvePlacements(GameState state) {
    final decision = state.pendingDecision;
    if (decision is PlaceActivistsDecision) {
      if (state.forest.cards.any((card) => card.canHoldActivist)) return state;
      return _resolvePlacements(
        state.copyWith(
          camp: Camp(
            activists: state.camp.activists + decision.activists,
            resources: state.camp.resources,
          ),
          pendingDecision: () => null,
        ),
      );
    }
    return _startExcavation(state);
  }
}
