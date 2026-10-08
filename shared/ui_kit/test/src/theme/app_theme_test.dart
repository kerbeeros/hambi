import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  group(AppTheme, () {
    group('light', () {
      test('uses the app background as scaffold background', () {
        expect(AppTheme.light.scaffoldBackgroundColor, equals(AppColors.bgApp));
      });

      test('uses the primary action color as color scheme primary', () {
        expect(
          AppTheme.light.colorScheme.primary,
          equals(AppColors.actionPrimary),
        );
      });

      test('uses Nunito for body text', () {
        expect(
          AppTheme.light.textTheme.bodyMedium?.fontFamily,
          contains(AppTextStyle.bodyFontFamily),
        );
      });

      test('uses Special Elite for headlines', () {
        expect(
          AppTheme.light.textTheme.headlineMedium?.fontFamily,
          contains(AppTextStyle.headingFontFamily),
        );
      });
    });
  });
}
