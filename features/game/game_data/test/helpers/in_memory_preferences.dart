import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// In-memory replacement for the device storage.
class InMemoryPreferences extends Fake implements SharedPreferencesAsync {
  /// Stored values by key.
  final Map<String, String> values = {};

  @override
  Future<void> setString(String key, String value) async => values[key] = value;

  @override
  Future<String?> getString(String key) async => values[key];

  @override
  Future<void> remove(String key) async => values.remove(key);

  @override
  Future<bool> containsKey(String key) async => values.containsKey(key);
}
