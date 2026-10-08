import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

import 'helpers/load_package_fonts.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // CI only compares platform-independent goldens, see ADR 0004.
  const isRunningInCi = bool.fromEnvironment('CI');

  TestWidgetsFlutterBinding.ensureInitialized();
  await loadPackageFonts();

  await AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      theme: AppTheme.light,
      goldenTestTheme: GoldenTestTheme(
        backgroundColor: AppColors.bgApp,
        borderColor: AppColors.borderSubtle,
        nameTextStyle: AppTextStyle.caption,
        padding: const EdgeInsets.all(AppSpacing.sm),
      ),
      platformGoldensConfig: isRunningInCi
          ? const PlatformGoldensConfig(enabled: false)
          : const PlatformGoldensConfig(),
    ),
    run: testMain,
  );
}
