// goldenTest registers its tests synchronously; the returned Future must not
// be awaited inside a group.
// ignore_for_file: discarded_futures

import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(DieView, () {
    goldenTest(
      'renders all values',
      fileName: 'die_view',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        columns: 6,
        children: [
          for (var value = 1; value <= 6; value++)
            GoldenTestScenario(
              name: '$value',
              child: DieView(value: value),
            ),
        ],
      ),
    );
  });
}
