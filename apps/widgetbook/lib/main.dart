import 'package:flutter/material.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:hambi_widgetbook/main.directories.g.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

void main() {
  runApp(const WidgetbookApp());
}

/// Catalog of all Hambi ui_kit widgets and screens, see ADR 0004.
@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  /// Creates the Widgetbook catalog.
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        MaterialThemeAddon(
          themes: [WidgetbookTheme(name: 'Hambi', data: AppTheme.light)],
        ),
        ViewportAddon([
          IosViewports.iPhone13,
          IosViewports.iPadPro11Inches,
          AndroidViewports.samsungGalaxyS20,
          Viewports.none,
        ]),
        LocalizationAddon(
          locales: GameLocalizations.supportedLocales,
          localizationsDelegates: GameLocalizations.localizationsDelegates,
          initialLocale: const Locale('de'),
        ),
        TextScaleAddon(divisions: 4),
        AlignmentAddon(),
      ],
    );
  }
}
