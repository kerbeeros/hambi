import 'package:game_data/data_sources/dtos/camp_dto.dart';
import 'package:game_data/data_sources/dtos/forest_card_dto.dart';
import 'package:game_data/data_sources/dtos/game_event_dto.dart';
import 'package:game_data/data_sources/dtos/pending_decision_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_state_dto.g.dart';

/// {@template game_state_dto}
/// Stored game state. Enum values are stored by name.
/// {@endtemplate}
@JsonSerializable()
class GameStateDto {
  /// {@macro game_state_dto}
  const new({
    required this.playerCount,
    required this.forest,
    required this.cardSides,
    required this.camp,
    required this.support,
    required this.round,
    required this.phase,
    required this.repressionDeck,
    required this.repressionInPlay,
    required this.assignedCards,
    required this.activatedCards,
    required this.pendingDecision,
    required this.outcome,
    required this.log,
    required this.repressionCardsToDraw,
    required this.randomState,
  });

  /// Creates a [GameStateDto] from JSON.
  factory fromJson(Map<String, dynamic> json) => _$GameStateDtoFromJson(json);

  /// Number of players.
  final int playerCount;

  /// Forest columns, each from left to right.
  final List<List<ForestCardDto>> forest;

  /// Face-up side per action card name.
  final Map<String, String> cardSides;

  /// Activists and resources in the camp.
  final CampDto camp;

  /// Public support.
  final int support;

  /// Current round.
  final int round;

  /// Current phase name.
  final String phase;

  /// Repression draw pile, top card first.
  final List<String> repressionDeck;

  /// Repression cards in play.
  final List<String> repressionInPlay;

  /// Action cards assigned this round.
  final List<String> assignedCards;

  /// Action cards activated this round.
  final List<String> activatedCards;

  /// Decision the players have to make, if any.
  final PendingDecisionDto? pendingDecision;

  /// Outcome name once the game is finished.
  final String? outcome;

  /// Round log.
  final List<GameEventDto> log;

  /// Repression cards still to be drawn.
  final int repressionCardsToDraw;

  /// State of the random generator.
  final int randomState;

  /// Converts this DTO to JSON.
  Map<String, dynamic> toJson() => _$GameStateDtoToJson(this);
}
