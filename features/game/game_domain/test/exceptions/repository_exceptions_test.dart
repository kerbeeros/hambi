import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

void main() {
  group(LoadGameException, () {
    group('toString', () {
      test('contains the type and the message', () {
        expect(
          const LoadGameException('Unsupported schema version 2').toString(),
          equals('LoadGameException: Unsupported schema version 2'),
        );
      });
    });
  });

  group(SaveGameException, () {
    group('toString', () {
      test('contains the type and the message', () {
        expect(
          const SaveGameException('Storage unavailable').toString(),
          equals('SaveGameException: Storage unavailable'),
        );
      });
    });
  });
}
