// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameEventDto _$GameEventDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GameEventDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['type', 'dice', 'index', 'value', 'card'],
      );
      final val = GameEventDto(
        type: $checkedConvert('type', (v) => v as String),
        dice: $checkedConvert(
          'dice',
          (v) => (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
        ),
        index: $checkedConvert('index', (v) => (v as num?)?.toInt()),
        value: $checkedConvert('value', (v) => (v as num?)?.toInt()),
        card: $checkedConvert('card', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$GameEventDtoToJson(GameEventDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'dice': ?instance.dice,
      'index': ?instance.index,
      'value': ?instance.value,
      'card': ?instance.card,
    };
