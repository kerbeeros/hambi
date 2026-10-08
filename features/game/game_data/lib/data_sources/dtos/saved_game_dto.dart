import 'package:game_data/data_sources/dtos/game_state_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'saved_game_dto.g.dart';

/// {@template saved_game_dto}
/// Root of the stored JSON: format version and game state (T-021).
/// {@endtemplate}
@JsonSerializable()
class SavedGameDto {
  /// {@macro saved_game_dto}
  const new({required this.schemaVersion, required this.game});

  /// Creates a [SavedGameDto] from JSON.
  factory fromJson(Map<String, dynamic> json) => _$SavedGameDtoFromJson(json);

  /// Version of the storage format.
  final int schemaVersion;

  /// The saved game state.
  final GameStateDto game;

  /// Converts this DTO to JSON.
  Map<String, dynamic> toJson() => _$SavedGameDtoToJson(this);
}
