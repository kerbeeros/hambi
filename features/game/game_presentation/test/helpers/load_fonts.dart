import 'dart:convert';

import 'package:flutter/services.dart';

/// Loads all fonts of the font manifest, including the `ui_kit` fonts
/// registered as `packages/ui_kit/<family>`, so that platform goldens do
/// not fall back to the Ahem test font.
Future<void> loadAppFonts() async {
  final manifest = await rootBundle.loadString('FontManifest.json');
  final families = (json.decode(manifest) as List<dynamic>)
      .cast<Map<String, dynamic>>();
  for (final family in families) {
    final loader = FontLoader(family['family'] as String);
    for (final font
        in (family['fonts'] as List<dynamic>).cast<Map<String, dynamic>>()) {
      loader.addFont(rootBundle.load(font['asset'] as String));
    }
    await loader.load();
  }
}
