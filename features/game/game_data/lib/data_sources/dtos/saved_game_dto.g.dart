// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_game_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedGameDto _$SavedGameDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SavedGameDto', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['schemaVersion', 'game']);
      final val = SavedGameDto(
        schemaVersion: $checkedConvert(
          'schemaVersion',
          (v) => (v as num).toInt(),
        ),
        game: $checkedConvert(
          'game',
          (v) => GameStateDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SavedGameDtoToJson(SavedGameDto instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'game': instance.game.toJson(),
    };
