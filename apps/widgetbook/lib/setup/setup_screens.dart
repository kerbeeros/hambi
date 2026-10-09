import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_domain/game_domain.dart';
import 'package:setup_presentation/setup_presentation.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Repository that only answers whether a game is saved.
class _CatalogRepository implements IGameRepository {
  const new({required this.hasSaved});

  final bool hasSaved;

  @override
  Future<bool> hasSavedGame() async => hasSaved;

  @override
  Future<GameState?> loadGame() async => null;

  @override
  Future<void> saveGame(GameState state) async {}

  @override
  Future<void> deleteGame() async {}
}

/// The start screen (S-01) with or without a saved game.
@widgetbook.UseCase(name: 'Start', type: StartView)
Widget buildStartViewUseCase(BuildContext context) {
  final hasSaved = context.knobs.boolean(label: 'Saved game');
  return RepositoryProvider<IGameRepository>(
    key: ValueKey(hasSaved),
    create: (_) => _CatalogRepository(hasSaved: hasSaved),
    child: StartModule(
      child: StartView(onNewGame: () {}, onResume: () {}, onRules: () {}),
    ),
  );
}

/// The setup screen (S-02); with a saved game, starting asks first (D-11).
@widgetbook.UseCase(name: 'Setup', type: SetupView)
Widget buildSetupViewUseCase(BuildContext context) {
  final hasSaved = context.knobs.boolean(label: 'Saved game');
  return RepositoryProvider<IGameRepository>(
    key: ValueKey(hasSaved),
    create: (_) => _CatalogRepository(hasSaved: hasSaved),
    child: SetupModule(
      child: SetupView(onStart: (_) {}, onBack: () {}),
    ),
  );
}
