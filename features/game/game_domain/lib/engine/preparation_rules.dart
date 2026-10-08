part of 'game_engine.dart';

extension on GameEngine {
  GameState _assign(GameState state, GameCommand command, ActionCardId card) {
    switch (state.assignmentStatus(card)) {
      case AssignmentStatus.notInPreparation:
        throw InvalidPhaseException(command, state.phase);
      case AssignmentStatus.blocked:
        throw CardBlockedException(card);
      case AssignmentStatus.assigned:
        throw CardAlreadyAssignedException(card);
      case AssignmentStatus.notEnoughActivists ||
          AssignmentStatus.notEnoughResources ||
          AssignmentStatus.notEnoughSupport:
        throw ConditionNotMetException(card);
      case AssignmentStatus.available:
        break;
    }
    final cost = card.cost(state.cardSides[card]!);
    final camp = state.camp;
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
