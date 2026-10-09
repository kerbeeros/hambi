// goldenTest registers its tests synchronously; the returned Future must not
// be awaited inside a group.
// ignore_for_file: discarded_futures

import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(RollingDieView, () {
    goldenTest(
      'renders a rolling and a settled die',
      fileName: 'rolling_die_view',
      tags: [TestTag.golden],
      // A rolling die never settles.
      pumpBeforeTest: pumpOnce,
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'rolling',
            child: const RollingDieView(value: 3, rolling: true),
          ),
          GoldenTestScenario(
            name: 'settled',
            child: const RollingDieView(value: 3, rolling: false),
          ),
        ],
      ),
    );
  });
}
