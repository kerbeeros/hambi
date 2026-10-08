import 'package:equatable/equatable.dart';

/// {@template action_card_effect}
/// Effects of an action card side that change the board (R-084–R-087).
///
/// Sabotage and legal team have no board effect; they take effect later in
/// the round while activated (R-121, R-092).
/// {@endtemplate}
class ActionCardEffect extends Equatable {
  /// {@macro action_card_effect}
  const new({
    this.activists = 0,
    this.resources = 0,
    this.support = 0,
    this.placesActivistOnForest = false,
  });

  /// New activists for the camp (+M).
  final int activists;

  /// New resources for the camp (+R).
  final int resources;

  /// Support gained (+☺).
  final int support;

  /// Whether the placed activist moves onto the forest (M→Wald).
  final bool placesActivistOnForest;

  @override
  List<Object> get props => [
    activists,
    resources,
    support,
    placesActivistOnForest,
  ];
}
