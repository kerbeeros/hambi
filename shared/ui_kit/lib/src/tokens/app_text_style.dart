import 'package:flutter/painting.dart';
import 'package:ui_kit/src/tokens/app_colors.dart';

/// Text styles of the Hambi design system.
///
/// Headings use Special Elite (typewriter, like the original cards),
/// body text and numbers use Nunito.
abstract final class AppTextStyle {
  static const _package = 'ui_kit';

  /// Font family for headings and card titles.
  static const headingFontFamily = 'SpecialElite';

  /// Font family for body text, labels and numbers.
  static const bodyFontFamily = 'Nunito';

  /// 32 / 40
  static const display = TextStyle(
    package: _package,
    fontFamily: headingFontFamily,
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  /// 24 / 32
  static const headingH1 = TextStyle(
    package: _package,
    fontFamily: headingFontFamily,
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  /// 20 / 28
  static const headingH2 = TextStyle(
    package: _package,
    fontFamily: headingFontFamily,
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  /// 13 / 16
  static const cardTitle = TextStyle(
    package: _package,
    fontFamily: headingFontFamily,
    fontSize: 13,
    height: 16 / 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  /// 16 / 24
  static const bodyDefault = TextStyle(
    package: _package,
    fontFamily: bodyFontFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  /// 14 / 20
  static const bodySmall = TextStyle(
    package: _package,
    fontFamily: bodyFontFamily,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  /// 14 / 20, bold.
  static const label = TextStyle(
    package: _package,
    fontFamily: bodyFontFamily,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  /// 12 / 16, semi bold.
  static const caption = TextStyle(
    package: _package,
    fontFamily: bodyFontFamily,
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /// 20 / 24, extra bold.
  static const numberLarge = TextStyle(
    package: _package,
    fontFamily: bodyFontFamily,
    fontSize: 20,
    height: 24 / 20,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  /// 14 / 16, extra bold.
  static const numberSmall = TextStyle(
    package: _package,
    fontFamily: bodyFontFamily,
    fontSize: 14,
    height: 16 / 14,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );
}
