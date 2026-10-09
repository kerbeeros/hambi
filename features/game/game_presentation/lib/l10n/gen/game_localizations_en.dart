// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'game_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class GameLocalizationsEn extends GameLocalizations {
  GameLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String roundTitle(int round, int total) {
    return 'Round $round/$total';
  }

  @override
  String get setupTitle => 'Setup';

  @override
  String get phaseSetup => 'Initial repression';

  @override
  String get phasePreparation => 'Preparation';

  @override
  String get phaseAction => 'Action';

  @override
  String get phaseExcavation => 'Excavator';

  @override
  String get phaseRepression => 'Repression';

  @override
  String get phaseFinished => 'Game over';

  @override
  String get logTooltip => 'Round log';

  @override
  String get menuTooltip => 'Game menu';

  @override
  String get tabForest => 'Forest';

  @override
  String get tabActions => 'Actions';

  @override
  String campActivistsLabel(int count) {
    return '$count activists in the camp';
  }

  @override
  String campResourcesLabel(int count) {
    return '$count resources in the camp';
  }

  @override
  String upcomingRepressionLabel(int count) {
    return '$count repression cards threaten';
  }

  @override
  String activistTrackLabel(int value) {
    return 'Activists in play: $value of 11';
  }

  @override
  String supportTrackLabel(int value) {
    return 'Public support: $value of 11';
  }

  @override
  String get campTitle => 'Camp';

  @override
  String get startGameAction => 'Run initial repression';

  @override
  String get endPreparationAction => 'End preparation';

  @override
  String get skipAction => 'Skip';

  @override
  String get continueAction => 'Continue';

  @override
  String get sectionDirectActions => 'Direct actions';

  @override
  String get sectionCampaigns => 'Campaigns';

  @override
  String get sectionSupport => 'Support';

  @override
  String get sectionRepressionInPlay => 'Repression cards in play';

  @override
  String columnLabel(int column) {
    return 'FC$column';
  }

  @override
  String forestCardLabel(int column, int position, String description) {
    return 'FC$column, card $position: $description';
  }

  @override
  String get forestStateIntact => 'forest';

  @override
  String get forestStateCleared => 'cleared';

  @override
  String get forestStateRemoved => 'removed';

  @override
  String get forestOccupantActivist => 'with activist';

  @override
  String get forestOccupantSecu => 'with security guard';

  @override
  String get forestThreatened => 'threatened';

  @override
  String get cardSideB => 'B';

  @override
  String get cardSabotage => 'Sabotage';

  @override
  String get cardLegalTeam => 'Legal team';

  @override
  String get cardCivilDisobedience => 'Civil disobedience';

  @override
  String get cardBlockade => 'Blockade';

  @override
  String get cardTreeHouse => 'Tree house';

  @override
  String get cardDemo => 'Demonstration';

  @override
  String get cardPublicity => 'Publicity';

  @override
  String get cardInternet => 'Internet';

  @override
  String get cardHardwareStore => 'Hardware store';

  @override
  String get cardRuralCommune => 'Rural commune';

  @override
  String get cardAutonomousCentre => 'Autonomous centre';

  @override
  String get cardAllies => 'Allies';

  @override
  String get statusBlocked => 'Blocked';

  @override
  String get statusNotEnoughActivists => 'Too few activists';

  @override
  String get statusNotEnoughResources => 'Too few resources';

  @override
  String get statusNotEnoughSupport => 'Too little support';

  @override
  String get repressionSecurity => 'Security';

  @override
  String get repressionSecurityText => 'Roll: a security guard goes onto a forest card of the rolled column. Activists there leave the game.';

  @override
  String get repressionRaid => 'Raid';

  @override
  String get repressionRaidText => 'Half of the resources in the camp (rounded up) are removed.';

  @override
  String get repressionNightShift => 'Night shift';

  @override
  String get repressionNightShiftText => 'One excavator die is rolled and resolved as in the excavator phase.';

  @override
  String get repressionNegativePress => 'Negative press';

  @override
  String get repressionNegativePressText => 'You lose 1 support or 1 activist.';

  @override
  String get repressionPublicProtection => 'Protection by the public';

  @override
  String get repressionPublicProtectionText => '1 resource goes to the camp.';

  @override
  String get repressionLegalAid => 'Legal aid';

  @override
  String get repressionLegalAidText => 'One card on side B is turned back to side A.';

  @override
  String get repressionInternetCensorship => 'Censorship (internet)';

  @override
  String get repressionInternetCensorshipText => 'The internet campaign is turned to side B.';

  @override
  String get repressionPublicityCensorship => 'Censorship (publicity)';

  @override
  String get repressionPublicityCensorshipText => 'The publicity campaign is turned to side B.';

  @override
  String get repressionObservation => 'Observation';

  @override
  String get repressionObservationText => 'The hardware store support is turned to side B.';

  @override
  String get repressionConfiscation => 'Confiscation';

  @override
  String get repressionConfiscationText => 'The rural commune support is turned to side B.';

  @override
  String get repressionThreat => 'Threat';

  @override
  String get repressionThreatText => 'The allies support is turned to side B.';

  @override
  String get repressionBan => 'Ban';

  @override
  String get repressionBanText => 'The autonomous centre support is turned to side B.';

  @override
  String get repressionInternetSurveillance => 'Internet surveillance';

  @override
  String get repressionInternetSurveillanceText => 'The internet campaign is blocked next round.';

  @override
  String get repressionAssemblyBan => 'Assembly ban';

  @override
  String get repressionAssemblyBanText => 'The demonstration campaign is blocked next round.';

  @override
  String get repressionSurveillance => 'Surveillance';

  @override
  String get repressionSurveillanceText => 'The hardware store support is blocked next round.';

  @override
  String get repressionCourtOrder => 'Court order';

  @override
  String get repressionCourtOrderText => 'The autonomous centre support is blocked next round.';

  @override
  String logDiceRolled(int first, int second) {
    return 'Excavator rolls $first and $second';
  }

  @override
  String logDieRerolled(int number, int value) {
    return 'Sabotage: die $number rerolled, shows $value';
  }

  @override
  String logRepressionCardDrawn(String card) {
    return 'Repression card drawn: $card';
  }

  @override
  String logRepressionDieRolled(int value) {
    return 'Die for repression: $value';
  }

  @override
  String get logEmpty => 'Nothing has happened this round yet.';

  @override
  String get diceDialogTitle => 'Excavator dice';

  @override
  String dieHitsColumn(int value, int column) {
    return '$value hits FC$column';
  }

  @override
  String get rerollDialogTitle => 'Sabotage';

  @override
  String get rerollDialogBody => 'You may reroll exactly one die once.';

  @override
  String rerollDieAction(int number) {
    return 'Reroll die $number';
  }

  @override
  String get keepDiceAction => 'Keep dice';

  @override
  String get repressionDieTitle => 'Die';

  @override
  String get repressionCardDialogTitle => 'Repression card';

  @override
  String get placeActivistTitle => 'Activist into the forest';

  @override
  String placeActivistBody(int count) {
    return 'Choose a forest card ($count left).';
  }

  @override
  String get securityTitle => 'Security';

  @override
  String securityBody(int column) {
    return 'Choose a card in FC$column for the security guard.';
  }

  @override
  String get negativePressBody => 'What do you lose?';

  @override
  String get loseSupportAction => 'Support −1';

  @override
  String get loseActivistAction => 'Activist −1';

  @override
  String get restoreCardBody => 'Choose a card to turn back to side A.';

  @override
  String get returnActivistsTitle => 'Back to the camp?';

  @override
  String get returnActivistsBody => 'Choose the activists returning to the camp. The others stay in the forest.';

  @override
  String get returnActivistsAction => 'Bring back selection';

  @override
  String get keepActivistsAction => 'All stay in the forest';

  @override
  String get menuExitAction => 'Leave game';

  @override
  String get menuCloseAction => 'Back to the game';

  @override
  String get exitConfirmTitle => 'Leave the game?';

  @override
  String get exitConfirmBody => 'The game stays saved and can be continued later.';

  @override
  String get exitConfirmAction => 'Leave game';

  @override
  String get exitCancelAction => 'Keep playing';

  @override
  String get resultVictoryTitle => 'Hambi stays!';

  @override
  String get resultVictoryText => 'You have more support than removed forest cards.';

  @override
  String get resultDefeatTitle => 'The forest is lost';

  @override
  String get resultDefeatColumnText => 'A forest column was completely cleared.';

  @override
  String get resultDefeatSupportText => 'Support is not enough against the removed forest cards.';

  @override
  String get resultSupport => 'Support';

  @override
  String get resultRemovedCards => 'Removed forest cards';

  @override
  String get resultRound => 'Round reached';

  @override
  String get newGameAction => 'New game';

  @override
  String get failureNoSavedGame => 'There is no saved game.';

  @override
  String get failureLoad => 'The saved game could not be loaded.';

  @override
  String get backToStartAction => 'Back to start';

  @override
  String get symbolActivist => 'You have to place an activist.';

  @override
  String get symbolResource => 'You have to place a resource.';

  @override
  String get symbolLoseSupport => 'You have to lower public support on the success track by one.';

  @override
  String get symbolGainSupport => 'Raise public support by one space.';

  @override
  String get symbolGainActivist => 'Put a new activist into the camp.';

  @override
  String get symbolGainResource => 'Put a resource into the camp.';

  @override
  String get symbolActivistToForest => 'Put the activist you placed on top of the card onto any forest area.';

  @override
  String get symbolRerollDie => 'In the excavator phase you may reroll one excavator die.';

  @override
  String get symbolPreventRepression => 'In the repression phase, draw one repression card less than you would have to.';

  @override
  String get repressionKindImmediate => 'Immediate: the card is executed at once.';

  @override
  String get repressionKindBlocking => 'Blocking: the card applies until the next repression phase.';

  @override
  String get repressionKindOneTime => 'One-time: the card is removed from the game after it is executed.';

  @override
  String forestDetailTitle(int column, int position) {
    return 'Forest column $column, card $position';
  }

  @override
  String get forestDetailIntact => 'Forest: if the card is hit, it is cleared.';

  @override
  String get forestDetailCleared => 'Cleared: if the card is hit, it is removed.';

  @override
  String get forestDetailRemoved => 'Removed: RWE has excavated this forest area.';

  @override
  String get forestDetailActivist => 'An activist protects the card: if it is hit, it stays unchanged, but the activist is removed from the game.';

  @override
  String get forestDetailSecu => 'A security guard stands on the card: if it is hit, the guard is removed and then the card is cleared or excavated.';

  @override
  String get forestDetailThreatened => 'Threatened: the next excavator in this forest column hits this card.';

  @override
  String get detailConditions => 'Conditions';

  @override
  String get detailEffects => 'Effects';

  @override
  String detailSymbolCount(int count) {
    return '$count ×';
  }

  @override
  String get statusAssigned => 'Assigned';

  @override
  String get closeAction => 'Close';

  @override
  String get menuRulesAction => 'Rules';
}
