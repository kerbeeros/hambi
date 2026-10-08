// goldenTest registers its tests synchronously; the returned Future must not
// be awaited inside a group.
// ignore_for_file: discarded_futures

import 'package:alchemist/alchemist.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(HambiIcon, () {
    goldenTest(
      'renders all icons',
      fileName: 'hambi_icon',
      tags: [TestTag.golden],
      builder: () => GoldenTestGroup(
        columns: 4,
        children: [
          for (final icon in HambiIconData.values)
            GoldenTestScenario(
              name: icon.name,
              child: HambiIcon(icon, size: 40),
            ),
          GoldenTestScenario(
            name: 'menu tinted on dark',
            child: const ColoredBox(
              color: AppColors.bgBoard,
              child: HambiIcon(
                HambiIconData.menu,
                size: 40,
                color: AppColors.textOnDark,
              ),
            ),
          ),
        ],
      ),
    );
  });
}
