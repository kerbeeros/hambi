// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'setup_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class SetupLocalizationsDe extends SetupLocalizations {
  SetupLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Hambi bleibt!';

  @override
  String get startSubtitle => 'Ein kooperatives Spiel um den Hambacher Forst';

  @override
  String get newGameAction => 'Neues Spiel';

  @override
  String get resumeGameAction => 'Fortsetzen';

  @override
  String get setupTitle => 'Neues Spiel';

  @override
  String get playerCountLabel => 'Spieler*innen';

  @override
  String playerCountValue(int count) {
    return '$count Spieler*innen';
  }

  @override
  String get decreasePlayersAction => 'Weniger Spieler*innen';

  @override
  String get increasePlayersAction => 'Mehr Spieler*innen';

  @override
  String startingCampHint(int activists, int resources) {
    return 'Ihr startet mit $activists Mitstreiter*innen und $resources Ressourcen im Camp.';
  }

  @override
  String get startGameAction => 'Spiel starten';

  @override
  String get backAction => 'Zurück';

  @override
  String get overwriteTitle => 'Spielstand überschreiben?';

  @override
  String get overwriteBody => 'Es gibt eine laufende Partie. Ein neues Spiel ersetzt sie.';

  @override
  String get overwriteConfirmAction => 'Neues Spiel starten';

  @override
  String get overwriteCancelAction => 'Abbrechen';

  @override
  String get rulesAction => 'Regeln';
}
