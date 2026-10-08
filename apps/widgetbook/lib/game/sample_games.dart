import 'package:game_domain/game_domain.dart';

/// Example game states for the screen use cases.
abstract final class SampleGames {
  /// A forest after a few rounds.
  static final Forest forest = Forest.initial()
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
      .replace(
        column: 2,
        position: 2,
        card: const ForestCard(hasSecurity: true),
      );

  /// A game in [phase] of round [round].
  static GameState game({
    GamePhase phase = GamePhase.preparation,
    int round = 5,
    PendingDecision? pendingDecision,
    GameOutcome? outcome,
    int support = 3,
    Forest? forest,
  }) => GameState(
    playerCount: 4,
    forest: forest ?? SampleGames.forest,
    cardSides: {
      for (final card in ActionCardId.values) card: CardSide.a,
      ActionCardId.internet: CardSide.b,
      ActionCardId.allies: CardSide.b,
    },
    camp: const Camp(activists: 4, resources: 1),
    support: support,
    round: round,
    phase: phase,
    repressionDeck: RepressionCard.fullDeck,
    repressionInPlay: const [RepressionCard.assemblyBan, RepressionCard.raid],
    assignedCards: phase == GamePhase.preparation
        ? const {ActionCardId.blockade}
        : const {},
    pendingDecision: pendingDecision,
    outcome: outcome,
    log: const [
      DiceRolled([1, 4]),
      RepressionCardDrawn(RepressionCard.raid),
    ],
    randomState: 1,
  );
}
