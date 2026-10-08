import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

void main() {
  group(XorShiftRandomGenerator, () {
    late XorShiftRandomGenerator generator;

    setUp(() {
      generator = const XorShiftRandomGenerator();
    });

    List<int> sequence(int seed, int length, int max) {
      var state = generator.seed(seed);
      final values = <int>[];
      for (var i = 0; i < length; i++) {
        final (:value, state: nextState) = generator.nextInt(state, max);
        values.add(value);
        state = nextState;
      }
      return values;
    }

    group('nextInt', () {
      test('returns the same sequence for the same seed (T-005)', () {
        expect(sequence(42, 100, 6), equals(sequence(42, 100, 6)));
      });

      test('returns different sequences for different seeds', () {
        expect(sequence(1, 20, 6), isNot(equals(sequence(2, 20, 6))));
      });

      test('returns values in [0, max)', () {
        final values = sequence(7, 1000, 6);
        expect(values.every((v) => v >= 0 && v < 6), isTrue);
      });

      test('returns every value in [0, max) eventually', () {
        expect(sequence(7, 1000, 6).toSet(), equals({0, 1, 2, 3, 4, 5}));
      });

      test('throws $ArgumentError when max is not positive', () {
        expect(
          () => generator.nextInt(generator.seed(1), 0),
          throwsArgumentError,
        );
      });
    });

    group('seed', () {
      test('returns a usable state for seed 0', () {
        expect(sequence(0, 20, 6).toSet(), hasLength(greaterThan(1)));
      });
    });
  });
}
