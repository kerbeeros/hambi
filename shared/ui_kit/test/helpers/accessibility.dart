import 'package:flutter_test/flutter_test.dart';

/// Checks the pumped widget against the accessibility guidelines of NF-04
/// (AC-060): labeled tap targets, tap target sizes and text contrast.
Future<void> expectMeetsAccessibilityGuidelines(WidgetTester tester) async {
  final semantics = tester.ensureSemantics();
  await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
  await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
  await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
  await expectLater(tester, meetsGuideline(textContrastGuideline));
  semantics.dispose();
}
