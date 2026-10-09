// dart format off
// coverage:ignore-file
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'rules_localizations_de.dart';
import 'rules_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of RulesLocalizations
/// returned by `RulesLocalizations.of(context)`.
///
/// Applications need to include `RulesLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/rules_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: RulesLocalizations.localizationsDelegates,
///   supportedLocales: RulesLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the RulesLocalizations.supportedLocales
/// property.
abstract class RulesLocalizations {
  RulesLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static RulesLocalizations of(BuildContext context) {
    return Localizations.of<RulesLocalizations>(context, RulesLocalizations)!;
  }

  static const LocalizationsDelegate<RulesLocalizations> delegate = _RulesLocalizationsDelegate();

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

  /// Rules
  ///
  /// In de, this message translates to:
  /// **'Regeln'**
  String get rulesTitle;

  /// Back
  ///
  /// In de, this message translates to:
  /// **'Zurück'**
  String get backAction;

  /// Idea
  ///
  /// In de, this message translates to:
  /// **'Spielidee'**
  String get tabIdea;

  /// Flow
  ///
  /// In de, this message translates to:
  /// **'Ablauf'**
  String get tabFlow;

  /// Symbols
  ///
  /// In de, this message translates to:
  /// **'Symbole'**
  String get tabSymbols;

  /// Cards
  ///
  /// In de, this message translates to:
  /// **'Karten'**
  String get tabCards;

  /// The Hambach Forest
  ///
  /// In de, this message translates to:
  /// **'Der Hambacher Forst'**
  String get ideaBackgroundTitle;

  /// With its unique ecosystem, the Hambach Forest was one of the last large mixed forests of Central Europe. In 1978 the energy company RWE (then Rheinbraun) bought the forest from the surrounding municipalities. Since then it has been cleared to mine lignite. Only a tenth of the once 5,500 ha forest is left. But the resistance is strong! The forest is occupied to prevent further destruction. This resistance stands not only for climate justice but also for a world free of domination and capitalist constraints. In this game we practise the uprising for climate justice.
  ///
  /// In de, this message translates to:
  /// **'Der Hambacher Forst gehörte mit seinem einzigartigen Ökosystem zu den letzten großen Mischwäldern Mitteleuropas. 1978 kaufte der Energiekonzern RWE (damals Rheinbraun) den Wald von den umliegenden Gemeinden. Seitdem wird er gerodet, um Braunkohle abzubauen. Von dem einst 5.500 ha großen Wald ist nur noch ein Zehntel übrig. Doch der Widerstand ist stark! Der Wald ist besetzt, um die weitere Zerstörung zu verhindern. Dieser Widerstand steht nicht nur für Klimagerechtigkeit, sondern auch für eine herrschaftsfreie Welt ohne kapitalistische Zwänge. In diesem Spiel wollen wir den Aufstand für die Klimagerechtigkeit schon mal üben.'**
  String get ideaBackground;

  /// Together for climate justice!
  ///
  /// In de, this message translates to:
  /// **'Gemeinsam für Klimagerechtigkeit!'**
  String get ideaGoalTitle;

  /// The game lasts twelve rounds. During this time you try together to prevent the destruction of the Hambach Forest.
  ///
  /// In de, this message translates to:
  /// **'Das Spiel läuft über zwölf Runden. In dieser Zeit versucht ihr gemeinsam, die Zerstörung des Hambacher Forstes zu verhindern.'**
  String get ideaGoal;

  /// Victory: after round 12, public support is higher than the number of forest cards RWE has excavated, that is removed from the game.
  ///
  /// In de, this message translates to:
  /// **'Sieg: Nach Runde 12 ist die öffentliche Unterstützung höher als die Anzahl der Waldkarten, die RWE abgebaggert, also aus dem Spiel entfernt hat.'**
  String get ideaVictory;

  /// Defeat: if the number of these cards is equal or higher, you lose. If RWE has excavated a whole forest column, you lose at once.
  ///
  /// In de, this message translates to:
  /// **'Niederlage: Ist die Anzahl dieser Karten gleich hoch oder höher, verliert ihr. Hat RWE eine Waldspalte komplett abgebaggert, verliert ihr sofort.'**
  String get ideaDefeat;

