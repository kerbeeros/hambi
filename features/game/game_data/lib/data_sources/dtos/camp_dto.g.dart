// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camp_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampDto _$CampDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CampDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['activists', 'resources']);
      final val = CampDto(
        activists: $checkedConvert('activists', (v) => (v as num).toInt()),
        resources: $checkedConvert('resources', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$CampDtoToJson(CampDto instance) => <String, dynamic>{
  'activists': instance.activists,
  'resources': instance.resources,
};
