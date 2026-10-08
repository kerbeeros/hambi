import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

/// How an [ActionCardId] is shown (R-021, R-030–R-041).
extension ActionCardPresentation on ActionCardId {
  /// Category that sets the card colors.
  ActionCardCategory get category => switch (this) {
    ActionCardId.sabotage ||
    ActionCardId.legalTeam ||
    ActionCardId.civilDisobedience ||
    ActionCardId.blockade ||
    ActionCardId.treeHouse => ActionCardCategory.directAction,
    ActionCardId.demo ||
    ActionCardId.publicity ||
    ActionCardId.internet => ActionCardCategory.campaign,
    ActionCardId.hardwareStore ||
    ActionCardId.ruralCommune ||
    ActionCardId.autonomousCentre ||
    ActionCardId.allies => ActionCardCategory.support,
  };

  /// Card title.
  String title(GameLocalizations l10n) => switch (this) {
    ActionCardId.sabotage => l10n.cardSabotage,
    ActionCardId.legalTeam => l10n.cardLegalTeam,
    ActionCardId.civilDisobedience => l10n.cardCivilDisobedience,
    ActionCardId.blockade => l10n.cardBlockade,
    ActionCardId.treeHouse => l10n.cardTreeHouse,
    ActionCardId.demo => l10n.cardDemo,
    ActionCardId.publicity => l10n.cardPublicity,
    ActionCardId.internet => l10n.cardInternet,
    ActionCardId.hardwareStore => l10n.cardHardwareStore,
    ActionCardId.ruralCommune => l10n.cardRuralCommune,
    ActionCardId.autonomousCentre => l10n.cardAutonomousCentre,
    ActionCardId.allies => l10n.cardAllies,
  };

  /// Condition symbols of [side].
  List<CardSymbol> conditions(CardSide side) {
    final cost = this.cost(side);
    return [
      ...List.filled(cost.activists, CardSymbol.activist),
      ...List.filled(cost.resources, CardSymbol.resource),
      ...List.filled(cost.support, CardSymbol.loseSupport),
    ];
  }

  /// Effect symbols of [side].
  List<CardSymbol> effects(CardSide side) {
    final effect = this.effect(side);
    return [
      if (this == ActionCardId.sabotage) CardSymbol.rerollDie,
      if (this == ActionCardId.legalTeam) CardSymbol.preventRepression,
      if (effect.placesActivistOnForest) CardSymbol.activistToForest,
      ...List.filled(effect.support, CardSymbol.gainSupport),
      ...List.filled(effect.resources, CardSymbol.gainResource),
      ...List.filled(effect.activists, CardSymbol.gainActivist),
    ];
  }
}

/// How an [AssignmentStatus] is shown on an action card (UX-02).
extension AssignmentStatusPresentation on AssignmentStatus {
  /// Visual status of the card.
  ActionCardStatus get viewStatus => switch (this) {
    AssignmentStatus.available ||
    AssignmentStatus.notInPreparation => ActionCardStatus.available,
    AssignmentStatus.assigned => ActionCardStatus.assigned,
    AssignmentStatus.blocked => ActionCardStatus.blocked,
    AssignmentStatus.notEnoughActivists ||
    AssignmentStatus.notEnoughResources ||
    AssignmentStatus.notEnoughSupport => ActionCardStatus.unavailable,
  };

  /// Reason shown on the card, if any.
  String? label(GameLocalizations l10n) => switch (this) {
    AssignmentStatus.available ||
    AssignmentStatus.assigned ||
    AssignmentStatus.notInPreparation => null,
    AssignmentStatus.blocked => l10n.statusBlocked,
    AssignmentStatus.notEnoughActivists => l10n.statusNotEnoughActivists,
    AssignmentStatus.notEnoughResources => l10n.statusNotEnoughResources,
    AssignmentStatus.notEnoughSupport => l10n.statusNotEnoughSupport,
  };
}

/// How a [CardSymbol] is explained in the card detail (UX-07).
extension CardSymbolPresentation on CardSymbol {
  /// Explanation of the symbol, after the symbol legend of the rulebook.
  String explanation(GameLocalizations l10n) => switch (this) {
    CardSymbol.activist => l10n.symbolActivist,
    CardSymbol.resource => l10n.symbolResource,
    CardSymbol.loseSupport => l10n.symbolLoseSupport,
    CardSymbol.gainSupport => l10n.symbolGainSupport,
    CardSymbol.gainActivist => l10n.symbolGainActivist,
    CardSymbol.gainResource => l10n.symbolGainResource,
    CardSymbol.activistToForest => l10n.symbolActivistToForest,
    CardSymbol.rerollDie => l10n.symbolRerollDie,
    CardSymbol.preventRepression => l10n.symbolPreventRepression,
  };
}
