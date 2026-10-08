import 'package:flutter/material.dart';
import 'package:hambi_app/l10n/l10n.dart';

/// Temporary start page until the real start screen (S-01) is built in M3.
class AppPlaceholderPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          context.l10n.appTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
