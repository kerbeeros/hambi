part of 'app_router.dart';

/// {@template start_route}
/// Start screen (S-01).
/// {@endtemplate}
@TypedGoRoute<StartRoute>(
  path: '/',
  routes: [TypedGoRoute<SetupRoute>(path: 'setup')],
)
class StartRoute extends GoRouteData with $StartRoute {
  /// {@macro start_route}
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) => StartModule(
    child: StartView(
      onNewGame: () => const SetupRoute().go(context),
      onResume: () => const ResumeGameRoute().go(context),
    ),
  );
}

/// {@template setup_route}
/// Setup of a new game (S-02).
/// {@endtemplate}
class SetupRoute extends GoRouteData with $SetupRoute {
  /// {@macro setup_route}
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) => SetupModule(
    child: SetupView(
      onStart: (playerCount) => NewGameRoute(players: playerCount).go(context),
      onBack: () => const StartRoute().go(context),
    ),
  );
}
