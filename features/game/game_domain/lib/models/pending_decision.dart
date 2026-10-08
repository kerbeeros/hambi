import 'package:equatable/equatable.dart';

/// A decision the players have to make before the game can proceed (T-002).
sealed class PendingDecision extends Equatable {
  const new();
}

/// {@template place_activists_decision}
/// Players choose forest cards for activists of forest actions (R-085).
/// {@endtemplate}
final class PlaceActivistsDecision extends PendingDecision {
  /// {@macro place_activists_decision}
  const new({required this.activists});

  /// Activists still to be placed.
  final int activists;

  @override
  List<Object> get props => [activists];
}

/// {@template reroll_decision}
/// Players may reroll one excavator die thanks to sabotage (R-121).
/// {@endtemplate}
final class RerollDecision extends PendingDecision {
  /// {@macro reroll_decision}
  const new(this.dice);

  /// The rolled values (1–6).
  final List<int> dice;

  @override
  List<Object> get props => [dice];
}

/// {@template return_activists_decision}
/// Players choose which activists on the forest return to the camp (R-124).
/// {@endtemplate}
final class ReturnActivistsDecision extends PendingDecision {
  /// {@macro return_activists_decision}
  const new();

  @override
  List<Object> get props => [];
}

/// {@template negative_press_decision}
/// Players choose between losing support or an activist (R-053).
/// {@endtemplate}
final class NegativePressDecision extends PendingDecision {
  /// {@macro negative_press_decision}
  const new();

  @override
  List<Object> get props => [];
}

/// {@template restore_card_decision}
/// Players choose a card on side B to turn back to side A (R-055).
/// {@endtemplate}
final class RestoreCardDecision extends PendingDecision {
  /// {@macro restore_card_decision}
  const new();

  @override
  List<Object> get props => [];
}

/// {@template security_placement_decision}
/// Players choose the card in [column] that gets a security guard
/// (R-050, Q14).
/// {@endtemplate}
final class SecurityPlacementDecision extends PendingDecision {
  /// {@macro security_placement_decision}
  const new({required this.column});

  /// The rolled forest column (0 = WS1).
  final int column;

  @override
  List<Object> get props => [column];
}