  /// Setup
  ///
  /// In de, this message translates to:
  /// **'Spielvorbereitung'**
  String get flowSetupTitle;

  /// The forest cards lie green side up in three forest columns of four cards each. All campaign and support cards lie on side A. The camp gets as many activists as there are players. Playing alone, you also get two resources; playing as two, you get one resource. Before the first round you draw and execute as many repression cards as repression fields are reached.
  ///
  /// In de, this message translates to:
  /// **'Die Waldkarten liegen mit der grünen Seite nach oben in drei Waldspalten zu je vier Karten. Alle Kampagnen und Support-Karten liegen auf der A-Seite. Ins Camp kommen so viele Mitstreiter*innen, wie es Spieler*innen gibt. Spielst du allein, bekommst du noch zwei Ressourcen, seid ihr zu zweit, bekommt ihr eine Ressource. Vor der ersten Runde zieht ihr so viele Repressionskarten, wie Repressionsfelder erreicht sind, und führt sie aus.'**
  String get flowSetup;

  /// The game lasts twelve rounds. Each round has four phases.
  ///
  /// In de, this message translates to:
  /// **'Das Spiel läuft über zwölf Runden. Jede Runde ist in vier Phasen unterteilt.'**
  String get flowRound;

  /// 1. Preparation phase
  ///
  /// In de, this message translates to:
  /// **'1. Vorbereitungsphase'**
  String get flowPreparationTitle;

  /// The clock moves on one hour. You decide together what to do this round: the cards show possible actions. The top part shows the conditions you have to meet to activate the actions and benefits in the bottom part. The benefit is only activated when all conditions are met. Blocked cards cannot be used this round.
  ///
  /// In de, this message translates to:
  /// **'Die Uhr rückt eine Stunde vor. Ihr entscheidet gemeinsam, was ihr in dieser Runde machen möchtet: Die Karten stellen mögliche Aktionen dar. Im oberen Bereich stehen die Bedingungen, die ihr erfüllen müsst, um die Aktionen und Vorteile im unteren Bereich zu aktivieren. Nur wenn alle Bedingungen erfüllt sind, wird der Vorteil aktiviert. Blockierte Karten könnt ihr in dieser Runde nicht nutzen.'**
  String get flowPreparation;

  /// 2. Action phase
  ///
  /// In de, this message translates to:
  /// **'2. Aktionsphase'**
  String get flowActionTitle;

  /// You carry out the actions in the bottom part of the assigned cards. The activists you placed on top of the cards return to the camp afterwards, the resources are used up. All newly gained activists and resources go to the camp.
  ///
  /// In de, this message translates to:
  /// **'Ihr führt die Aktionen im unteren Bereich der belegten Karten aus. Die Mitstreiter*innen, die ihr oben auf den Karten eingesetzt habt, kehren danach ins Camp zurück, die Ressourcen verfallen. Alle neu gewonnenen Mitstreiter*innen und Ressourcen kommen ins Camp.'**
  String get flowAction;

  /// 3. Excavator phase
  ///
  /// In de, this message translates to:
  /// **'3. Baggerphase'**
  String get flowExcavationTitle;

  /// RWE tries to clear the forest first and then excavate it. Two dice show which forest column is hit (1–2: FC1, 3–4: FC2, 5–6: FC3); they are handled one after the other. The first card of the column that is not removed yet is hit. If it still shows forest, it is turned over; if it already shows cleared land, it is removed. A security guard on the card is removed first. If an activist stands on the card, it stays unchanged, but the activist is removed from the game. Activists left on the forest can return to the camp.
  ///
  /// In de, this message translates to:
  /// **'RWE versucht, den Wald zuerst abzuholzen und danach abzubaggern. Zwei Würfel zeigen, welche Waldspalte getroffen wird (1–2: WS1, 3–4: WS2, 5–6: WS3); sie werden nacheinander abgehandelt. Getroffen wird die erste noch nicht entfernte Karte der Spalte. Liegt sie noch auf der Waldseite, wird sie umgedreht; zeigt sie bereits abgeholztes Gebiet, wird sie entfernt. Steht ein Secu auf der Karte, wird er zuerst entfernt. Steht ein*e Mitstreiter*in auf der Karte, bleibt sie unverändert, der*die Mitstreiter*in wird aber aus dem Spiel genommen. Mitstreiter*innen, die danach auf dem Wald stehen, können ins Camp zurückkehren.'**
  String get flowExcavation;

