import 'package:game_domain/game_domain.dart';

/// Builds a [GameState] with neutral defaults for presentation tests.
GameState buildGameState({
  int playerCount = 3,
  Forest? forest,
  Map<ActionCardId, CardSide> cardSides = const {},
  Camp camp = const Camp(activists: 3, resources: 0),
  int support = 0,
  int round = 1,
  GamePhase phase = GamePhase.preparation,
  List<RepressionCard> repressionDeck = const [],
  List<RepressionCard> repressionInPlay = const [],
  Set<ActionCardId> assignedCards = const {},
  Set<ActionCardId> activatedCards = const {},
  PendingDecision? pendingDecision,
  GameOutcome? outcome,
  List<GameLogEntry> log = const [],
}) => GameState(
  playerCount: playerCount,
  forest: forest ?? Forest.initial(),
  cardSides: {
    for (final card in ActionCardId.values) card: CardSide.a,
    ...cardSides,
  },
  camp: camp,
  support: support,
  round: round,
  phase: phase,
  repressionDeck: repressionDeck,
  repressionInPlay: repressionInPlay,
  assignedCards: assignedCards,
  activatedCards: activatedCards,
  pendingDecision: pendingDecision,
  outcome: outcome,
  log: log,
  randomState: 1,
);
