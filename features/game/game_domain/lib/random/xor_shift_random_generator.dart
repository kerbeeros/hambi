import 'package:game_domain/random/i_random_generator.dart';

/// {@template xor_shift_random_generator}
/// 32-bit xorshift generator.
///
/// Uses its own algorithm instead of `dart:math` so that sequences stay
/// identical across platforms and SDK versions.
/// {@endtemplate}
class XorShiftRandomGenerator implements IRandomGenerator {
  /// {@macro xor_shift_random_generator}
  const new();

  static const int _mask = 0xFFFFFFFF;

  // xorshift requires a non-zero state.
  static const int _fallbackState = 0x9E3779B9;

  @override
  int seed(int seed) {
    final state = seed & _mask;
    return state == 0 ? _fallbackState : state;
  }

  @override
  ({int value, int state}) nextInt(int state, int max) {
    if (max <= 0) {
      throw ArgumentError.value(max, 'max', 'must be positive');
    }
    var x = state;
    x ^= (x << 13) & _mask;
    x ^= x >> 17;
    x ^= (x << 5) & _mask;
    return (value: x % max, state: x);
  }
}
