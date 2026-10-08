// dart format off
// coverage:ignore-file
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'game_localizations_de.dart';
import 'game_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of GameLocalizations
/// returned by `GameLocalizations.of(context)`.
///
/// Applications need to include `GameLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/game_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: GameLocalizations.localizationsDelegates,
///   supportedLocales: GameLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the GameLocalizations.supportedLocales
/// property.
abstract class GameLocalizations {
  GameLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static GameLocalizations of(BuildContext context) {
    return Localizations.of<GameLocalizations>(context, GameLocalizations)!;
  }

  static const LocalizationsDelegate<GameLocalizations> delegate = _GameLocalizationsDelegate();

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

  /// Round {round}/{total}
  ///
  /// In de, this message translates to:
  /// **'Runde {round}/{total}'**
  String roundTitle(int round, int total);

  /// Setup
  ///
  /// In de, this message translates to:
  /// **'Spielaufbau'**
  String get setupTitle;

  /// Initial repression
  ///
  /// In de, this message translates to:
  /// **'Start-Repression'**
  String get phaseSetup;

  /// Preparation
  ///
  /// In de, this message translates to:
  /// **'Vorbereitung'**
  String get phasePreparation;

  /// Action
  ///
  /// In de, this message translates to:
  /// **'Aktion'**
  String get phaseAction;

  /// Excavator
  ///
  /// In de, this message translates to:
  /// **'Bagger'**
  String get phaseExcavation;

  /// Repression
  ///
  /// In de, this message translates to:
  /// **'Repression'**
  String get phaseRepression;

  /// Game over
  ///
  /// In de, this message translates to:
  /// **'Spielende'**
  String get phaseFinished;

  /// Round log
  ///
  /// In de, this message translates to:
  /// **'Rundenlog'**
  String get logTooltip;

  /// Game menu
  ///
  /// In de, this message translates to:
  /// **'Spielmenü'**
  String get menuTooltip;

  /// Forest
  ///
  /// In de, this message translates to:
  /// **'Wald'**
  String get tabForest;

  /// Actions
  ///
  /// In de, this message translates to:
  /// **'Aktionen'**
  String get tabActions;

  /// {count} activists in the camp
  ///
  /// In de, this message translates to:
  /// **'{count} Mitstreiter*innen im Camp'**
  String campActivistsLabel(int count);

  /// {count} resources in the camp
  ///
  /// In de, this message translates to:
  /// **'{count} Ressourcen im Camp'**
  String campResourcesLabel(int count);

  /// {count} repression cards threaten
  ///
  /// In de, this message translates to:
  /// **'{count} Repressionskarten drohen'**
  String upcomingRepressionLabel(int count);

  /// Activists in play: {value} of 11
  ///
  /// In de, this message translates to:
  /// **'Mitstreiter*innen im Spiel: {value} von 11'**
  String activistTrackLabel(int value);

  /// Public support: {value} of 11
  ///
  /// In de, this message translates to:
  /// **'Öffentliche Unterstützung: {value} von 11'**
  String supportTrackLabel(int value);

  /// Camp
  ///
  /// In de, this message translates to:
  /// **'Camp'**
  String get campTitle;

  /// Run initial repression
  ///
  /// In de, this message translates to:
  /// **'Start-Repression ausführen'**
  String get startGameAction;

  /// End preparation
  ///
  /// In de, this message translates to:
  /// **'Vorbereitung beenden'**
  String get endPreparationAction;

  /// Continue
  ///
  /// In de, this message translates to:
  /// **'Weiter'**
  String get continueAction;

  /// Direct actions
  ///
  /// In de, this message translates to:
  /// **'Direkte Aktionen'**
  String get sectionDirectActions;

  /// Campaigns
  ///
  /// In de, this message translates to:
  /// **'Kampagnen'**
  String get sectionCampaigns;

  /// Support
  ///
  /// In de, this message translates to:
  /// **'Support'**
  String get sectionSupport;

  /// Repression cards in play
  ///
  /// In de, this message translates to:
  /// **'Liegende Repressionskarten'**
  String get sectionRepressionInPlay;

