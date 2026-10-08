import 'package:flutter/material.dart';
import 'package:hambi_app/app/view/app_placeholder_page.dart';
import 'package:hambi_app/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

class App extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const AppPlaceholderPage(),
    );
  }
}
