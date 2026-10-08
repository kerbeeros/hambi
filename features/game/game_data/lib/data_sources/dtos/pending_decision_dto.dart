import 'package:json_annotation/json_annotation.dart';

part 'pending_decision_dto.g.dart';

/// {@template pending_decision_dto}
/// Stored pending decision; [type] selects the variant and which of the
/// optional values are set.
/// {@endtemplate}
@JsonSerializable(includeIfNull: false)
class PendingDecisionDto {
  /// {@macro pending_decision_dto}
  const new({required this.type, this.activists, this.dice, this.column});

  /// Creates a [PendingDecisionDto] from JSON.
  factory fromJson(Map<String, dynamic> json) =>
      _$PendingDecisionDtoFromJson(json);

  /// Variant name.
  final String type;

  /// Activists still to be placed.
  final int? activists;

  /// Rolled dice that may be rerolled.
  final List<int>? dice;

  /// Rolled forest column for a security guard.
  final int? column;

  /// Converts this DTO to JSON.
  Map<String, dynamic> toJson() => _$PendingDecisionDtoToJson(this);
}
