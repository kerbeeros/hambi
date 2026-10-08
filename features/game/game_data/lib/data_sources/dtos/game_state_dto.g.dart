// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameStateDto _$GameStateDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GameStateDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'playerCount',
          'forest',
          'cardSides',
          'camp',
          'support',
          'round',
          'phase',
          'repressionDeck',
          'repressionInPlay',
          'assignedCards',
          'activatedCards',
          'pendingDecision',
          'outcome',
          'log',
          'repressionCardsToDraw',
          'randomState',
        ],
      );
      final val = GameStateDto(
        playerCount: $checkedConvert('playerCount', (v) => (v as num).toInt()),
        forest: $checkedConvert(
          'forest',
          (v) => (v as List<dynamic>)
              .map(
                (e) => (e as List<dynamic>)
                    .map(
                      (e) => ForestCardDto.fromJson(e as Map<String, dynamic>),
                    )
                    .toList(),
              )
              .toList(),
        ),
        cardSides: $checkedConvert(
          'cardSides',
          (v) => Map<String, String>.from(v as Map),
        ),
        camp: $checkedConvert(
          'camp',
          (v) => CampDto.fromJson(v as Map<String, dynamic>),
        ),
        support: $checkedConvert('support', (v) => (v as num).toInt()),
        round: $checkedConvert('round', (v) => (v as num).toInt()),
        phase: $checkedConvert('phase', (v) => v as String),
        repressionDeck: $checkedConvert(
          'repressionDeck',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        repressionInPlay: $checkedConvert(
          'repressionInPlay',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        assignedCards: $checkedConvert(
          'assignedCards',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        activatedCards: $checkedConvert(
          'activatedCards',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        pendingDecision: $checkedConvert(
          'pendingDecision',
          (v) => v == null
              ? null
              : PendingDecisionDto.fromJson(v as Map<String, dynamic>),
        ),
        outcome: $checkedConvert('outcome', (v) => v as String?),
        log: $checkedConvert(
          'log',
          (v) => (v as List<dynamic>)
              .map((e) => GameLogEntryDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        repressionCardsToDraw: $checkedConvert(
          'repressionCardsToDraw',
          (v) => (v as num).toInt(),
        ),
        randomState: $checkedConvert('randomState', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$GameStateDtoToJson(GameStateDto instance) =>
    <String, dynamic>{
      'playerCount': instance.playerCount,
      'forest': instance.forest
          .map((e) => e.map((e) => e.toJson()).toList())
          .toList(),
      'cardSides': instance.cardSides,
      'camp': instance.camp.toJson(),
      'support': instance.support,
      'round': instance.round,
      'phase': instance.phase,
      'repressionDeck': instance.repressionDeck,
      'repressionInPlay': instance.repressionInPlay,
      'assignedCards': instance.assignedCards,
      'activatedCards': instance.activatedCards,
      'pendingDecision': instance.pendingDecision?.toJson(),
      'outcome': instance.outcome,
      'log': instance.log.map((e) => e.toJson()).toList(),
      'repressionCardsToDraw': instance.repressionCardsToDraw,
      'randomState': instance.randomState,
    };