  /// 4. Repression phase
  ///
  /// In de, this message translates to:
  /// **'4. Repressionsphase'**
  String get flowRepressionTitle;

  /// First all repression cards of the previous round go back into the deck, which is shuffled. Then you check how many repression fields the success tracks have reached or passed. You draw that many cards, one after the other, and execute each before drawing the next.
  ///
  /// In de, this message translates to:
  /// **'Zuerst kommen alle Repressionskarten der vorherigen Runde zurück in den Stapel, der neu gemischt wird. Dann schaut ihr, wie viele Repressionsfelder die Erfolgsleisten erreicht oder überschritten haben. So viele Karten zieht ihr: immer eine nach der anderen, und jede wird ausgeführt, bevor ihr die nächste zieht.'**
  String get flowRepression;

  /// Symbols of the action cards
  ///
  /// In de, this message translates to:
  /// **'Symbole der Aktionskarten'**
  String get symbolsActionCardsTitle;

  /// Game pieces
  ///
  /// In de, this message translates to:
  /// **'Spielmaterial'**
  String get symbolsMaterialTitle;

  /// Activist: is placed for actions or protects a forest card. The success track shows how many activists are in play.
  ///
  /// In de, this message translates to:
  /// **'Mitstreiter*in: wird für Aktionen eingesetzt oder schützt eine Waldkarte. Die Erfolgsleiste zeigt, wie viele Mitstreiter*innen im Spiel sind.'**
  String get symbolActivistPiece;

  /// Resource: material and money used up by actions.
  ///
  /// In de, this message translates to:
  /// **'Ressource: Material und Geld, das für Aktionen verbraucht wird.'**
  String get symbolResourcePiece;

  /// Security guard on a forest card. You cannot put activists on this card.
  ///
  /// In de, this message translates to:
  /// **'Secu: Security auf einer Waldkarte. Auf diese Karte könnt ihr keine Mitstreiter*innen stellen.'**
  String get symbolSecuPiece;

  /// Public support: at the end it has to be higher than the number of removed forest cards.
  ///
  /// In de, this message translates to:
  /// **'Öffentliche Unterstützung: Am Ende muss sie höher sein als die Anzahl entfernter Waldkarten.'**
  String get symbolSupportPiece;

  /// Repression field: when a success track reaches this field, you draw one more card in the repression phase.
  ///
  /// In de, this message translates to:
  /// **'Repressionsfeld: Erreicht eine Erfolgsleiste dieses Feld, zieht ihr in der Repressionsphase eine Karte mehr.'**
  String get symbolRepressionField;

  /// One-time: the repression card is removed from the game after it is executed.
  ///
  /// In de, this message translates to:
  /// **'Einmalig: Die Repressionskarte wird nach der Ausführung aus dem Spiel genommen.'**
  String get symbolOneTime;

  /// Tap a card to see its details.
  ///
  /// In de, this message translates to:
  /// **'Tippt auf eine Karte, um sie im Detail zu sehen.'**
  String get cardsHint;

  /// Repression cards
  ///
  /// In de, this message translates to:
  /// **'Repressionskarten'**
  String get cardsRepressionTitle;
}

class _RulesLocalizationsDelegate extends LocalizationsDelegate<RulesLocalizations> {
  const _RulesLocalizationsDelegate();

  @override
  Future<RulesLocalizations> load(Locale locale) {
    return SynchronousFuture<RulesLocalizations>(lookupRulesLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_RulesLocalizationsDelegate old) => false;
}

RulesLocalizations lookupRulesLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return RulesLocalizationsDe();
    case 'en': return RulesLocalizationsEn();
  }

  throw FlutterError(
    'RulesLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
