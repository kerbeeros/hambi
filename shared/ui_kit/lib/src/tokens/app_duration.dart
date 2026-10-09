/// Durations of the animations in the Hambi design system.
abstract final class AppDuration {
  /// 80 ms – a rolling die shows its next face.
  static const Duration dieFace = Duration(milliseconds: 80);

  /// 400 ms – a card turns over.
  static const Duration cardFlip = Duration(milliseconds: 400);

  /// 1000 ms – dice roll or a drawn card stays face down before the result
  /// shows (UX-04).
  static const Duration reveal = Duration(milliseconds: 1000);
}
