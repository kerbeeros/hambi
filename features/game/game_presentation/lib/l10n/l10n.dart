import 'package:flutter/widgets.dart';
import 'package:game_presentation/l10n/gen/game_localizations.dart';

export 'package:game_presentation/l10n/gen/game_localizations.dart';

/// Access to the game texts.
extension GameLocalizationsX on BuildContext {
  /// The game texts of the current locale.
  GameLocalizations get l10n => GameLocalizations.of(this);
}
