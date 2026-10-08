// goldenTest registers its tests synchronously; the returned Future must not
// be awaited inside a group.
// ignore_for_file: discarded_futures

import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(ForestCardView, () {
    goldenTest(
      'renders all states and occupants',
      fileName: 'forest_card_view',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        columns: 4,
        children: [
          for (final state in ForestCardViewState.values) ...[
            for (final occupant in ForestCardOccupant.values)
              if (state != ForestCardViewState.removed ||
                  occupant == ForestCardOccupant.none)
                GoldenTestScenario(
                  name: '${state.name} ${occupant.name}',
                  child: ForestCardView(state: state, occupant: occupant),
                ),
          ],
          GoldenTestScenario(
            name: 'intact target',
            child: const ForestCardView(
              state: ForestCardViewState.intact,
              isTarget: true,
            ),
          ),
          GoldenTestScenario(
            name: 'cleared activist target',
            child: const ForestCardView(
              state: ForestCardViewState.cleared,
              occupant: ForestCardOccupant.activist,
              isTarget: true,
            ),
          ),
        ],
      ),
    );
  });
}
