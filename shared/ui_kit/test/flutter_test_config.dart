import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import 'helpers/load_package_fonts.dart';
import 'helpers/tolerant_golden_comparator.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Set by the ci and goldens workflows, see ADR 0004.
  const isRunningInCi = bool.fromEnvironment('CI');

  TestWidgetsFlutterBinding.ensureInitialized();
  await loadPackageFonts();

  final comparator = goldenFileComparator;
  if (isRunningInCi && comparator is LocalFileComparator) {
    goldenFileComparator = TolerantGoldenFileComparator(
      comparator.basedir.resolve('flutter_test_config.dart'),
      tolerance: 0.001,
    );
  }

  await AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      theme: AppTheme.light,
      goldenTestTheme: GoldenTestTheme(
        backgroundColor: AppColors.bgApp,
        borderColor: AppColors.borderSubtle,
        nameTextStyle: AppTextStyle.caption,
        padding: const EdgeInsets.all(AppSpacing.sm),
      ),
      // Each platform compares only goldens generated on it: macOS goldens
      // locally, Linux CI goldens (workflow "goldens") in CI.
      platformGoldensConfig: isRunningInCi
          ? const PlatformGoldensConfig(enabled: false)
          : const PlatformGoldensConfig(),
      ciGoldensConfig: const CiGoldensConfig(enabled: isRunningInCi),
    ),
    run: testMain,
  );
}
