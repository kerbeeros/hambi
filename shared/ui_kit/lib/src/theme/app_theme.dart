import 'package:flutter/material.dart';
import 'package:ui_kit/src/tokens/tokens.dart';

/// [ThemeData] of the Hambi app, built from the design tokens.
abstract final class AppTheme {
  static const _buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppRadius.lg)),
  );

  static const _buttonMinimumSize = Size(0, AppSpacing.minTouchTarget);

  static const _buttonPadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.xl,
    vertical: AppSpacing.md,
  );

  /// The light (and only) theme of the app.
  static final ThemeData light = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: AppColors.actionPrimary,
      secondary: AppColors.bgBoard,
      onSecondary: AppColors.textOnDark,
      error: AppColors.stateBlocked,
      onSurface: AppColors.textPrimary,
      outline: AppColors.borderDefault,
      outlineVariant: AppColors.borderSubtle,
    ),
    scaffoldBackgroundColor: AppColors.bgApp,
    textTheme: const TextTheme(
      displayMedium: AppTextStyle.display,
      headlineMedium: AppTextStyle.headingH1,
      titleLarge: AppTextStyle.headingH2,
      titleSmall: AppTextStyle.cardTitle,
      bodyLarge: AppTextStyle.bodyDefault,
      bodyMedium: AppTextStyle.bodySmall,
      labelLarge: AppTextStyle.label,
      bodySmall: AppTextStyle.caption,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.actionPrimary,
        foregroundColor: AppColors.actionOnPrimary,
        disabledBackgroundColor: AppColors.stateDisabled,
        disabledForegroundColor: AppColors.textSecondary,
        minimumSize: _buttonMinimumSize,
        padding: _buttonPadding,
        shape: _buttonShape,
        textStyle: AppTextStyle.label,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.bgSurface,
        foregroundColor: AppColors.textPrimary,
        disabledForegroundColor: AppColors.textSecondary,
        minimumSize: _buttonMinimumSize,
        padding: _buttonPadding,
        shape: _buttonShape,
        side: const BorderSide(color: AppColors.borderDefault, width: 2),
        textStyle: AppTextStyle.label,
      ),
    ),
  );
}
