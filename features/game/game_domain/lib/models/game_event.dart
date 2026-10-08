import 'package:equatable/equatable.dart';
import 'package:game_domain/models/repression_card.dart';

/// Entry of the round log (F-07).
sealed class GameEvent extends Equatable {
  const new();
}

/// {@template dice_rolled}
/// The excavator dice were rolled (R-120).
/// {@endtemplate}
final class DiceRolled extends GameEvent {
  /// {@macro dice_rolled}
  const new(this.dice);

  /// The rolled values (1–6).
  final List<int> dice;

  @override
  List<Object> get props => [dice];
}

/// {@template die_rerolled}
/// An excavator die was rerolled thanks to sabotage (R-121).
/// {@endtemplate}
final class DieRerolled extends GameEvent {
  /// {@macro die_rerolled}
  const new({required this.index, required this.value});

  /// Index of the rerolled die.
  final int index;

  /// The new value (1–6).
  final int value;

  @override
  List<Object> get props => [index, value];
}

/// {@template repression_card_drawn}
/// A repression card was drawn (R-093).
/// {@endtemplate}
final class RepressionCardDrawn extends GameEvent {
  /// {@macro repression_card_drawn}
  const new(this.card);

  /// The drawn card.
  final RepressionCard card;

  @override
  List<Object> get props => [card];
}

/// {@template repression_die_rolled}
/// A die was rolled for a repression card (R-050, R-052).
/// {@endtemplate}
final class RepressionDieRolled extends GameEvent {
  /// {@macro repression_die_rolled}
  const new(this.value);

  /// The rolled value (1–6).
  final int value;

  @override
  List<Object> get props => [value];
}
