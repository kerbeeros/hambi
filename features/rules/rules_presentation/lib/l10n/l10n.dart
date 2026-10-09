import 'package:flutter/widgets.dart';
import 'package:rules_presentation/l10n/gen/rules_localizations.dart';

export 'package:rules_presentation/l10n/gen/rules_localizations.dart';

/// Access to the rules texts.
extension RulesLocalizationsX on BuildContext {
  /// The rules texts of the current locale.
  RulesLocalizations get l10n => RulesLocalizations.of(this);
}
