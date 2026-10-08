part of 'game_engine.dart';

extension on GameEngine {
  GameState _assign(GameState state, GameCommand command, ActionCardId card) {
    _requirePhase(state, command, GamePhase.preparation);
    if (state.isBlocked(card)) throw CardBlockedException(card);
    if (state.assignedCards.contains(card)) {
      throw CardAlreadyAssignedException(card);
    }
    final cost = card.cost(state.cardSides[card]!);
    final camp = state.camp;
    if (camp.activists < cost.activists ||
        camp.resources < cost.resources ||
        state.support < cost.support) {
      throw ConditionNotMetException(card);
    }
    return state.copyWith(
      camp: Camp(
        activists: camp.activists - cost.activists,
        resources: camp.resources - cost.resources,
      ),
      support: state.support - cost.support,
      assignedCards: {...state.assignedCards, card},
    );
  }

  GameState _undo(GameState state, GameCommand command, ActionCardId card) {
    _requirePhase(state, command, GamePhase.preparation);
    if (!state.assignedCards.contains(card)) {
      throw CardNotAssignedException(card);
    }
    final cost = card.cost(state.cardSides[card]!);
    final camp = state.camp;
    return state.copyWith(
      camp: Camp(
        activists: camp.activists + cost.activists,
        resources: camp.resources + cost.resources,
      ),
      support: state.support + cost.support,
      assignedCards: {...state.assignedCards}..remove(card),
    );
  }
}
