import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game/bloc/bloc.dart';
import 'package:game_presentation/game/cubit/cubit.dart';

/// How the game screen is opened.
sealed class GameLaunch extends Equatable {
  const new();
}

/// {@template new_game_launch}
/// Opens a new game for [playerCount] players (F-01).
/// {@endtemplate}
final class NewGameLaunch extends GameLaunch {
  /// {@macro new_game_launch}
  const new({required this.playerCount});

  /// Number of players (1–11).
  final int playerCount;

  @override
  List<Object> get props => [playerCount];
}

/// {@template resume_game_launch}
/// Continues the saved game (F-04).
/// {@endtemplate}
final class ResumeGameLaunch extends GameLaunch {
  /// {@macro resume_game_launch}
  const new();

  @override
  List<Object> get props => [];
}

/// {@template game_module}
/// Provides the [GameBloc] and [BoardTabCubit] of the game screen and
/// starts or resumes the game according to [launch].
///
/// Needs an [IGameRepository] above it.
/// {@endtemplate}
class GameModule extends StatelessWidget {
  /// {@macro game_module}
  const new({required this.launch, required this.child, this.seed, super.key});

  /// How the game screen is opened.
  final GameLaunch launch;

  /// The game screen, usually a `GameView`.
  final Widget child;

  /// Random seed of new games; a random one when `null` (T-005).
  final int Function()? seed;

  static const int _maxSeed = 1 << 32;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GameBloc(
                engine: const GameEngine(XorShiftRandomGenerator()),
                repository: context.read<IGameRepository>(),
                seed: seed ?? () => Random().nextInt(_maxSeed),
              )..add(switch (launch) {
                NewGameLaunch(:final playerCount) => GameStarted(
                  playerCount: playerCount,
                ),
                ResumeGameLaunch() => const GameResumed(),
              }),
        ),
        BlocProvider(create: (_) => BoardTabCubit()),
      ],
      child: child,
    );
  }
}
