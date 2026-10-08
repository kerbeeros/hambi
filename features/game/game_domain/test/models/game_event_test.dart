// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

void main() {
  group(DieRerolled, () {
    test('supports value equality', () {
      expect(
        DieRerolled(index: 0, value: 3),
        equals(DieRerolled(index: 0, value: 3)),
      );
      expect(
        DieRerolled(index: 0, value: 3),
        isNot(equals(DieRerolled(index: 1, value: 3))),
      );
    });
  });
}
