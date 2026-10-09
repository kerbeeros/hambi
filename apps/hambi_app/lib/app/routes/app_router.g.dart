// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $newGameRoute,
  $resumeGameRoute,
  $rulesRoute,
  $startRoute,
];

RouteBase get $newGameRoute => GoRouteData.$route(
  path: '/game/new/:players',
  hasOverriddenOnExit: false,
  factory: $NewGameRoute._fromState,
);

mixin $NewGameRoute on GoRouteData {
  static NewGameRoute _fromState(GoRouterState state) =>
      NewGameRoute(players: int.parse(state.pathParameters['players']!));

  NewGameRoute get _self => this as NewGameRoute;

  @override
  String get location => GoRouteData.$location(
    '/game/new/${Uri.encodeComponent(_self.players.toString())}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $resumeGameRoute => GoRouteData.$route(
  path: '/game/resume',
  hasOverriddenOnExit: false,
  factory: $ResumeGameRoute._fromState,
);

mixin $ResumeGameRoute on GoRouteData {
  static ResumeGameRoute _fromState(GoRouterState state) =>
      const ResumeGameRoute();

  @override
  String get location => GoRouteData.$location('/game/resume');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $rulesRoute => GoRouteData.$route(
  path: '/rules',
  hasOverriddenOnExit: false,
  factory: $RulesRoute._fromState,
);

mixin $RulesRoute on GoRouteData {
  static RulesRoute _fromState(GoRouterState state) => const RulesRoute();

  @override
  String get location => GoRouteData.$location('/rules');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $startRoute => GoRouteData.$route(
  path: '/',
  hasOverriddenOnExit: false,
  factory: $StartRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'setup',
      hasOverriddenOnExit: false,
      factory: $SetupRoute._fromState,
    ),
  ],
);

mixin $StartRoute on GoRouteData {
  static StartRoute _fromState(GoRouterState state) => const StartRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SetupRoute on GoRouteData {
  static SetupRoute _fromState(GoRouterState state) => const SetupRoute();

  @override
  String get location => GoRouteData.$location('/setup');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
