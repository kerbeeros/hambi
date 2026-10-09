part of 'app_router.dart';

/// {@template new_game_route}
/// Board of a new game for [players] players (S-03).
/// {@endtemplate}
@TypedGoRoute<NewGameRoute>(path: '/game/new/:players')
class NewGameRoute extends GoRouteData with $NewGameRoute {
  /// {@macro new_game_route}
  const new({required this.players});

  /// Number of players (1–11).
  final int players;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      _GameScreen(launch: NewGameLaunch(playerCount: players));
}

/// {@template resume_game_route}
/// Board of the saved game (S-03, F-04).
/// {@endtemplate}
@TypedGoRoute<ResumeGameRoute>(path: '/game/resume')
class ResumeGameRoute extends GoRouteData with $ResumeGameRoute {
  /// {@macro resume_game_route}
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const _GameScreen(launch: ResumeGameLaunch());
}

class _GameScreen extends StatelessWidget {
  const new({required this.launch});

  final GameLaunch launch;

  @override
  Widget build(BuildContext context) {
    return GameModule(
      launch: launch,
      child: GameView(
        onExit: () => const StartRoute().go(context),
        onNewGame: () => const SetupRoute().go(context),
        onRules: () => const RulesRoute().push<void>(context),
      ),
    );
  }
}
