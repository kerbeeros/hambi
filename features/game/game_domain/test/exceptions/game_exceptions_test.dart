import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

void main() {
  group(InvalidPlayerCountException, () {
    group('toString', () {
      test('contains the type and the player count', () {
        expect(
          const InvalidPlayerCountException(12).toString(),
          equals(
            'InvalidPlayerCountException: '
            'Player count must be between 1 and 11, was 12',
          ),
        );
      });
    });
  });
}