  /// FC{column}
  ///
  /// In de, this message translates to:
  /// **'WS{column}'**
  String columnLabel(int column);

  /// FC{column}, card {position}: {description}
  ///
  /// In de, this message translates to:
  /// **'WS{column}, Karte {position}: {description}'**
  String forestCardLabel(int column, int position, String description);

  /// forest
  ///
  /// In de, this message translates to:
  /// **'Wald'**
  String get forestStateIntact;

  /// cleared
  ///
  /// In de, this message translates to:
  /// **'abgeholzt'**
  String get forestStateCleared;

  /// removed
  ///
  /// In de, this message translates to:
  /// **'entfernt'**
  String get forestStateRemoved;

  /// with activist
  ///
  /// In de, this message translates to:
  /// **'mit Mitstreiter*in'**
  String get forestOccupantActivist;

  /// with security guard
  ///
  /// In de, this message translates to:
  /// **'mit Secu'**
  String get forestOccupantSecu;

  /// threatened
  ///
  /// In de, this message translates to:
  /// **'bedroht'**
  String get forestThreatened;

  /// B
  ///
  /// In de, this message translates to:
  /// **'B'**
  String get cardSideB;

  /// Sabotage
  ///
  /// In de, this message translates to:
  /// **'Sabotage'**
  String get cardSabotage;

  /// Legal team
  ///
  /// In de, this message translates to:
  /// **'Legal-Team'**
  String get cardLegalTeam;

  /// Civil disobedience
  ///
  /// In de, this message translates to:
  /// **'Ziviler Ungehorsam'**
  String get cardCivilDisobedience;

  /// Blockade
  ///
  /// In de, this message translates to:
  /// **'Blockade'**
  String get cardBlockade;

  /// Tree house
  ///
  /// In de, this message translates to:
  /// **'Baumhaus'**
  String get cardTreeHouse;

  /// Demonstration
  ///
  /// In de, this message translates to:
  /// **'Demo'**
  String get cardDemo;

  /// Publicity
  ///
  /// In de, this message translates to:
  /// **'Öffentlichkeit'**
  String get cardPublicity;

  /// Internet
  ///
  /// In de, this message translates to:
  /// **'Internet'**
  String get cardInternet;

  /// Hardware store
  ///
  /// In de, this message translates to:
  /// **'Baumarkt'**
  String get cardHardwareStore;

  /// Rural commune
  ///
  /// In de, this message translates to:
  /// **'Landkommune'**
  String get cardRuralCommune;

  /// Autonomous centre
  ///
  /// In de, this message translates to:
  /// **'Autonomes Zentrum'**
  String get cardAutonomousCentre;

  /// Allies
  ///
  /// In de, this message translates to:
  /// **'Verbündete'**
  String get cardAllies;

  /// Blocked
  ///
  /// In de, this message translates to:
  /// **'Blockiert'**
  String get statusBlocked;

  /// Too few activists
  ///
  /// In de, this message translates to:
  /// **'Zu wenig M'**
  String get statusNotEnoughActivists;

  /// Too few resources
  ///
  /// In de, this message translates to:
  /// **'Zu wenig R'**
  String get statusNotEnoughResources;

  /// Too little support
  ///
  /// In de, this message translates to:
  /// **'Zu wenig U'**
  String get statusNotEnoughSupport;

  /// Security
  ///
  /// In de, this message translates to:
  /// **'Security'**
  String get repressionSecurity;

  /// Roll: a security guard goes onto a forest card of the rolled column. Activists there leave the game.
  ///
  /// In de, this message translates to:
  /// **'Würfeln: Ein Secu kommt auf eine Waldkarte der gewürfelten Spalte. Mitstreiter*innen dort werden aus dem Spiel genommen.'**
  String get repressionSecurityText;

  /// Raid
  ///
  /// In de, this message translates to:
  /// **'Razzia'**
  String get repressionRaid;

  /// Half of the resources in the camp (rounded up) are removed.
  ///
  /// In de, this message translates to:
  /// **'Die Hälfte der Ressourcen im Camp (aufgerundet) wird entfernt.'**
  String get repressionRaidText;

