import 'package:equatable/equatable.dart';
import 'package:game_domain/models/action_card_id.dart';
import 'package:game_domain/models/assignment_status.dart';
import 'package:game_domain/models/camp.dart';
import 'package:game_domain/models/forest.dart';
import 'package:game_domain/models/game_log_entry.dart';
import 'package:game_domain/models/game_outcome.dart';
import 'package:game_domain/models/game_phase.dart';
import 'package:game_domain/models/pending_decision.dart';
import 'package:game_domain/models/repression_card.dart';
import 'package:game_domain/models/repression_field.dart';

/// {@template game_state}
/// Immutable state of a game (T-002).
/// {@endtemplate}
class GameState extends Equatable {
  /// {@macro game_state}
  new({
    required this.playerCount,
    required this.forest,
    required Map<ActionCardId, CardSide> cardSides,
    required this.camp,
    required this.support,
    required this.round,
    required this.phase,
    required List<RepressionCard> repressionDeck,
    required this.randomState,
    List<RepressionCard> repressionInPlay = const [],
    Set<ActionCardId> assignedCards = const {},
    Set<ActionCardId> activatedCards = const {},
    this.pendingDecision,
    this.outcome,
    List<GameLogEntry> log = const [],
    this.repressionCardsToDraw = 0,
  }) : cardSides = Map.unmodifiable(cardSides),
       repressionDeck = List.unmodifiable(repressionDeck),
       repressionInPlay = List.unmodifiable(repressionInPlay),
       assignedCards = Set.unmodifiable(assignedCards),
       activatedCards = Set.unmodifiable(activatedCards),
       log = List.unmodifiable(log);

  /// Maximum number of activists in play (R-002).
  static const int maxActivists = 11;

  /// Maximum number of resources (R-004).
  static const int maxResources = 8;

  /// Maximum public support (R-008).
  static const int maxSupport = 11;

  /// Number of security guards (R-003).
  static const int maxSecurityGuards = 3;

  /// The last round of the game (R-101).
  static const int lastRound = 12;

  /// Number of players (1–11).
  final int playerCount;

  /// The forest.
  final Forest forest;

  /// Face-up side of every action card.
  final Map<ActionCardId, CardSide> cardSides;

  /// Available activists and resources.
  final Camp camp;

  /// Public support (U), 0–11.
  final int support;

  /// Current round, `0` before the first round.
  final int round;

  /// Current phase.
  final GamePhase phase;

  /// Repression draw pile, top card first.
  final List<RepressionCard> repressionDeck;

  /// Repression cards drawn in the last repression phase (R-091).
  final List<RepressionCard> repressionInPlay;

  /// Action cards assigned in the current round (R-081).
  final Set<ActionCardId> assignedCards;

  /// Action cards activated in the current round (R-084).
  final Set<ActionCardId> activatedCards;

  /// Decision the players have to make before the game proceeds.
  final PendingDecision? pendingDecision;

  /// Result once the game is finished.
  final GameOutcome? outcome;

  /// Log of the current round (F-07).
  final List<GameLogEntry> log;

  /// Repression cards still to be drawn in the current phase (R-093).
  final int repressionCardsToDraw;

  /// State of the random generator (T-005).
  final int randomState;

  /// Position of the clock (R-006): 12 before the first round, then the round.
  int get clock => round == 0 ? lastRound : round;

  /// Number of activists in play, shown on the activist track (R-007, Q10).
  int get activistsInPlay =>
      camp.activists +
      _assignedActivists +
      _activistsOnForest +
      _activistsToPlace;

  int get _assignedActivists => assignedCards.fold(
    0,
    (sum, card) => sum + card.cost(cardSides[card]!).activists,
  );

  int get _activistsOnForest =>
      forest.cards.where((card) => card.hasActivist).length;

  int get _activistsToPlace => switch (pendingDecision) {
    PlaceActivistsDecision(:final activists) => activists,
    _ => 0,
  };

