// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forest_card_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForestCardDto _$ForestCardDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ForestCardDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['state', 'hasSecurity', 'hasActivist'],
      );
      final val = ForestCardDto(
        state: $checkedConvert('state', (v) => v as String),
        hasSecurity: $checkedConvert('hasSecurity', (v) => v as bool),
        hasActivist: $checkedConvert('hasActivist', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$ForestCardDtoToJson(ForestCardDto instance) =>
    <String, dynamic>{
      'state': instance.state,
      'hasSecurity': instance.hasSecurity,
      'hasActivist': instance.hasActivist,
    };
