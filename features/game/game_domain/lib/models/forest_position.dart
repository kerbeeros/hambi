import 'package:equatable/equatable.dart';

/// {@template forest_position}
/// Position of a card in the forest, both values zero-based.
/// {@endtemplate}
class ForestPosition extends Equatable {
  /// {@macro forest_position}
  const new({required this.column, required this.position});

  /// Forest column (0 = WS1).
  final int column;

  /// Position within the column (0 = leftmost).
  final int position;

  @override
  List<Object> get props => [column, position];
}
