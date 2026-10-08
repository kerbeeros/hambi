import 'package:flutter/material.dart';

/// Visual style of a [HambiButton].
enum HambiButtonStyle {
  /// Main action of a screen, e.g. "Weiter".
  primary,

  /// Secondary action, e.g. "Zurück".
  secondary,
}

/// {@template hambi_button}
/// Button of the Hambi design system.
///
/// Styling comes from the button themes in `AppTheme`. The button is
/// disabled when [onPressed] is `null`.
/// {@endtemplate}
class HambiButton extends StatelessWidget {
  /// {@macro hambi_button}
  const new({
    required this.label,
    required this.onPressed,
    this.style = HambiButtonStyle.primary,
    super.key,
  });

  /// Text shown on the button.
  final String label;

  /// Called when the button is tapped; `null` disables the button.
  final VoidCallback? onPressed;

  /// Visual style of the button.
  final HambiButtonStyle style;

  @override
  Widget build(BuildContext context) {
    return switch (style) {
      HambiButtonStyle.primary => FilledButton(
        onPressed: onPressed,
        child: Text(label),
      ),
      HambiButtonStyle.secondary => OutlinedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    };
  }
}
