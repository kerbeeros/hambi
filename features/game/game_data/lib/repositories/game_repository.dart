import 'package:flutter/services.dart';
import 'package:game_data/data_sources/data_sources.dart';
import 'package:game_data/data_sources/dtos/dtos.dart';
import 'package:game_data/mappers/mappers.dart';
import 'package:game_domain/game_domain.dart';
import 'package:json_annotation/json_annotation.dart';

/// {@template game_repository}
/// Stores the single saved game on the device (T-020–T-022, ADR 0006).
/// {@endtemplate}
class GameRepository implements IGameRepository {
  /// {@macro game_repository}
  const new({required this._dataSource});

  /// Current version of the storage format (T-021).
  static const int schemaVersion = 1;

  final LocalGameDataSource _dataSource;

  static const _toLocal = DomainToLocalGameStateMapper();
  static const _toDomain = LocalToDomainGameStateMapper();

  @override
  Future<void> saveGame(GameState state) async {
    try {
      await _dataSource.writeGame(
        SavedGameDto(schemaVersion: schemaVersion, game: _toLocal.map(state)),
      );
    } on PlatformException catch (error) {
      throw SaveGameException('Game could not be saved: ${error.code}');
    }
  }

  @override
  Future<GameState?> loadGame() async {
    try {
      final saved = await _dataSource.readGame();
      if (saved == null) return null;
      if (saved.schemaVersion != schemaVersion) {
        throw LoadGameException(
          'Unsupported schema version ${saved.schemaVersion}',
        );
      }
      return _toDomain.map(saved.game);
    } on FormatException catch (error) {
      throw LoadGameException('Saved game is invalid: ${error.message}');
    } on CheckedFromJsonException catch (error) {
      throw LoadGameException('Saved game is invalid: ${error.message}');
    } on PlatformException catch (error) {
      throw LoadGameException('Saved game could not be read: ${error.code}');
    }
  }

  @override
  Future<void> deleteGame() async {
    try {
      await _dataSource.deleteGame();
    } on PlatformException catch (error) {
      throw SaveGameException('Saved game could not be deleted: ${error.code}');
    }
  }

  @override
  Future<bool> hasSavedGame() async {
    try {
      return await _dataSource.hasGame();
    } on PlatformException catch (error) {
      throw LoadGameException('Saved game could not be read: ${error.code}');
    }
  }
}
