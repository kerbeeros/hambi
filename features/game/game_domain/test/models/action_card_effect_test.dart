// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

void main() {
  group(ActionCardEffect, () {
    test('supports value equality', () {
      expect(
        ActionCardEffect(activists: 1, resources: 1),
        equals(ActionCardEffect(activists: 1, resources: 1)),
      );
      expect(
        ActionCardEffect(placesActivistOnForest: true),
        isNot(equals(ActionCardEffect())),
      );
    });
  });
}
