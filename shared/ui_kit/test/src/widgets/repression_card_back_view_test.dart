import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(RepressionCardBackView, () {
    testWidgets('is as large as a repression card in a dialog', (tester) async {
      await tester.pumpApp(const RepressionCardBackView());

      expect(
        tester.getSize(find.byType(RepressionCardBackView)),
        equals(const Size(200, 280)),
      );
    });
  });
}
