import 'package:game_domain/game_domain.dart';

import 'game_states.dart';

/// A forest after a few rounds: cleared and removed cards, activists and a
/// security guard.
final Forest sampleForest = Forest.initial()
    .replace(
      column: 0,
      position: 0,
      card: const ForestCard(state: ForestCardState.removed),
    )
    .replace(
      column: 0,
      position: 1,
      card: const ForestCard(state: ForestCardState.clearCut),
    )
    .replace(
      column: 1,
      position: 0,
      card: const ForestCard(
        state: ForestCardState.clearCut,
        hasActivist: true,
      ),
    )
    .replace(column: 2, position: 2, card: const ForestCard(hasSecurity: true));

/// A preparation phase in round 5 with assigned, blocked and unavailable
/// cards.
final GameState samplePreparation = buildGameState(
  round: 5,
  forest: sampleForest,
  camp: const Camp(activists: 4, resources: 1),
  support: 3,
  cardSides: {ActionCardId.internet: CardSide.b},
  assignedCards: {ActionCardId.blockade},
  repressionInPlay: [RepressionCard.assemblyBan, RepressionCard.raid],
  log: const [
    DiceRolled([1, 4]),
    RepressionCardDrawn(RepressionCard.raid),
  ],
);
