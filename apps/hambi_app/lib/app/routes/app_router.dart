import 'package:flutter/widgets.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:go_router/go_router.dart';
import 'package:setup_presentation/setup_presentation.dart';

part 'app_router.g.dart';
part 'game_routes.dart';
part 'setup_routes.dart';

/// Creates the router of the app (spec 5.1).
GoRouter createRouter() => GoRouter(routes: $appRoutes);