  /// Number of removed forest cards (R-101, R-102).
  int get removedForestCards => forest.cards
      .where((card) => card.state == ForestCardState.removed)
      .length;

  /// Whether and why [card] can be assigned now (UX-02).
  AssignmentStatus assignmentStatus(ActionCardId card) {
    if (phase != GamePhase.preparation) {
      return AssignmentStatus.notInPreparation;
    }
    if (isBlocked(card)) return AssignmentStatus.blocked;
    if (assignedCards.contains(card)) return AssignmentStatus.assigned;
    final cost = card.cost(cardSides[card]!);
    if (camp.activists < cost.activists) {
      return AssignmentStatus.notEnoughActivists;
    }
    if (camp.resources < cost.resources) {
      return AssignmentStatus.notEnoughResources;
    }
    if (support < cost.support) return AssignmentStatus.notEnoughSupport;
    return AssignmentStatus.available;
  }

  /// Repression cards drawn in the next repression phase at the current
  /// track values (R-092); an assigned or activated legal team counts.
  int get upcomingRepressionDraws {
    final legalTeam =
        assignedCards.contains(ActionCardId.legalTeam) ||
        activatedCards.contains(ActionCardId.legalTeam);
    final draws = activatedRepressionFields.length - (legalTeam ? 1 : 0);
    return draws < 0 ? 0 : draws;
  }

  /// Log entries added on the way from [previous] to this state (F-07).
  ///
  /// The log restarts when the action phase begins, so after leaving the
  /// preparation phase the whole log is new.
  List<GameLogEntry> logEntriesSince(GameState previous) {
    final startedActionPhase =
        previous.phase == GamePhase.preparation &&
        phase != GamePhase.preparation;
    return startedActionPhase ? log : log.sublist(previous.log.length);
  }

  /// Whether [card] is blocked by a repression card in play (R-083).
  bool isBlocked(ActionCardId card) =>
      repressionInPlay.any((repression) => repression.blocks == card);

  /// Repression fields activated by the current track values (R-090).
  Set<RepressionField> get activatedRepressionFields => {
    for (final field in RepressionField.values)
      if (field.isActivated(activists: activistsInPlay, support: support))
        field,
  };

  /// Returns a copy with the given fields replaced.
  ///
  /// [pendingDecision] is a function so that it can be reset to `null`.
  GameState copyWith({
    Forest? forest,
    Map<ActionCardId, CardSide>? cardSides,
    Camp? camp,
    int? support,
    int? round,
    GamePhase? phase,
    List<RepressionCard>? repressionDeck,
    List<RepressionCard>? repressionInPlay,
    Set<ActionCardId>? assignedCards,
    Set<ActionCardId>? activatedCards,
    PendingDecision? Function()? pendingDecision,
    GameOutcome? outcome,
    List<GameLogEntry>? log,
    int? repressionCardsToDraw,
    int? randomState,
  }) => GameState(
    playerCount: playerCount,
    forest: forest ?? this.forest,
    cardSides: cardSides ?? this.cardSides,
    camp: camp ?? this.camp,
    support: support ?? this.support,
    round: round ?? this.round,
    phase: phase ?? this.phase,
    repressionDeck: repressionDeck ?? this.repressionDeck,
    repressionInPlay: repressionInPlay ?? this.repressionInPlay,
    assignedCards: assignedCards ?? this.assignedCards,
    activatedCards: activatedCards ?? this.activatedCards,
    pendingDecision: pendingDecision != null
        ? pendingDecision()
        : this.pendingDecision,
    outcome: outcome ?? this.outcome,
    log: log ?? this.log,
    repressionCardsToDraw: repressionCardsToDraw ?? this.repressionCardsToDraw,
    randomState: randomState ?? this.randomState,
  );

  @override
  List<Object> get props => [
    playerCount,
    forest,
    cardSides,
    camp,
    support,
    round,
    phase,
    repressionDeck,
    repressionInPlay,
    assignedCards,
    activatedCards,
    ?pendingDecision,
    ?outcome,
    log,
    repressionCardsToDraw,
    randomState,
  ];
}
