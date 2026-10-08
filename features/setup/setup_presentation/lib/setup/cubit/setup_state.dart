part of 'setup_cubit.dart';

/// Progress of the setup screen.
enum SetupStatus {
  /// The players choose the number of players.
  editing,

  /// A saved game would be overwritten (D-11).
  confirmOverwrite,

  /// The game can start.
  started,
}

/// {@template setup_state}
/// State of the [SetupCubit].
/// {@endtemplate}
class SetupState extends Equatable {
  /// {@macro setup_state}
  const new({this.playerCount = 3, this.status = SetupStatus.editing});

  /// Number of players (1–11).
  final int playerCount;

  /// Progress of the setup.
  final SetupStatus status;

  /// The camp the players start with (R-111).
  Camp get startingCamp => Camp.forPlayers(playerCount);

  /// Returns a copy with the given fields replaced.
  SetupState copyWith({int? playerCount, SetupStatus? status}) => SetupState(
    playerCount: playerCount ?? this.playerCount,
    status: status ?? this.status,
  );

  @override
  List<Object> get props => [playerCount, status];
}
