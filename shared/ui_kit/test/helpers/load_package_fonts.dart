import 'dart:convert';

import 'package:flutter/services.dart';

/// Loads the fonts declared in this package's `pubspec.yaml` under their
/// `packages/ui_kit/<family>` name.
///
/// Inside its own tests a package's fonts are registered without the
/// package prefix, while `AppTextStyle` references them with
/// `package: 'ui_kit'` (as consumers do). Without this, platform goldens
/// would fall back to the Ahem test font.
Future<void> loadPackageFonts() async {
  final manifest = await rootBundle.loadString('FontManifest.json');
  final families = (json.decode(manifest) as List<dynamic>)
      .cast<Map<String, dynamic>>();

  for (final family in families) {
    final name = family['family'] as String;
    if (name.startsWith('packages/')) continue;

    final loader = FontLoader('packages/ui_kit/$name');
    for (final font
        in (family['fonts'] as List<dynamic>).cast<Map<String, dynamic>>()) {
      loader.addFont(rootBundle.load(font['asset'] as String));
    }
    await loader.load();
  }
}
