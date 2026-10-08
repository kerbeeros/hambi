// goldenTest registers its tests synchronously; the returned Future must not
// be awaited inside a group.
// ignore_for_file: discarded_futures

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(HambiButton, () {
    goldenTest(
      'renders all styles and states',
      fileName: 'hambi_button',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 280),
        children: [
          GoldenTestScenario(
            name: 'primary enabled',
            child: HambiButton(label: 'Weiter', onPressed: () {}),
          ),
          GoldenTestScenario(
            name: 'primary disabled',
            child: const HambiButton(label: 'Weiter', onPressed: null),
          ),
          GoldenTestScenario(
            name: 'secondary enabled',
            child: HambiButton(
              label: 'Zurück',
              onPressed: () {},
              style: HambiButtonStyle.secondary,
            ),
          ),
          GoldenTestScenario(
            name: 'secondary disabled',
            child: const HambiButton(
              label: 'Zurück',
              onPressed: null,
              style: HambiButtonStyle.secondary,
            ),
          ),
        ],
      ),
    );
  });
}
