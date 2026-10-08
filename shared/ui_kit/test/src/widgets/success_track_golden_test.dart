// goldenTest registers its tests synchronously; the returned Future must not
// be awaited inside a group.
// ignore_for_file: discarded_futures

import 'package:alchemist/alchemist.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(SuccessTrack, () {
    goldenTest(
      'renders values and repression fields',
      fileName: 'success_track',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        columns: 1,
        scenarioConstraints: const BoxConstraints(maxWidth: 361),
        children: [
          GoldenTestScenario(
            name: 'activists 0',
            child: const SuccessTrack(
              kind: SuccessTrackKind.activists,
              value: 0,
              repressionFields: {2, 4, 6, 8},
            ),
          ),
          GoldenTestScenario(
            name: 'activists 7, fields 2, 4, 6 activated',
            child: const SuccessTrack(
              kind: SuccessTrackKind.activists,
              value: 7,
              repressionFields: {2, 4, 6, 8},
              activatedFields: {2, 4, 6},
            ),
          ),
          GoldenTestScenario(
            name: 'support 11, all fields activated, not compact',
            child: const SuccessTrack(
              kind: SuccessTrackKind.support,
              value: 11,
              repressionFields: {4, 6, 7, 10},
              activatedFields: {4, 6, 7, 10},
              compact: false,
            ),
          ),
        ],
      ),
    );
  });
}
