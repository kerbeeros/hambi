// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'rules_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class RulesLocalizationsDe extends RulesLocalizations {
  RulesLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get rulesTitle => 'Regeln';

  @override
  String get backAction => 'Zurück';

  @override
  String get tabIdea => 'Spielidee';

  @override
  String get tabFlow => 'Ablauf';

  @override
  String get tabSymbols => 'Symbole';

  @override
  String get tabCards => 'Karten';

  @override
  String get ideaBackgroundTitle => 'Der Hambacher Forst';

  @override
  String get ideaBackground => 'Der Hambacher Forst gehörte mit seinem einzigartigen Ökosystem zu den letzten großen Mischwäldern Mitteleuropas. 1978 kaufte der Energiekonzern RWE (damals Rheinbraun) den Wald von den umliegenden Gemeinden. Seitdem wird er gerodet, um Braunkohle abzubauen. Von dem einst 5.500 ha großen Wald ist nur noch ein Zehntel übrig. Doch der Widerstand ist stark! Der Wald ist besetzt, um die weitere Zerstörung zu verhindern. Dieser Widerstand steht nicht nur für Klimagerechtigkeit, sondern auch für eine herrschaftsfreie Welt ohne kapitalistische Zwänge. In diesem Spiel wollen wir den Aufstand für die Klimagerechtigkeit schon mal üben.';

  @override
  String get ideaGoalTitle => 'Gemeinsam für Klimagerechtigkeit!';

  @override
  String get ideaGoal => 'Das Spiel läuft über zwölf Runden. In dieser Zeit versucht ihr gemeinsam, die Zerstörung des Hambacher Forstes zu verhindern.';

  @override
  String get ideaVictory => 'Sieg: Nach Runde 12 ist die öffentliche Unterstützung höher als die Anzahl der Waldkarten, die RWE abgebaggert, also aus dem Spiel entfernt hat.';

  @override
  String get ideaDefeat => 'Niederlage: Ist die Anzahl dieser Karten gleich hoch oder höher, verliert ihr. Hat RWE eine Waldspalte komplett abgebaggert, verliert ihr sofort.';

  @override
  String get flowSetupTitle => 'Spielvorbereitung';

  @override
  String get flowSetup => 'Die Waldkarten liegen mit der grünen Seite nach oben in drei Waldspalten zu je vier Karten. Alle Kampagnen und Support-Karten liegen auf der A-Seite. Ins Camp kommen so viele Mitstreiter*innen, wie es Spieler*innen gibt. Spielst du allein, bekommst du noch zwei Ressourcen, seid ihr zu zweit, bekommt ihr eine Ressource. Vor der ersten Runde zieht ihr so viele Repressionskarten, wie Repressionsfelder erreicht sind, und führt sie aus.';

  @override
  String get flowRound => 'Das Spiel läuft über zwölf Runden. Jede Runde ist in vier Phasen unterteilt.';

  @override
  String get flowPreparationTitle => '1. Vorbereitungsphase';

  @override
  String get flowPreparation => 'Die Uhr rückt eine Stunde vor. Ihr entscheidet gemeinsam, was ihr in dieser Runde machen möchtet: Die Karten stellen mögliche Aktionen dar. Im oberen Bereich stehen die Bedingungen, die ihr erfüllen müsst, um die Aktionen und Vorteile im unteren Bereich zu aktivieren. Nur wenn alle Bedingungen erfüllt sind, wird der Vorteil aktiviert. Blockierte Karten könnt ihr in dieser Runde nicht nutzen.';

  @override
  String get flowActionTitle => '2. Aktionsphase';

  @override
  String get flowAction => 'Ihr führt die Aktionen im unteren Bereich der belegten Karten aus. Die Mitstreiter*innen, die ihr oben auf den Karten eingesetzt habt, kehren danach ins Camp zurück, die Ressourcen verfallen. Alle neu gewonnenen Mitstreiter*innen und Ressourcen kommen ins Camp.';

  @override
  String get flowExcavationTitle => '3. Baggerphase';

  @override
  String get flowExcavation => 'RWE versucht, den Wald zuerst abzuholzen und danach abzubaggern. Zwei Würfel zeigen, welche Waldspalte getroffen wird (1–2: WS1, 3–4: WS2, 5–6: WS3); sie werden nacheinander abgehandelt. Getroffen wird die erste noch nicht entfernte Karte der Spalte. Liegt sie noch auf der Waldseite, wird sie umgedreht; zeigt sie bereits abgeholztes Gebiet, wird sie entfernt. Steht ein Secu auf der Karte, wird er zuerst entfernt. Steht ein*e Mitstreiter*in auf der Karte, bleibt sie unverändert, der*die Mitstreiter*in wird aber aus dem Spiel genommen. Mitstreiter*innen, die danach auf dem Wald stehen, können ins Camp zurückkehren.';

  @override
  String get flowRepressionTitle => '4. Repressionsphase';

  @override
  String get flowRepression => 'Zuerst kommen alle Repressionskarten der vorherigen Runde zurück in den Stapel, der neu gemischt wird. Dann schaut ihr, wie viele Repressionsfelder die Erfolgsleisten erreicht oder überschritten haben. So viele Karten zieht ihr: immer eine nach der anderen, und jede wird ausgeführt, bevor ihr die nächste zieht.';

  @override
  String get symbolsActionCardsTitle => 'Symbole der Aktionskarten';

  @override
  String get symbolsMaterialTitle => 'Spielmaterial';

  @override
  String get symbolActivistPiece => 'Mitstreiter*in: wird für Aktionen eingesetzt oder schützt eine Waldkarte. Die Erfolgsleiste zeigt, wie viele Mitstreiter*innen im Spiel sind.';

  @override
  String get symbolResourcePiece => 'Ressource: Material und Geld, das für Aktionen verbraucht wird.';

  @override
  String get symbolSecuPiece => 'Secu: Security auf einer Waldkarte. Auf diese Karte könnt ihr keine Mitstreiter*innen stellen.';

  @override
  String get symbolSupportPiece => 'Öffentliche Unterstützung: Am Ende muss sie höher sein als die Anzahl entfernter Waldkarten.';

  @override
  String get symbolRepressionField => 'Repressionsfeld: Erreicht eine Erfolgsleiste dieses Feld, zieht ihr in der Repressionsphase eine Karte mehr.';

  @override
  String get symbolOneTime => 'Einmalig: Die Repressionskarte wird nach der Ausführung aus dem Spiel genommen.';

  @override
  String get cardsHint => 'Tippt auf eine Karte, um sie im Detail zu sehen.';

  @override
  String get cardsRepressionTitle => 'Repressionskarten';
}