  /// Night shift
  ///
  /// In de, this message translates to:
  /// **'Nachtschicht'**
  String get repressionNightShift;

  /// One excavator die is rolled and resolved as in the excavator phase.
  ///
  /// In de, this message translates to:
  /// **'Ein Baggerwürfel wird geworfen und wie in der Baggerphase ausgeführt.'**
  String get repressionNightShiftText;

  /// Negative press
  ///
  /// In de, this message translates to:
  /// **'Negative Presse'**
  String get repressionNegativePress;

  /// You lose 1 support or 1 activist.
  ///
  /// In de, this message translates to:
  /// **'Ihr verliert 1 Unterstützung oder 1 Mitstreiter*in.'**
  String get repressionNegativePressText;

  /// Protection by the public
  ///
  /// In de, this message translates to:
  /// **'Schutz durch die Öffentlichkeit'**
  String get repressionPublicProtection;

  /// 1 resource goes to the camp.
  ///
  /// In de, this message translates to:
  /// **'1 Ressource kommt ins Camp.'**
  String get repressionPublicProtectionText;

  /// Legal aid
  ///
  /// In de, this message translates to:
  /// **'Rechtlicher Beistand'**
  String get repressionLegalAid;

  /// One card on side B is turned back to side A.
  ///
  /// In de, this message translates to:
  /// **'Eine Karte auf der B-Seite wird zurück auf die A-Seite gedreht.'**
  String get repressionLegalAidText;

  /// Censorship (internet)
  ///
  /// In de, this message translates to:
  /// **'Zensur (Internet)'**
  String get repressionInternetCensorship;

  /// The internet campaign is turned to side B.
  ///
  /// In de, this message translates to:
  /// **'Die Kampagne Internet wird auf die B-Seite gedreht.'**
  String get repressionInternetCensorshipText;

  /// Censorship (publicity)
  ///
  /// In de, this message translates to:
  /// **'Zensur (Öffentlichkeit)'**
  String get repressionPublicityCensorship;

  /// The publicity campaign is turned to side B.
  ///
  /// In de, this message translates to:
  /// **'Die Kampagne Öffentlichkeit wird auf die B-Seite gedreht.'**
  String get repressionPublicityCensorshipText;

  /// Observation
  ///
  /// In de, this message translates to:
  /// **'Observation'**
  String get repressionObservation;

  /// The hardware store support is turned to side B.
  ///
  /// In de, this message translates to:
  /// **'Der Support Baumarkt wird auf die B-Seite gedreht.'**
  String get repressionObservationText;

  /// Confiscation
  ///
  /// In de, this message translates to:
  /// **'Beschlagnahme'**
  String get repressionConfiscation;

  /// The rural commune support is turned to side B.
  ///
  /// In de, this message translates to:
  /// **'Der Support Landkommune wird auf die B-Seite gedreht.'**
  String get repressionConfiscationText;

  /// Threat
  ///
  /// In de, this message translates to:
  /// **'Drohung'**
  String get repressionThreat;

  /// The allies support is turned to side B.
  ///
  /// In de, this message translates to:
  /// **'Der Support Verbündete wird auf die B-Seite gedreht.'**
  String get repressionThreatText;

  /// Ban
  ///
  /// In de, this message translates to:
  /// **'Verbot'**
  String get repressionBan;

  /// The autonomous centre support is turned to side B.
  ///
  /// In de, this message translates to:
  /// **'Der Support Autonomes Zentrum wird auf die B-Seite gedreht.'**
  String get repressionBanText;

  /// Internet surveillance
  ///
  /// In de, this message translates to:
  /// **'Internetüberwachung'**
  String get repressionInternetSurveillance;

  /// The internet campaign is blocked next round.
  ///
  /// In de, this message translates to:
  /// **'Die Kampagne Internet ist in der nächsten Runde blockiert.'**
  String get repressionInternetSurveillanceText;

  /// Assembly ban
  ///
  /// In de, this message translates to:
  /// **'Versammlungsverbot'**
  String get repressionAssemblyBan;

  /// The demonstration campaign is blocked next round.
  ///
  /// In de, this message translates to:
  /// **'Die Kampagne Demo ist in der nächsten Runde blockiert.'**
  String get repressionAssemblyBanText;

