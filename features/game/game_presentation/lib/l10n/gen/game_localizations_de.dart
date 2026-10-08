// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'game_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class GameLocalizationsDe extends GameLocalizations {
  GameLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String roundTitle(int round, int total) {
    return 'Runde $round/$total';
  }

  @override
  String get setupTitle => 'Spielaufbau';

  @override
  String get phaseSetup => 'Start-Repression';

  @override
  String get phasePreparation => 'Vorbereitung';

  @override
  String get phaseAction => 'Aktion';

  @override
  String get phaseExcavation => 'Bagger';

  @override
  String get phaseRepression => 'Repression';

  @override
  String get phaseFinished => 'Spielende';

  @override
  String get logTooltip => 'Rundenlog';

  @override
  String get menuTooltip => 'Spielmenü';

  @override
  String get tabForest => 'Wald';

  @override
  String get tabActions => 'Aktionen';

  @override
  String campActivistsLabel(int count) {
    return '$count Mitstreiter*innen im Camp';
  }

  @override
  String campResourcesLabel(int count) {
    return '$count Ressourcen im Camp';
  }

  @override
  String upcomingRepressionLabel(int count) {
    return '$count Repressionskarten drohen';
  }

  @override
  String activistTrackLabel(int value) {
    return 'Mitstreiter*innen im Spiel: $value von 11';
  }

  @override
  String supportTrackLabel(int value) {
    return 'Öffentliche Unterstützung: $value von 11';
  }

  @override
  String get campTitle => 'Camp';

  @override
  String get startGameAction => 'Start-Repression ausführen';

  @override
  String get endPreparationAction => 'Vorbereitung beenden';

  @override
  String get continueAction => 'Weiter';

  @override
  String get sectionDirectActions => 'Direkte Aktionen';

  @override
  String get sectionCampaigns => 'Kampagnen';

  @override
  String get sectionSupport => 'Support';

  @override
  String get sectionRepressionInPlay => 'Liegende Repressionskarten';

  @override
  String columnLabel(int column) {
    return 'WS$column';
  }

  @override
  String forestCardLabel(int column, int position, String description) {
    return 'WS$column, Karte $position: $description';
  }

  @override
  String get forestStateIntact => 'Wald';

  @override
  String get forestStateCleared => 'abgeholzt';

  @override
  String get forestStateRemoved => 'entfernt';

  @override
  String get forestOccupantActivist => 'mit Mitstreiter*in';

  @override
  String get forestOccupantSecu => 'mit Secu';

  @override
  String get forestThreatened => 'bedroht';

  @override
  String get cardSideB => 'B';

  @override
  String get cardSabotage => 'Sabotage';

  @override
  String get cardLegalTeam => 'Legal-Team';

  @override
  String get cardCivilDisobedience => 'Ziviler Ungehorsam';

  @override
  String get cardBlockade => 'Blockade';

  @override
  String get cardTreeHouse => 'Baumhaus';

  @override
  String get cardDemo => 'Demo';

  @override
  String get cardPublicity => 'Öffentlichkeit';

  @override
  String get cardInternet => 'Internet';

  @override
  String get cardHardwareStore => 'Baumarkt';

  @override
  String get cardRuralCommune => 'Landkommune';

  @override
  String get cardAutonomousCentre => 'Autonomes Zentrum';

  @override
  String get cardAllies => 'Verbündete';

  @override
  String get statusBlocked => 'Blockiert';

  @override
  String get statusNotEnoughActivists => 'Zu wenig M';

  @override
  String get statusNotEnoughResources => 'Zu wenig R';

  @override
  String get statusNotEnoughSupport => 'Zu wenig U';

  @override
  String get repressionSecurity => 'Security';

  @override
  String get repressionSecurityText => 'Würfeln: Ein Secu kommt auf eine Waldkarte der gewürfelten Spalte. Mitstreiter*innen dort werden aus dem Spiel genommen.';

  @override
  String get repressionRaid => 'Razzia';

  @override
  String get repressionRaidText => 'Die Hälfte der Ressourcen im Camp (aufgerundet) wird entfernt.';

  @override
  String get repressionNightShift => 'Nachtschicht';

  @override
  String get repressionNightShiftText => 'Ein Baggerwürfel wird geworfen und wie in der Baggerphase ausgeführt.';

  @override
  String get repressionNegativePress => 'Negative Presse';

  @override
  String get repressionNegativePressText => 'Ihr verliert 1 Unterstützung oder 1 Mitstreiter*in.';

  @override
  String get repressionPublicProtection => 'Schutz durch die Öffentlichkeit';

  @override
  String get repressionPublicProtectionText => '1 Ressource kommt ins Camp.';

  @override
  String get repressionLegalAid => 'Rechtlicher Beistand';

  @override
  String get repressionLegalAidText => 'Eine Karte auf der B-Seite wird zurück auf die A-Seite gedreht.';

  @override
  String get repressionInternetCensorship => 'Zensur (Internet)';

  @override
  String get repressionInternetCensorshipText => 'Die Kampagne Internet wird auf die B-Seite gedreht.';

  @override
  String get repressionPublicityCensorship => 'Zensur (Öffentlichkeit)';

  @override
  String get repressionPublicityCensorshipText => 'Die Kampagne Öffentlichkeit wird auf die B-Seite gedreht.';

  @override
  String get repressionObservation => 'Observation';

  @override
  String get repressionObservationText => 'Der Support Baumarkt wird auf die B-Seite gedreht.';

  @override
  String get repressionConfiscation => 'Beschlagnahme';

  @override
  String get repressionConfiscationText => 'Der Support Landkommune wird auf die B-Seite gedreht.';

  @override
  String get repressionThreat => 'Drohung';

  @override
  String get repressionThreatText => 'Der Support Verbündete wird auf die B-Seite gedreht.';

  @override
  String get repressionBan => 'Verbot';

  @override
  String get repressionBanText => 'Der Support Autonomes Zentrum wird auf die B-Seite gedreht.';

  @override
  String get repressionInternetSurveillance => 'Internetüberwachung';

  @override
  String get repressionInternetSurveillanceText => 'Die Kampagne Internet ist in der nächsten Runde blockiert.';

  @override
  String get repressionAssemblyBan => 'Versammlungsverbot';

  @override
  String get repressionAssemblyBanText => 'Die Kampagne Demo ist in der nächsten Runde blockiert.';

  @override
  String get repressionSurveillance => 'Überwachung';

  @override
  String get repressionSurveillanceText => 'Der Support Baumarkt ist in der nächsten Runde blockiert.';

  @override
  String get repressionCourtOrder => 'Richterlicher Beschluss';

  @override
  String get repressionCourtOrderText => 'Der Support Autonomes Zentrum ist in der nächsten Runde blockiert.';

  @override
  String logDiceRolled(int first, int second) {
    return 'Bagger würfelt $first und $second';
  }

  @override
  String logDieRerolled(int number, int value) {
    return 'Sabotage: Würfel $number neu geworfen, zeigt $value';
  }

  @override
  String logRepressionCardDrawn(String card) {
    return 'Repressionskarte gezogen: $card';
  }

  @override
  String logRepressionDieRolled(int value) {
    return 'Würfel für Repression: $value';
  }

  @override
  String get logEmpty => 'In dieser Runde ist noch nichts passiert.';

  @override
  String get diceDialogTitle => 'Baggerwürfel';

  @override
  String dieHitsColumn(int value, int column) {
    return '$value trifft WS$column';
  }

  @override
  String get rerollDialogTitle => 'Sabotage';

  @override
  String get rerollDialogBody => 'Ihr dürft genau einen Würfel einmal neu werfen.';

  @override
  String rerollDieAction(int number) {
    return 'Würfel $number neu werfen';
  }

  @override
  String get keepDiceAction => 'Würfel behalten';

  @override
  String get repressionDieTitle => 'Würfel';

  @override
  String get repressionCardDialogTitle => 'Repressionskarte';

  @override
  String get placeActivistTitle => 'Mitstreiter*in in den Wald';

  @override
  String placeActivistBody(int count) {
    return 'Wählt eine Waldkarte ($count übrig).';
  }

  @override
  String get securityTitle => 'Security';

  @override
  String securityBody(int column) {
    return 'Wählt eine Karte in WS$column für den Secu.';
  }

  @override
  String get negativePressBody => 'Was verliert ihr?';

  @override
  String get loseSupportAction => 'Unterstützung −1';

  @override
  String get loseActivistAction => 'Mitstreiter*in −1';

  @override
  String get restoreCardBody => 'Wählt eine Karte, die zurück auf die A-Seite gedreht wird.';

  @override
  String get returnActivistsTitle => 'Zurück ins Camp?';

  @override
  String get returnActivistsBody => 'Wählt die Mitstreiter*innen, die ins Camp zurückkehren. Die anderen bleiben im Wald.';

  @override
  String get returnActivistsAction => 'Auswahl zurückholen';

  @override
  String get keepActivistsAction => 'Alle bleiben im Wald';

  @override
  String get menuExitAction => 'Spiel abbrechen';

  @override
  String get menuCloseAction => 'Zurück zum Spiel';

  @override
  String get exitConfirmTitle => 'Spiel abbrechen?';

  @override
  String get exitConfirmBody => 'Der Spielstand bleibt gespeichert und kann später fortgesetzt werden.';

  @override
  String get exitConfirmAction => 'Spiel abbrechen';

  @override
  String get exitCancelAction => 'Weiterspielen';

  @override
  String get resultVictoryTitle => 'Hambi bleibt!';

  @override
  String get resultVictoryText => 'Ihr habt mehr Unterstützung als entfernte Waldkarten.';

  @override
  String get resultDefeatTitle => 'Der Wald ist verloren';

  @override
  String get resultDefeatColumnText => 'Eine Waldspalte wurde vollständig gerodet.';

  @override
  String get resultDefeatSupportText => 'Die Unterstützung reicht nicht gegen die entfernten Waldkarten.';

  @override
  String get resultSupport => 'Unterstützung';

  @override
  String get resultRemovedCards => 'Entfernte Waldkarten';

  @override
  String get resultRound => 'Erreichte Runde';

  @override
  String get newGameAction => 'Neues Spiel';

  @override
  String get failureNoSavedGame => 'Es gibt kein gespeichertes Spiel.';

  @override
  String get failureLoad => 'Der Spielstand konnte nicht geladen werden.';

  @override
  String get backToStartAction => 'Zum Start';
}
