import 'package:equatable/equatable.dart';

/// {@template camp}
/// Supply of available activists and resources (R-023).
/// {@endtemplate}
class Camp extends Equatable {
  /// {@macro camp}
  const new({required this.activists, required this.resources});

  /// The camp at the start of a game for [playerCount] players (R-111): one
  /// activist per player, 2 resources for 1 player, 1 for 2 players.
  factory forPlayers(int playerCount) => Camp(
    activists: playerCount,
    resources: switch (playerCount) {
      1 => 2,
      2 => 1,
      _ => 0,
    },
  );

  /// Available activists (M).
  final int activists;

  /// Available resources (R).
  final int resources;

  @override
  List<Object> get props => [activists, resources];
}
