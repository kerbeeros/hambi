// goldenTest registers its tests synchronously; the returned Future must not
// be awaited inside a group.
// ignore_for_file: discarded_futures

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(RoundHeader, () {
    goldenTest(
      'renders round and phase',
      fileName: 'round_header',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 393),
        children: [
          GoldenTestScenario(
            name: 'round 3',
            child: RoundHeader(
              title: 'Runde 3/12',
              subtitle: 'Vorbereitung',
              logTooltip: 'Rundenlog',
              menuTooltip: 'Spielmenü',
              onLogPressed: () {},
              onMenuPressed: () {},
            ),
          ),
        ],
      ),
    );
  });

  group(PhaseStepper, () {
    const labels = ['Vorbereitung', 'Aktion', 'Bagger', 'Repression'];
    goldenTest(
      'renders every active phase',
      fileName: 'phase_stepper',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        columns: 1,
        scenarioConstraints: const BoxConstraints(maxWidth: 361),
        children: [
          for (final activeIndex in [null, 0, 1, 2, 3])
            GoldenTestScenario(
              name: 'active $activeIndex',
              child: PhaseStepper(labels: labels, activeIndex: activeIndex),
            ),
        ],
      ),
    );
  });

  group(BoardTabs, () {
    goldenTest(
      'renders selection and badge',
      fileName: 'board_tabs',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        columns: 1,
        scenarioConstraints: const BoxConstraints(maxWidth: 361),
        children: [
          for (final (selectedIndex, badgeCount) in [(0, 0), (1, 3)])
            GoldenTestScenario(
              name: 'selected $selectedIndex, badge $badgeCount',
              child: SizedBox(
                width: 361,
                child: BoardTabs(
                  tabs: [
                    BoardTab(label: 'Wald', badgeCount: badgeCount),
                    const BoardTab(label: 'Aktionen'),
                  ],
                  selectedIndex: selectedIndex,
                  onSelected: (_) {},
                ),
              ),
            ),
        ],
      ),
    );
  });
}
