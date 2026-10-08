import 'package:json_annotation/json_annotation.dart';

part 'forest_card_dto.g.dart';

/// {@template forest_card_dto}
/// Stored forest card.
/// {@endtemplate}
@JsonSerializable()
class ForestCardDto {
  /// {@macro forest_card_dto}
  const new({
    required this.state,
    required this.hasSecurity,
    required this.hasActivist,
  });

  /// Creates a [ForestCardDto] from JSON.
  factory fromJson(Map<String, dynamic> json) => _$ForestCardDtoFromJson(json);

  /// Card state name.
  final String state;

  /// Whether a security guard stands on the card.
  final bool hasSecurity;

  /// Whether an activist stands on the card.
  final bool hasActivist;

  /// Converts this DTO to JSON.
  Map<String, dynamic> toJson() => _$ForestCardDtoToJson(this);
}
