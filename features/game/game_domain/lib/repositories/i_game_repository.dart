import 'package:game_domain/models/game_state.dart';

/// Stores the single saved game (T-007, T-020).
abstract interface class IGameRepository {
  /// Saves [state], replacing any previously saved game.
  Future<void> saveGame(GameState state);

  /// Loads the saved game, or returns `null` if there is none.
  Future<GameState?> loadGame();

  /// Deletes the saved game, if any.
  Future<void> deleteGame();

  /// Whether a saved game exists.
  Future<bool> hasSavedGame();
}
