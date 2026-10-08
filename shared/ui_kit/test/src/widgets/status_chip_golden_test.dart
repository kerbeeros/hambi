// goldenTest registers its tests synchronously; the returned Future must not
// be awaited inside a group.
// ignore_for_file: discarded_futures

import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(StatusChip, () {
    goldenTest(
      'renders all kinds',
      fileName: 'status_chip',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        children: [
          for (final (kind, label) in [
            (StatusChipKind.activist, '5'),
            (StatusChipKind.resource, '2'),
            (StatusChipKind.support, '7'),
            (StatusChipKind.repression, '3'),
          ])
            GoldenTestScenario(
              name: kind.name,
              child: StatusChip(kind: kind, label: label),
            ),
        ],
      ),
    );
  });
}
