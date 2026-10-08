// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';

void main() {
  group(GameEvent, () {
    test('$GameStarted supports value equality', () {
      expect(GameStarted(playerCount: 3), equals(GameStarted(playerCount: 3)));
      expect(
        GameStarted(playerCount: 3),
        isNot(equals(GameStarted(playerCount: 4))),
      );
    });

    test('$GameResumed supports value equality', () {
      expect(GameResumed(), equals(GameResumed()));
    });

    test('$GameCommandSubmitted supports value equality', () {
      expect(
        GameCommandSubmitted(Continue()),
        equals(GameCommandSubmitted(Continue())),
      );
      expect(
        GameCommandSubmitted(Continue()),
        isNot(equals(GameCommandSubmitted(EndPreparation()))),
      );
    });

    test('$GameLogEntryAcknowledged supports value equality', () {
      expect(GameLogEntryAcknowledged(), equals(GameLogEntryAcknowledged()));
    });
  });
}
