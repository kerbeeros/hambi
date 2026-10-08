// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_decision_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingDecisionDto _$PendingDecisionDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PendingDecisionDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['type', 'activists', 'dice', 'column'],
      );
      final val = PendingDecisionDto(
        type: $checkedConvert('type', (v) => v as String),
        activists: $checkedConvert('activists', (v) => (v as num?)?.toInt()),
        dice: $checkedConvert(
          'dice',
          (v) => (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
        ),
        column: $checkedConvert('column', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$PendingDecisionDtoToJson(PendingDecisionDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'activists': ?instance.activists,
      'dice': ?instance.dice,
      'column': ?instance.column,
    };
