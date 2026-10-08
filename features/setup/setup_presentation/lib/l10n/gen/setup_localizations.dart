// dart format off
// coverage:ignore-file
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'setup_localizations_de.dart';
import 'setup_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of SetupLocalizations
/// returned by `SetupLocalizations.of(context)`.
///
/// Applications need to include `SetupLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/setup_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: SetupLocalizations.localizationsDelegates,
///   supportedLocales: SetupLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the SetupLocalizations.supportedLocales
/// property.
abstract class SetupLocalizations {
  SetupLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static SetupLocalizations of(BuildContext context) {
    return Localizations.of<SetupLocalizations>(context, SetupLocalizations)!;
  }

  static const LocalizationsDelegate<SetupLocalizations> delegate = _SetupLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// Hambi stays!
  ///
  /// In de, this message translates to:
  /// **'Hambi bleibt!'**
  String get appTitle;

  /// A cooperative game about the Hambach Forest
  ///
  /// In de, this message translates to:
  /// **'Ein kooperatives Spiel um den Hambacher Forst'**
  String get startSubtitle;

  /// New game
  ///
  /// In de, this message translates to:
  /// **'Neues Spiel'**
  String get newGameAction;

  /// Continue
  ///
  /// In de, this message translates to:
  /// **'Fortsetzen'**
  String get resumeGameAction;

  /// New game
  ///
  /// In de, this message translates to:
  /// **'Neues Spiel'**
  String get setupTitle;

  /// Players
  ///
  /// In de, this message translates to:
  /// **'Spieler*innen'**
  String get playerCountLabel;

  /// {count} players
  ///
  /// In de, this message translates to:
  /// **'{count} Spieler*innen'**
  String playerCountValue(int count);

  /// Fewer players
  ///
  /// In de, this message translates to:
  /// **'Weniger Spieler*innen'**
  String get decreasePlayersAction;

  /// More players
  ///
  /// In de, this message translates to:
  /// **'Mehr Spieler*innen'**
  String get increasePlayersAction;

  /// You start with {activists} activists and {resources} resources in the camp.
  ///
  /// In de, this message translates to:
  /// **'Ihr startet mit {activists} Mitstreiter*innen und {resources} Ressourcen im Camp.'**
  String startingCampHint(int activists, int resources);

  /// Start game
  ///
  /// In de, this message translates to:
  /// **'Spiel starten'**
  String get startGameAction;

  /// Back
  ///
  /// In de, this message translates to:
  /// **'Zurück'**
  String get backAction;

  /// Overwrite saved game?
  ///
  /// In de, this message translates to:
  /// **'Spielstand überschreiben?'**
  String get overwriteTitle;

  /// There is a game in progress. A new game replaces it.
  ///
  /// In de, this message translates to:
  /// **'Es gibt eine laufende Partie. Ein neues Spiel ersetzt sie.'**
  String get overwriteBody;

  /// Start new game
  ///
  /// In de, this message translates to:
  /// **'Neues Spiel starten'**
  String get overwriteConfirmAction;

  /// Cancel
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get overwriteCancelAction;
}

class _SetupLocalizationsDelegate extends LocalizationsDelegate<SetupLocalizations> {
  const _SetupLocalizationsDelegate();

  @override
  Future<SetupLocalizations> load(Locale locale) {
    return SynchronousFuture<SetupLocalizations>(lookupSetupLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_SetupLocalizationsDelegate old) => false;
}

SetupLocalizations lookupSetupLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return SetupLocalizationsDe();
    case 'en': return SetupLocalizationsEn();
  }

  throw FlutterError(
    'SetupLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
