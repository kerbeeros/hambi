import 'package:flutter/widgets.dart';
import 'package:setup_presentation/l10n/gen/setup_localizations.dart';

export 'package:setup_presentation/l10n/gen/setup_localizations.dart';

/// Access to the setup texts.
extension SetupLocalizationsX on BuildContext {
  /// The setup texts of the current locale.
  SetupLocalizations get l10n => SetupLocalizations.of(this);
}
