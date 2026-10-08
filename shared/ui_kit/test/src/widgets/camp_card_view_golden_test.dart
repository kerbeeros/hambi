// goldenTest registers its tests synchronously; the returned Future must not
// be awaited inside a group.
// ignore_for_file: discarded_futures

import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(CampCardView, () {
    goldenTest(
      'renders empty and filled camps',
      fileName: 'camp_card_view',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'empty',
            child: const CampCardView(
              title: 'Camp',
              activists: 0,
              resources: 0,
            ),
          ),
          GoldenTestScenario(
            name: 'filled',
            child: const CampCardView(
              title: 'Camp',
              activists: 11,
              resources: 8,
            ),
          ),
        ],
      ),
    );
  });
}
