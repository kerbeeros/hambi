// goldenTest registers its tests synchronously; the returned Future must not
// be awaited inside a group.
// ignore_for_file: discarded_futures

import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(RepressionCardView, () {
    goldenTest(
      'renders all kinds',
      fileName: 'repression_card_view',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        columns: 3,
        children: [
          for (final (kind, title, description) in [
            (
              RepressionCardKind.immediate,
              'Razzia',
              'Die Hälfte der Ressourcen im Camp (aufgerundet) wird entfernt.',
            ),
            (
              RepressionCardKind.blocking,
              'Versammlungsverbot',
              'Die Kampagne Demo ist in der nächsten Runde blockiert.',
            ),
            (
              RepressionCardKind.oneTime,
              'Zensur',
              'Die Kampagne Internet wird auf die B-Seite gedreht.',
            ),
          ]) ...[
            GoldenTestScenario(
              name: kind.name,
              child: RepressionCardView(
                title: title,
                description: description,
                kind: kind,
              ),
            ),
          ],
          for (final (kind, title) in [
            (RepressionCardKind.immediate, 'Razzia'),
            (RepressionCardKind.blocking, 'Versammlungsverbot'),
            (RepressionCardKind.oneTime, 'Zensur'),
          ])
            GoldenTestScenario(
              name: '${kind.name} compact',
              child: RepressionCardView(
                title: title,
                description: '',
                kind: kind,
                compact: true,
              ),
            ),
        ],
      ),
    );
  });
}
