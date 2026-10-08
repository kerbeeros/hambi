import 'package:game_domain/game_domain.dart';

/// Returns an untouched forest with an activist on the card at [column]
/// and [position].
Forest forestWithActivist({int column = 0, int position = 0}) =>
    forestWith({(column, position): const ForestCard(hasActivist: true)});

/// Returns an untouched forest in which the given cards are replaced.
///
/// Keys are `(column, position)`, both zero-based.
Forest forestWith(Map<(int, int), ForestCard> cards) => Forest(
  columns: [
    for (var c = 0; c < Forest.columnCount; c++)
      [
        for (var p = 0; p < Forest.cardsPerColumn; p++)
          cards[(c, p)] ?? const ForestCard(),
      ],
  ],
);

/// Returns a forest in which every card is replaced by [card].
Forest forestFilledWith(ForestCard card) => Forest(
  columns: List.generate(
    Forest.columnCount,
    (_) => List.filled(Forest.cardsPerColumn, card),
  ),
);

/// Builds a [GameState] with neutral defaults for focused rule tests.
///
/// The repression deck is empty by default, so a repression phase draws
/// nothing unless a test provides cards.
GameState buildGameState({
  int playerCount = 3,
  Forest? forest,
  Map<ActionCardId, CardSide> cardSides = const {},
  Camp camp = const Camp(activists: 3, resources: 0),
  int support = 0,
  int round = 1,
  GamePhase phase = GamePhase.setup,
  List<RepressionCard> repressionDeck = const [],
  List<RepressionCard> repressionInPlay = const [],
  Set<ActionCardId> assignedCards = const {},
  Set<ActionCardId> activatedCards = const {},
  PendingDecision? pendingDecision,
  GameOutcome? outcome,
  List<GameLogEntry> log = const [],
  int repressionCardsToDraw = 0,
  int randomState = 0,
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
  repressionCardsToDraw: repressionCardsToDraw,
  randomState: randomState,
);