  /// Surveillance
  ///
  /// In de, this message translates to:
  /// **'Überwachung'**
  String get repressionSurveillance;

  /// The hardware store support is blocked next round.
  ///
  /// In de, this message translates to:
  /// **'Der Support Baumarkt ist in der nächsten Runde blockiert.'**
  String get repressionSurveillanceText;

  /// Court order
  ///
  /// In de, this message translates to:
  /// **'Richterlicher Beschluss'**
  String get repressionCourtOrder;

  /// The autonomous centre support is blocked next round.
  ///
  /// In de, this message translates to:
  /// **'Der Support Autonomes Zentrum ist in der nächsten Runde blockiert.'**
  String get repressionCourtOrderText;

  /// Excavator rolls {first} and {second}
  ///
  /// In de, this message translates to:
  /// **'Bagger würfelt {first} und {second}'**
  String logDiceRolled(int first, int second);

  /// Sabotage: die {number} rerolled, shows {value}
  ///
  /// In de, this message translates to:
  /// **'Sabotage: Würfel {number} neu geworfen, zeigt {value}'**
  String logDieRerolled(int number, int value);

  /// Repression card drawn: {card}
  ///
  /// In de, this message translates to:
  /// **'Repressionskarte gezogen: {card}'**
  String logRepressionCardDrawn(String card);

  /// Die for repression: {value}
  ///
  /// In de, this message translates to:
  /// **'Würfel für Repression: {value}'**
  String logRepressionDieRolled(int value);

  /// Nothing has happened this round yet.
  ///
  /// In de, this message translates to:
  /// **'In dieser Runde ist noch nichts passiert.'**
  String get logEmpty;

  /// Excavator dice
  ///
  /// In de, this message translates to:
  /// **'Baggerwürfel'**
  String get diceDialogTitle;

  /// {value} hits FC{column}
  ///
  /// In de, this message translates to:
  /// **'{value} trifft WS{column}'**
  String dieHitsColumn(int value, int column);

  /// Sabotage
  ///
  /// In de, this message translates to:
  /// **'Sabotage'**
  String get rerollDialogTitle;

  /// You may reroll exactly one die once.
  ///
  /// In de, this message translates to:
  /// **'Ihr dürft genau einen Würfel einmal neu werfen.'**
  String get rerollDialogBody;

  /// Reroll die {number}
  ///
  /// In de, this message translates to:
  /// **'Würfel {number} neu werfen'**
  String rerollDieAction(int number);

  /// Keep dice
  ///
  /// In de, this message translates to:
  /// **'Würfel behalten'**
  String get keepDiceAction;

  /// Die
  ///
  /// In de, this message translates to:
  /// **'Würfel'**
  String get repressionDieTitle;

  /// Repression card
  ///
  /// In de, this message translates to:
  /// **'Repressionskarte'**
  String get repressionCardDialogTitle;

  /// Activist into the forest
  ///
  /// In de, this message translates to:
  /// **'Mitstreiter*in in den Wald'**
  String get placeActivistTitle;

  /// Choose a forest card ({count} left).
  ///
  /// In de, this message translates to:
  /// **'Wählt eine Waldkarte ({count} übrig).'**
  String placeActivistBody(int count);

  /// Security
  ///
  /// In de, this message translates to:
  /// **'Security'**
  String get securityTitle;

  /// Choose a card in FC{column} for the security guard.
  ///
  /// In de, this message translates to:
  /// **'Wählt eine Karte in WS{column} für den Secu.'**
  String securityBody(int column);

  /// What do you lose?
  ///
  /// In de, this message translates to:
  /// **'Was verliert ihr?'**
  String get negativePressBody;

  /// Support −1
  ///
  /// In de, this message translates to:
  /// **'Unterstützung −1'**
  String get loseSupportAction;

  /// Activist −1
  ///
  /// In de, this message translates to:
  /// **'Mitstreiter*in −1'**
  String get loseActivistAction;

  /// Choose a card to turn back to side A.
  ///
  /// In de, this message translates to:
  /// **'Wählt eine Karte, die zurück auf die A-Seite gedreht wird.'**
  String get restoreCardBody;

