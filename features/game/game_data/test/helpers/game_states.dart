import 'package:game_domain/game_domain.dart';

/// Builds a [GameState] with neutral defaults.
GameState buildGameState({
  Forest? forest,
  Map<ActionCardId, CardSide> cardSides = const {},
  GamePhase phase = GamePhase.preparation,
  List<RepressionCard> repressionInPlay = const [],
  Set<ActionCardId> assignedCards = const {},
  Set<ActionCardId> activatedCards = const {},
  PendingDecision? pendingDecision,
  GameOutcome? outcome,
  List<GameEvent> log = const [],
  int repressionCardsToDraw = 0,
}) => GameState(
  playerCount: 4,
  forest: forest ?? Forest.initial(),
  cardSides: {
    for (final card in ActionCardId.values) card: CardSide.a,
    ...cardSides,
  },
  camp: const Camp(activists: 3, resources: 2),
  support: 5,
  round: 7,
  phase: phase,
  repressionDeck: const [RepressionCard.raid, RepressionCard.security],
  repressionInPlay: repressionInPlay,
  assignedCards: assignedCards,
  activatedCards: activatedCards,
  pendingDecision: pendingDecision,
  outcome: outcome,
  log: log,
  repressionCardsToDraw: repressionCardsToDraw,
  randomState: 123456789,
);

/// States covering every phase, decision, event and outcome.
final Map<String, GameState> representativeStates = {
  'a fresh game': GameState(
    playerCount: 1,
    forest: Forest.initial(),
    cardSides: {for (final card in ActionCardId.values) card: CardSide.a},
    camp: const Camp(activists: 1, resources: 2),
    support: 0,
    round: 0,
    phase: GamePhase.setup,
    repressionDeck: RepressionCard.fullDeck,
    randomState: 42,
  ),
  'a game in progress': buildGameState(
    forest: Forest.initial()
        .replace(
          column: 0,
          position: 0,
          card: const ForestCard(state: ForestCardState.removed),
        )
        .replace(
          column: 1,
          position: 2,
          card: const ForestCard(
            state: ForestCardState.clearCut,
            hasActivist: true,
          ),
        )
        .replace(
          column: 2,
          position: 3,
          card: const ForestCard(hasSecurity: true),
        ),
    cardSides: {
      ActionCardId.internet: CardSide.b,
      ActionCardId.allies: CardSide.b,
    },
    repressionInPlay: [RepressionCard.assemblyBan, RepressionCard.raid],
    assignedCards: {ActionCardId.demo, ActionCardId.sabotage},
    activatedCards: {ActionCardId.legalTeam},
    log: const [
      DiceRolled([2, 5]),
      DieRerolled(index: 1, value: 6),
      RepressionCardDrawn(RepressionCard.nightShift),
      RepressionDieRolled(3),
    ],
    repressionCardsToDraw: 2,
  ),
  'a pending activist placement': buildGameState(
    phase: GamePhase.action,
    pendingDecision: const PlaceActivistsDecision(activists: 2),
  ),
  'a pending reroll': buildGameState(
    phase: GamePhase.excavation,
    pendingDecision: const RerollDecision([1, 4]),
  ),
  'a pending return of activists': buildGameState(
    phase: GamePhase.excavation,
    pendingDecision: const ReturnActivistsDecision(),
  ),
  'a pending negative press': buildGameState(
    phase: GamePhase.repression,
    pendingDecision: const NegativePressDecision(),
  ),
  'a pending legal aid': buildGameState(
    phase: GamePhase.repression,
    pendingDecision: const RestoreCardDecision(),
  ),
  'a pending security placement': buildGameState(
    phase: GamePhase.repression,
    pendingDecision: const SecurityPlacementDecision(column: 2),
  ),
  'a won game': buildGameState(
    phase: GamePhase.finished,
    outcome: GameOutcome.victory,
  ),
  'a lost game': buildGameState(
    phase: GamePhase.finished,
    outcome: GameOutcome.defeat,
  ),
};
