part of 'start_cubit.dart';

/// Loading status of the start screen.
enum StartStatus {
  /// Checking for a saved game.
  loading,

  /// Ready to start or continue.
  ready,
}

/// {@template start_state}
/// State of the [StartCubit].
/// {@endtemplate}
class StartState extends Equatable {
  /// {@macro start_state}
  const new({this.status = StartStatus.loading, this.hasSavedGame = false});

  /// Loading status.
  final StartStatus status;

  /// Whether a saved game can be continued.
  final bool hasSavedGame;

  @override
  List<Object> get props => [status, hasSavedGame];
}
