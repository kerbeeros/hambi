// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'setup_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SetupLocalizationsEn extends SetupLocalizations {
  SetupLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Hambi stays!';

  @override
  String get startSubtitle => 'A cooperative game about the Hambach Forest';

  @override
  String get newGameAction => 'New game';

  @override
  String get resumeGameAction => 'Continue';

  @override
  String get setupTitle => 'New game';

  @override
  String get playerCountLabel => 'Players';

  @override
  String playerCountValue(int count) {
    return '$count players';
  }

  @override
  String get decreasePlayersAction => 'Fewer players';

  @override
  String get increasePlayersAction => 'More players';

  @override
  String startingCampHint(int activists, int resources) {
    return 'You start with $activists activists and $resources resources in the camp.';
  }

  @override
  String get startGameAction => 'Start game';

  @override
  String get backAction => 'Back';

  @override
  String get overwriteTitle => 'Overwrite saved game?';

  @override
  String get overwriteBody => 'There is a game in progress. A new game replaces it.';

  @override
  String get overwriteConfirmAction => 'Start new game';

  @override
  String get overwriteCancelAction => 'Cancel';

  @override
  String get rulesAction => 'Rules';
}
