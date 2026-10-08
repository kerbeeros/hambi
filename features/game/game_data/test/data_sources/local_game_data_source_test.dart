import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:game_data/data_sources/data_sources.dart';
import 'package:game_data/data_sources/dtos/dtos.dart';
import 'package:game_data/mappers/mappers.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/game_states.dart';

class _MockSharedPreferencesAsync extends Mock
    implements SharedPreferencesAsync;

void main() {
  group(LocalGameDataSource, () {
    const key = LocalGameDataSource.storageKey;
    late SharedPreferencesAsync preferences;
    late LocalGameDataSource dataSource;
    late SavedGameDto savedGame;
    late String savedJson;

    setUp(() {
      preferences = _MockSharedPreferencesAsync();
      dataSource = LocalGameDataSource(preferences);
      savedGame = SavedGameDto(
        schemaVersion: 1,
        game: const DomainToLocalGameStateMapper().map(
          representativeStates['a game in progress']!,
        ),
      );
      savedJson = jsonEncode(savedGame.toJson());
    });

    group('writeGame', () {
      test('stores the game as JSON under the storage key', () async {
        when(() => preferences.setString(key, any())).thenAnswer((_) async {});
        await dataSource.writeGame(savedGame);
        verify(() => preferences.setString(key, savedJson)).called(1);
      });
    });

    group('readGame', () {
      test('returns null when nothing is stored', () async {
        when(() => preferences.getString(key)).thenAnswer((_) async => null);
        expect(await dataSource.readGame(), isNull);
      });

      test('returns the stored game', () async {
        when(() => preferences.getString(key))
            .thenAnswer((_) async => savedJson);
        final game = await dataSource.readGame();
        expect(jsonEncode(game!.toJson()), equals(savedJson));
      });

      test('throws $FormatException for invalid JSON', () async {
        when(() => preferences.getString(key)).thenAnswer((_) async => '{');
        expect(dataSource.readGame, throwsFormatException);
      });

      test('throws $FormatException when JSON is not an object', () async {
        when(() => preferences.getString(key)).thenAnswer((_) async => '[]');
        expect(dataSource.readGame, throwsFormatException);
      });

      test('throws $CheckedFromJsonException for a missing field', () async {
        when(() => preferences.getString(key))
            .thenAnswer((_) async => '{"schemaVersion": 1}');
        expect(dataSource.readGame, throwsA(isA<CheckedFromJsonException>()));
      });
    });

    group('deleteGame', () {
      test('removes the storage key', () async {
        when(() => preferences.remove(key)).thenAnswer((_) async {});
        await dataSource.deleteGame();
        verify(() => preferences.remove(key)).called(1);
      });
    });

    group('hasGame', () {
      for (final stored in [true, false]) {
        test(
          'returns $stored when the key is ${stored ? '' : 'not '}set',
          () async {
            when(() => preferences.containsKey(key))
                .thenAnswer((_) async => stored);
            expect(await dataSource.hasGame(), equals(stored));
          },
        );
      }
    });
  });
}
