import 'package:json_annotation/json_annotation.dart';

part 'camp_dto.g.dart';

/// {@template camp_dto}
/// Stored camp.
/// {@endtemplate}
@JsonSerializable()
class CampDto {
  /// {@macro camp_dto}
  const new({required this.activists, required this.resources});

  /// Creates a [CampDto] from JSON.
  factory fromJson(Map<String, dynamic> json) => _$CampDtoFromJson(json);

  /// Activists in the camp.
  final int activists;

  /// Resources in the camp.
  final int resources;

  /// Converts this DTO to JSON.
  Map<String, dynamic> toJson() => _$CampDtoToJson(this);
}
