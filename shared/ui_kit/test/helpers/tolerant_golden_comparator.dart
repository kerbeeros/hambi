import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

/// Golden comparator that accepts a small share of differing pixels.
///
/// CI renders goldens on Linux while they are generated on macOS; edge
/// anti-aliasing differs by a few pixels even with obscured text (ADR 0004).
class TolerantGoldenFileComparator extends LocalFileComparator {
  /// Creates a comparator for goldens next to [testFile].
  new(super.testFile, {required this.tolerance});

  /// Maximum share of differing pixels, e.g. `0.001` for 0.1 %.
  final double tolerance;

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );
    if (result.passed || result.diffPercent <= tolerance) {
      result.dispose();
      return true;
    }
    final error = await generateFailureOutput(result, golden, basedir);
    result.dispose();
    throw FlutterError(error);
  }
}
