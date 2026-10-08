import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:game_data/game_data.dart';

import '../helpers/game_states.dart';
import '../helpers/in_memory_preferences.dart';
import '../helpers/random_game.dart';

void main() {
  group('$GameRepository with $LocalGameDataSource', () {
    late InMemoryPreferences preferences;

    setUp(() {
      preferences = InMemoryPreferences();
    });

    GameRepository newRepository() =>
        GameRepository(dataSource: LocalGameDataSource(preferences));

    test('AC-042: every state of 50 games is restored exactly '
        'after a restart', () async {
      for (var seed = 0; seed < 50; seed++) {
        for (final state in playRandomGame(seed)) {
          await newRepository().saveGame(state);
          expect(await newRepository().loadGame(), equals(state));
        }
      }
    });

    test('F-04: a deleted game is gone', () async {
      final repository = newRepository();
      await repository.saveGame(buildGameState());
      await repository.deleteGame();
      expect(await repository.hasSavedGame(), isFalse);
      expect(await repository.loadGame(), isNull);
    });

    test('T-021: reads the frozen version 1 format', () async {
      preferences.values[LocalGameDataSource.storageKey] = File(
        'test/fixtures/saved_game_v1.json',
      ).readAsStringSync();
      expect(
        await newRepository().loadGame(),
        equals(representativeStates['a game in progress']),
      );
    });
  });
}