  /// Back to the camp?
  ///
  /// In de, this message translates to:
  /// **'Zurück ins Camp?'**
  String get returnActivistsTitle;

  /// Choose the activists returning to the camp. The others stay in the forest.
  ///
  /// In de, this message translates to:
  /// **'Wählt die Mitstreiter*innen, die ins Camp zurückkehren. Die anderen bleiben im Wald.'**
  String get returnActivistsBody;

  /// Bring back selection
  ///
  /// In de, this message translates to:
  /// **'Auswahl zurückholen'**
  String get returnActivistsAction;

  /// All stay in the forest
  ///
  /// In de, this message translates to:
  /// **'Alle bleiben im Wald'**
  String get keepActivistsAction;

  /// Leave game
  ///
  /// In de, this message translates to:
  /// **'Spiel abbrechen'**
  String get menuExitAction;

  /// Back to the game
  ///
  /// In de, this message translates to:
  /// **'Zurück zum Spiel'**
  String get menuCloseAction;

  /// Leave the game?
  ///
  /// In de, this message translates to:
  /// **'Spiel abbrechen?'**
  String get exitConfirmTitle;

  /// The game stays saved and can be continued later.
  ///
  /// In de, this message translates to:
  /// **'Der Spielstand bleibt gespeichert und kann später fortgesetzt werden.'**
  String get exitConfirmBody;

  /// Leave game
  ///
  /// In de, this message translates to:
  /// **'Spiel abbrechen'**
  String get exitConfirmAction;

  /// Keep playing
  ///
  /// In de, this message translates to:
  /// **'Weiterspielen'**
  String get exitCancelAction;

  /// Hambi stays!
  ///
  /// In de, this message translates to:
  /// **'Hambi bleibt!'**
  String get resultVictoryTitle;

  /// You have more support than removed forest cards.
  ///
  /// In de, this message translates to:
  /// **'Ihr habt mehr Unterstützung als entfernte Waldkarten.'**
  String get resultVictoryText;

  /// The forest is lost
  ///
  /// In de, this message translates to:
  /// **'Der Wald ist verloren'**
  String get resultDefeatTitle;

  /// A forest column was completely cleared.
  ///
  /// In de, this message translates to:
  /// **'Eine Waldspalte wurde vollständig gerodet.'**
  String get resultDefeatColumnText;

  /// Support is not enough against the removed forest cards.
  ///
  /// In de, this message translates to:
  /// **'Die Unterstützung reicht nicht gegen die entfernten Waldkarten.'**
  String get resultDefeatSupportText;

  /// Support
  ///
  /// In de, this message translates to:
  /// **'Unterstützung'**
  String get resultSupport;

  /// Removed forest cards
  ///
  /// In de, this message translates to:
  /// **'Entfernte Waldkarten'**
  String get resultRemovedCards;

  /// Round reached
  ///
  /// In de, this message translates to:
  /// **'Erreichte Runde'**
  String get resultRound;

  /// New game
  ///
  /// In de, this message translates to:
  /// **'Neues Spiel'**
  String get newGameAction;

  /// There is no saved game.
  ///
  /// In de, this message translates to:
  /// **'Es gibt kein gespeichertes Spiel.'**
  String get failureNoSavedGame;

  /// The saved game could not be loaded.
  ///
  /// In de, this message translates to:
  /// **'Der Spielstand konnte nicht geladen werden.'**
  String get failureLoad;

  /// Back to start
  ///
  /// In de, this message translates to:
  /// **'Zum Start'**
  String get backToStartAction;
}

class _GameLocalizationsDelegate extends LocalizationsDelegate<GameLocalizations> {
  const _GameLocalizationsDelegate();

  @override
  Future<GameLocalizations> load(Locale locale) {
    return SynchronousFuture<GameLocalizations>(lookupGameLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_GameLocalizationsDelegate old) => false;
}

GameLocalizations lookupGameLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return GameLocalizationsDe();
    case 'en': return GameLocalizationsEn();
  }

  throw FlutterError(
    'GameLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
