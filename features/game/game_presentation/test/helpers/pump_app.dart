import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

extension PumpApp on WidgetTester {
  /// Pumps [widget] inside a German [MaterialApp] with the Hambi theme.
  Future<void> pumpApp(Widget widget, {Size size = const Size(393, 852)}) {
    view
      ..physicalSize = size
      ..devicePixelRatio = 1;
    addTearDown(view.reset);
    return pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        locale: const Locale('de'),
        localizationsDelegates: GameLocalizations.localizationsDelegates,
        supportedLocales: GameLocalizations.supportedLocales,
        home: Scaffold(body: widget),
      ),
    );
  }
}
