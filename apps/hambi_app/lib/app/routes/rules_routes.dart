part of 'app_router.dart';

/// {@template rules_route}
/// The rules (S-05), pushed over the start or the game (UX-10).
/// {@endtemplate}
@TypedGoRoute<RulesRoute>(path: '/rules')
class RulesRoute extends GoRouteData with $RulesRoute {
  /// {@macro rules_route}
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      RulesModule(child: RulesView(onBack: () => context.pop()));
}
