import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hambi_app/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        locale: const Locale('de'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: widget,
      ),
    );
  }
}
