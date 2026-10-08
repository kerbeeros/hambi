import 'dart:convert';

import 'package:game_data/data_sources/dtos/dtos.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template local_game_data_source}
/// Stores the single saved game as JSON in shared preferences (ADR 0006).
/// {@endtemplate}
class LocalGameDataSource {
  /// {@macro local_game_data_source}
  const new(this._preferences);

  /// Key under which the saved game is stored.
  static const String storageKey = 'hambi.savedGame';

  final SharedPreferencesAsync _preferences;

  /// Stores [game], replacing the previous one.
  Future<void> writeGame(SavedGameDto game) =>
      _preferences.setString(storageKey, jsonEncode(game.toJson()));

  /// Reads the stored game, or returns `null` if there is none.
  ///
  /// Throws [FormatException] when the stored value is not a JSON object and
  /// [CheckedFromJsonException] when it does not match [SavedGameDto].
  Future<SavedGameDto?> readGame() async {
    final value = await _preferences.getString(storageKey);
    if (value == null) return null;
    final json = jsonDecode(value);
    if (json is! Map<String, dynamic>) {
      throw FormatException('Saved game is not a JSON object', value);
    }
    return SavedGameDto.fromJson(json);
  }

  /// Deletes the stored game.
  Future<void> deleteGame() => _preferences.remove(storageKey);

  /// Whether a game is stored.
  Future<bool> hasGame() => _preferences.containsKey(storageKey);
}
