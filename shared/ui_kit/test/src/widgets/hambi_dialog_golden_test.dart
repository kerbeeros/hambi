// goldenTest registers its tests synchronously; the returned Future must not
// be awaited inside a group.
// ignore_for_file: discarded_futures

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(HambiDialog, () {
    goldenTest(
      'renders dialog and bottom sheet',
      fileName: 'hambi_dialog',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 393),
        children: [
          GoldenTestScenario(
            name: 'dialog',
            child: HambiDialog(
              title: 'Negative Presse',
              content: const Text(
                'Ihr verliert entweder 1 Unterstützung '
                'oder 1 Mitstreiter*in.',
              ),
              actions: [
                HambiButton(label: 'Unterstützung −1', onPressed: () {}),
                HambiButton(
                  label: 'Mitstreiter*in −1',
                  onPressed: () {},
                  style: HambiButtonStyle.secondary,
                ),
              ],
            ),
          ),
          GoldenTestScenario(
            name: 'bottom sheet',
            child: const HambiBottomSheet(
              title: 'Rundenlog',
              child: Text('Würfel: 3 und 5'),
            ),
          ),
        ],
      ),
    );
  });
}
