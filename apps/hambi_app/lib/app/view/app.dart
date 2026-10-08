import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/l10n/l10n.dart' show GameLocalizations;
import 'package:go_router/go_router.dart';
import 'package:hambi_app/app/routes/app_router.dart';
import 'package:hambi_app/l10n/l10n.dart';
import 'package:setup_presentation/l10n/l10n.dart' show SetupLocalizations;
import 'package:ui_kit/ui_kit.dart';

/// {@template app}
/// The Hambi app: provides the game repository, theme, texts and routes.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const new({required this.gameRepository, super.key});

  /// Storage of the saved game (T-020).
  final IGameRepository gameRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: gameRepository,
      child: const _AppView(),
    );
  }
}

class _AppView extends StatefulWidget {
  const new();

  @override
  State<_AppView> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  // Kept for the lifetime of the app so that hot reload keeps the route.
  late final GoRouter _router = createRouter();

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.light,
      onGenerateTitle: (context) => context.l10n.appTitle,
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        GameLocalizations.delegate,
        SetupLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
    );
  }
}
