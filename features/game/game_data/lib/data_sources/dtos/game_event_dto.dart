import 'package:json_annotation/json_annotation.dart';

part 'game_event_dto.g.dart';

/// {@template game_event_dto}
/// Stored round log entry; [type] selects the variant and which of the
/// optional values are set.
/// {@endtemplate}
@JsonSerializable(includeIfNull: false)
class GameEventDto {
  /// {@macro game_event_dto}
  const new({required this.type, this.dice, this.index, this.value, this.card});

  /// Creates a [GameEventDto] from JSON.
  factory fromJson(Map<String, dynamic> json) => _$GameEventDtoFromJson(json);

  /// Variant name.
  final String type;

  /// Rolled excavator dice.
  final List<int>? dice;

  /// Index of a rerolled die.
  final int? index;

  /// Value of a single rolled die.
  final int? value;

  /// Name of a drawn repression card.
  final String? card;

  /// Converts this DTO to JSON.
  Map<String, dynamic> toJson() => _$GameEventDtoToJson(this);
}
