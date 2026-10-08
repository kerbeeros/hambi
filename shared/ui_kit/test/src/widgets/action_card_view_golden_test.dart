// goldenTest registers its tests synchronously; the returned Future must not
// be awaited inside a group.
// ignore_for_file: discarded_futures

import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(ActionCardView, () {
    goldenTest(
      'renders all categories and states',
      fileName: 'action_card_view',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        columns: 4,
        children: [
          for (final (category, title, conditions, effects) in [
            (
              ActionCardCategory.directAction,
              'Blockade',
              [CardSymbol.activist, CardSymbol.resource],
              [CardSymbol.activistToForest],
            ),
            (
              ActionCardCategory.campaign,
              'Demo',
              List.filled(5, CardSymbol.activist) + [CardSymbol.resource],
              [
                CardSymbol.gainSupport,
                CardSymbol.gainSupport,
                CardSymbol.gainActivist,
              ],
            ),
            (
              ActionCardCategory.support,
              'Autonomes Zentrum',
              [CardSymbol.activist, CardSymbol.activist],
              [CardSymbol.gainResource, CardSymbol.gainActivist],
            ),
          ])
            for (final status in ActionCardStatus.values)
              GoldenTestScenario(
                name: '${category.name} ${status.name}',
                child: ActionCardView(
                  category: category,
                  title: title,
                  conditions: conditions,
                  effects: effects,
                  status: status,
                  statusLabel: switch (status) {
                    ActionCardStatus.blocked => 'Blockiert',
                    ActionCardStatus.unavailable => 'Zu wenig M',
                    _ => null,
                  },
                ),
              ),
          GoldenTestScenario(
            name: 'side B',
            child: const ActionCardView(
              category: ActionCardCategory.campaign,
              title: 'Öffentlichkeit',
              sideLabel: 'B',
              conditions: [
                CardSymbol.activist,
                CardSymbol.activist,
                CardSymbol.resource,
              ],
              effects: [CardSymbol.gainSupport, CardSymbol.gainActivist],
            ),
          ),
          GoldenTestScenario(
            name: 'special effects',
            child: const ActionCardView(
              category: ActionCardCategory.directAction,
              title: 'Sabotage',
              conditions: [CardSymbol.activist],
              effects: [CardSymbol.rerollDie, CardSymbol.preventRepression],
            ),
          ),
          GoldenTestScenario(
            name: 'lose support',
            child: const ActionCardView(
              category: ActionCardCategory.directAction,
              title: 'Ziviler Ungehorsam',
              conditions: [CardSymbol.activist, CardSymbol.loseSupport],
              effects: [CardSymbol.activistToForest],
            ),
          ),
        ],
      ),
    );
  });
}
