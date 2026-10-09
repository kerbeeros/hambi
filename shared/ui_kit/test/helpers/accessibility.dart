import 'package:flutter_test/flutter_test.dart';

// Set by the ci workflow, see ADR 0004.
const _isRunningInCi = bool.fromEnvironment('CI');

/// Checks the pumped widget against the accessibility guidelines of NF-04
/// (AC-060): labeled tap targets, tap target sizes and text contrast.
Future<void> expectMeetsAccessibilityGuidelines(WidgetTester tester) async {
  final semantics = tester.ensureSemantics();
  await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
  await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
  await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
  // The contrast check samples rendered pixels, and Linux renders small text
  // thinner than macOS, so it only runs locally like the platform goldens
  // (ADR 0004). The colors themselves meet WCAG AA by calculation.
  if (!_isRunningInCi) {
    await expectLater(tester, meetsGuideline(textContrastGuideline));
  }
  semantics.dispose();
}

/// Scales all text by [factor] for the rest of the test, like the system
/// font size setting (AC-061).
void setTextScale(WidgetTester tester, double factor) {
  tester.platformDispatcher.textScaleFactorTestValue = factor;
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
}
