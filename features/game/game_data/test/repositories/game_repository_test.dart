import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_data/data_sources/data_sources.dart';
import 'package:game_data/data_sources/dtos/dtos.dart';
import 'package:game_data/mappers/mappers.dart';
import 'package:game_data/repositories/repositories.dart';
import 'package:game_domain/game_domain.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/game_states.dart';

class _MockLocalGameDataSource extends Mock implements LocalGameDataSource;

void main() {
  group(GameRepository, () {
    late LocalGameDataSource dataSource;
    late GameRepository repository;
    late GameState state;
    late GameStateDto dto;

    setUpAll(() {
      registerFallbackValue(
        SavedGameDto(
          schemaVersion: 1,
          game: const DomainToLocalGameStateMapper().map(buildGameState()),
        ),
      );
    });

    setUp(() {
      dataSource = _MockLocalGameDataSource();
      repository = GameRepository(dataSource: dataSource);
      state = representativeStates['a game in progress']!;
      dto = const DomainToLocalGameStateMapper().map(state);
    });

    final platformException = PlatformException(code: 'storage');

    group('saveGame', () {
      test('T-021: writes the state with the current schema version', () async {
        when(() => dataSource.writeGame(any())).thenAnswer((_) async {});
        await repository.saveGame(state);
        final saved =
            verify(() => dataSource.writeGame(captureAny())).captured.single
                as SavedGameDto;
        expect(saved.schemaVersion, equals(GameRepository.schemaVersion));
        expect(
          const LocalToDomainGameStateMapper().map(saved.game),
          equals(state),
        );
      });

      test('throws $SaveGameException when storage fails', () async {
        when(() => dataSource.writeGame(any())).thenThrow(platformException);
        expect(
          () => repository.saveGame(state),
          throwsA(isA<SaveGameException>()),
        );
      });
    });

    group('loadGame', () {
      test('returns null without a saved game', () async {
        when(dataSource.readGame).thenAnswer((_) async => null);
        expect(await repository.loadGame(), isNull);
      });

      test('returns the saved game', () async {
        when(dataSource.readGame)
            .thenAnswer((_) async => SavedGameDto(schemaVersion: 1, game: dto));
        expect(await repository.loadGame(), equals(state));
      });

      test(
        'T-021: throws $LoadGameException for an unknown schema version',
        () async {
          when(
            dataSource.readGame,
          ).thenAnswer((_) async => SavedGameDto(schemaVersion: 2, game: dto));
          expect(repository.loadGame, throwsA(isA<LoadGameException>()));
        },
      );

      final failures = <String, Object>{
        'invalid data': const FormatException('broken'),
        'a mismatching format': CheckedFromJsonException({}, 'game', 'X', ''),
        'a storage failure': platformException,
      };
      for (final MapEntry(key: description, value: error) in failures.entries) {
        test('throws $LoadGameException for $description', () async {
          when(dataSource.readGame).thenThrow(error);
          expect(repository.loadGame, throwsA(isA<LoadGameException>()));
        });
      }
    });

    group('deleteGame', () {
      test('deletes the saved game', () async {
        when(dataSource.deleteGame).thenAnswer((_) async {});
        await repository.deleteGame();
        verify(dataSource.deleteGame).called(1);
      });

      test('throws $SaveGameException when storage fails', () async {
        when(dataSource.deleteGame).thenThrow(platformException);
        expect(repository.deleteGame, throwsA(isA<SaveGameException>()));
      });
    });

    group('hasSavedGame', () {
      test('returns whether a game is saved', () async {
        when(dataSource.hasGame).thenAnswer((_) async => true);
        expect(await repository.hasSavedGame(), isTrue);
      });

      test('throws $LoadGameException when storage fails', () async {
        when(dataSource.hasGame).thenThrow(platformException);
        expect(repository.hasSavedGame, throwsA(isA<LoadGameException>()));
      });
    });
  });
}
