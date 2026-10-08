import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:game_data/data_sources/dtos/dtos.dart';
import 'package:game_data/mappers/mappers.dart';

import '../helpers/game_states.dart';

void main() {
  group('game state mappers', () {
    late DomainToLocalGameStateMapper toLocal;
    late LocalToDomainGameStateMapper toDomain;

    setUp(() {
      toLocal = const DomainToLocalGameStateMapper();
      toDomain = const LocalToDomainGameStateMapper();
    });

    for (final MapEntry(key: description, value: state)
        in representativeStates.entries) {
      test('T-006: restore $description', () {
        expect(toDomain.map(toLocal.map(state)), equals(state));
      });

      test('T-006: restore $description through JSON', () {
        final json = jsonDecode(jsonEncode(toLocal.map(state).toJson()));
        expect(
          toDomain.map(GameStateDto.fromJson(json as Map<String, dynamic>)),
          equals(state),
        );
      });
    }

    group(LocalToDomainGameStateMapper, () {
      Map<String, dynamic> validJson(String description) => jsonDecode(
        jsonEncode(toLocal.map(representativeStates[description]!).toJson()),
      ) as Map<String, dynamic>;

      GameStateDto dtoWith(
        String description,
        void Function(Map<String, dynamic> json) change,
      ) {
        final json = validJson(description);
        change(json);
        return GameStateDto.fromJson(json);
      }

      final invalidData =
          <String, (String, void Function(Map<String, dynamic>))>{
            'an unknown phase': (
              'a game in progress',
              (json) => json['phase'] = 'lunch',
            ),
            'an unknown action card': (
              'a game in progress',
              (json) => json['assignedCards'] = ['coffee'],
            ),
            'an unknown card side': (
              'a game in progress',
              (json) => (json['cardSides'] as Map)['demo'] = 'c',
            ),
            'an unknown repression card': (
              'a game in progress',
              (json) => json['repressionDeck'] = ['party'],
            ),
            'an unknown forest card state': (
              'a game in progress',
              (json) => ((json['forest'] as List)[0] as List)[0] = {
                'state': 'burnt',
                'hasSecurity': false,
                'hasActivist': false,
              },
            ),
            'a forest with a missing column': (
              'a game in progress',
              (json) => (json['forest'] as List).removeLast(),
            ),
            'a forest column with a missing card': (
              'a game in progress',
              (json) => ((json['forest'] as List)[1] as List).removeLast(),
            ),
            'a missing action card side': (
              'a game in progress',
              (json) => (json['cardSides'] as Map).remove('demo'),
            ),
            'an unknown outcome': (
              'a won game',
              (json) => json['outcome'] = 'draw',
            ),
            'an unknown decision type': (
              'a pending reroll',
              (json) => (json['pendingDecision'] as Map)['type'] = 'vote',
            ),
            'a decision without its value': (
              'a pending reroll',
              (json) => (json['pendingDecision'] as Map).remove('dice'),
            ),
            'an unknown event type': (
              'a game in progress',
              (json) => ((json['log'] as List)[0] as Map)['type'] = 'party',
            ),
            'an event without its value': (
              'a game in progress',
              (json) => ((json['log'] as List)[2] as Map).remove('card'),
            ),
          };
      for (final MapEntry(key: description, value: (base, change))
          in invalidData.entries) {
        test('throws $FormatException for $description', () {
          expect(
            () => toDomain.map(dtoWith(base, change)),
            throwsFormatException,
          );
        });
      }
    });
  });
}
