import 'package:equatable/equatable.dart';

/// {@template action_card_cost}
/// Conditions of an action card side (R-042): activists (○) and resources (□)
/// to place and support to lower (−☺).
/// {@endtemplate}
class ActionCardCost extends Equatable {
  /// {@macro action_card_cost}
  const new({this.activists = 0, this.resources = 0, this.support = 0});

  /// Activists to place on the card.
  final int activists;

  /// Resources to place on the card.
  final int resources;

  /// Support to lower.
  final int support;

  @override
  List<Object> get props => [activists, resources, support];
}
