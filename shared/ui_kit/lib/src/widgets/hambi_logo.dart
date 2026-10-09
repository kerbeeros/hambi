import 'package:flutter/widgets.dart';

/// {@template hambi_logo}
/// The original "HAMBI BLEIBT!" logo of the board game.
/// {@endtemplate}
class HambiLogo extends StatelessWidget {
  /// {@macro hambi_logo}
  const new({
    required this.semanticLabel,
    this.width = defaultWidth,
    super.key,
  });

  /// Description for screen readers, e.g. the app title.
  final String semanticLabel;

  /// Width in logical pixels; the height follows the logo's aspect ratio.
  final double width;

  /// Width the logo asset is rendered for at 1x.
  static const double defaultWidth = 280;

  static const double _aspectRatio = 394 / 98;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      package: 'ui_kit',
      width: width,
      height: width / _aspectRatio,
      semanticLabel: semanticLabel,
    );
  }
}
