/// {@template load_game_exception}
/// Thrown by a game repository when the saved game cannot be
/// read, e.g. invalid data or an unsupported format version (T-021).
/// {@endtemplate}
class LoadGameException implements Exception {
  /// {@macro load_game_exception}
  const new(this.message);

  /// Why the saved game could not be loaded.
  final String message;

  @override
  String toString() => 'LoadGameException: $message';
}

/// {@template save_game_exception}
/// Thrown when the game cannot be saved (T-020).
/// {@endtemplate}
class SaveGameException implements Exception {
  /// {@macro save_game_exception}
  const new(this.message);

  /// Why the game could not be saved.
  final String message;

  @override
  String toString() => 'SaveGameException: $message';
}
