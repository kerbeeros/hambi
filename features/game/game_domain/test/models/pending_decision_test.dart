// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

void main() {
  group(ReturnActivistsDecision, () {
    test('supports value equality', () {
      expect(ReturnActivistsDecision(), equals(ReturnActivistsDecision()));
      expect(
        ReturnActivistsDecision(),
        isNot(equals(PlaceActivistsDecision(activists: 1))),
      );
    });
  });

  group(NegativePressDecision, () {
    test('supports value equality', () {
      expect(NegativePressDecision(), equals(NegativePressDecision()));
      expect(NegativePressDecision(), isNot(equals(RestoreCardDecision())));
    });
  });

  group(RestoreCardDecision, () {
    test('supports value equality', () {
      expect(RestoreCardDecision(), equals(RestoreCardDecision()));
    });
  });
}
