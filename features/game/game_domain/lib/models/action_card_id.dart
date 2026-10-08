import 'package:game_domain/models/action_card_cost.dart';
import 'package:game_domain/models/action_card_effect.dart';

/// The activatable action cards on the action board (R-021, R-030–R-041).
///
/// The camp (R-023) is the thirteenth card but cannot be activated.
enum ActionCardId {
  /// Sabotage (R-030).
  sabotage(costA: ActionCardCost(activists: 1), effectA: ActionCardEffect()),

  /// Legal team (R-031).
  legalTeam(costA: ActionCardCost(activists: 1), effectA: ActionCardEffect()),

  /// Civil disobedience (R-032).
  civilDisobedience(
    costA: ActionCardCost(activists: 1, support: 1),
    effectA: ActionCardEffect(placesActivistOnForest: true),
  ),

  /// Blockade (R-033).
  blockade(
    costA: ActionCardCost(activists: 1, resources: 1),
    effectA: ActionCardEffect(placesActivistOnForest: true),
  ),

  /// Tree house (R-034).
  treeHouse(
    costA: ActionCardCost(activists: 1, resources: 1),
    effectA: ActionCardEffect(placesActivistOnForest: true),
  ),

  /// Demonstration (R-035).
  demo(
    costA: ActionCardCost(activists: 5, resources: 1),
    effectA: ActionCardEffect(support: 2, activists: 1),
  ),

  /// Publicity (R-036).
  publicity(
    costA: ActionCardCost(activists: 1, resources: 1),
    costB: ActionCardCost(activists: 2, resources: 1),
    effectA: ActionCardEffect(support: 1, activists: 1),
    effectB: ActionCardEffect(support: 1, activists: 1),
  ),

  /// Internet (R-037).
  internet(
    costA: ActionCardCost(activists: 1, resources: 1),
    costB: ActionCardCost(activists: 1, resources: 1),
    effectA: ActionCardEffect(support: 1, resources: 1),
    effectB: ActionCardEffect(support: 1),
  ),

  /// Hardware store (R-038).
  hardwareStore(
    costA: ActionCardCost(activists: 1),
    costB: ActionCardCost(activists: 2),
    effectA: ActionCardEffect(resources: 1),
    effectB: ActionCardEffect(resources: 1),
  ),

  /// Rural commune (R-039).
  ruralCommune(
    costA: ActionCardCost(activists: 1),
    costB: ActionCardCost(activists: 2),
    effectA: ActionCardEffect(resources: 1),
    effectB: ActionCardEffect(resources: 1),
  ),

  /// Autonomous centre (R-040).
  autonomousCentre(
    costA: ActionCardCost(activists: 2),
    costB: ActionCardCost(activists: 2),
    effectA: ActionCardEffect(resources: 1, activists: 1),
    effectB: ActionCardEffect(resources: 1),
  ),

  /// Allies (R-041).
  allies(
    costA: ActionCardCost(activists: 1),
    costB: ActionCardCost(activists: 2),
    effectA: ActionCardEffect(activists: 1),
    effectB: ActionCardEffect(activists: 1),
  );

  new({
    required this._costA,
    required this._effectA,
    this._costB,
    this._effectB,
  });

  final ActionCardCost _costA;
  final ActionCardCost? _costB;
  final ActionCardEffect _effectA;
  final ActionCardEffect? _effectB;

  /// Effects of the card when [side] is face up.
  ///
  /// Cards without a B side always use their A side.
  ActionCardEffect effect(CardSide side) =>
      side == CardSide.b ? _effectB ?? _effectA : _effectA;

  /// Conditions of the card when [side] is face up.
  ///
  /// Cards without a B side always use their A side.
  ActionCardCost cost(CardSide side) =>
      side == CardSide.b ? _costB ?? _costA : _costA;
}

/// The side of an action card that is face up (R-022).
enum CardSide {
  /// Regular side.
  a,

  /// Weakened side.
  b,
}
