import 'package:flutter/material.dart';
import 'package:game_presentation/l10n/l10n.dart';

/// Device sizes of the golden tests (spec 5.4).
abstract final class GoldenDevice {
  /// Smartphone in portrait.
  static const phone = Size(393, 852);

  /// Tablet in portrait.
  static const tablet = Size(1024, 1366);
}

/// Provides the German game texts and a screen of [size] for goldens.
class GoldenScreen extends StatelessWidget {
  const new({required this.child, this.size, super.key});

  final Widget child;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    final size = this.size;
    final localized = Localizations(
      locale: const Locale('de'),
      delegates: GameLocalizations.localizationsDelegates,
      child: child,
    );
    if (size == null) return localized;
    return SizedBox.fromSize(
      size: size,
      child: MediaQuery(
        data: MediaQueryData(size: size),
        child: Scaffold(body: localized),
      ),
    );
  }
}
