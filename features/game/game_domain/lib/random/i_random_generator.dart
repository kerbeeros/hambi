/// Deterministic source of randomness for the rules engine (T-005).
///
/// The generator itself is stateless; its state is passed in and returned so
/// that it can be stored in the game state and the engine stays pure.
abstract interface class IRandomGenerator {
  /// Derives an initial generator state from [seed].
  int seed(int seed);

  /// Returns a value in `[0, max)` and the next generator state.
  ///
  /// Throws [ArgumentError] when [max] is not positive.
  ({int value, int state}) nextInt(int state, int max);
}
