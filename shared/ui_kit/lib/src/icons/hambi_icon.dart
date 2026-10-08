import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/src/icons/hambi_icon_data.dart';

/// {@template hambi_icon}
/// Renders a [HambiIconData] (ADR 0007).
/// {@endtemplate}
class HambiIcon extends StatelessWidget {
  /// {@macro hambi_icon}
  const new(
    this.icon, {
    this.size = 24,
    this.color,
    this.semanticLabel,
    super.key,
  });

  /// The icon to render.
  final HambiIconData icon;

  /// Width and height in logical pixels.
  final double size;

  /// Tints the whole icon, e.g. UI icons on dark backgrounds.
  ///
  /// Game symbols keep their original colors and are not tinted.
  final Color? color;

  /// Label for screen readers; `null` hides the icon from semantics.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final color = this.color;
    return SvgPicture.string(
      icon.svg,
      width: size,
      height: size,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(color, BlendMode.srcIn),
      semanticsLabel: semanticLabel,
      excludeFromSemantics: semanticLabel == null,
    );
  }
}
