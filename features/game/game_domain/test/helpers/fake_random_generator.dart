import 'package:game_domain/game_domain.dart';

/// Random generator that returns scripted values in order.
///
/// Each scripted value must be smaller than the requested `max`. Once the
/// script is exhausted, it returns `0`. The state counts the calls made.
class FakeRandomGenerator implements IRandomGenerator {
  new([List<int> values = const []]) : _values = values;

  final List<int> _values;

  @override
  int seed(int seed) => 0;

  @override
  ({int value, int state}) nextInt(int state, int max) {
    final value = state < _values.length ? _values[state] : 0;
    if (value >= max) {
      throw StateError('Scripted value $value is not below $max');
    }
    return (value: value, state: state + 1);
  }
}
