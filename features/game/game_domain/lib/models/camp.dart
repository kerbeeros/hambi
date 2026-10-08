import 'package:equatable/equatable.dart';

/// {@template camp}
/// Supply of available activists and resources (R-023).
/// {@endtemplate}
class Camp extends Equatable {
  /// {@macro camp}
  const new({required this.activists, required this.resources});

  /// Available activists (M).
  final int activists;

  /// Available resources (R).
  final int resources;

  @override
  List<Object> get props => [activists, resources];
}
