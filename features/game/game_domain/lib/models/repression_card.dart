import 'package:game_domain/models/action_card_id.dart';

/// The repression cards (R-050–R-065).
enum RepressionCard {
  /// Security (R-050).
  security(copies: 3),

  /// Raid (R-051).
  raid,

  /// Night shift (R-052).
  nightShift,

  /// Negative press (R-053).
  negativePress,

  /// Protection by the public (R-054).
  publicProtection,

  /// Legal aid (R-055).
  legalAid,

  /// Censorship of the internet campaign (R-056).
  internetCensorship(flips: ActionCardId.internet),

  /// Censorship of the publicity campaign (R-057).
  publicityCensorship(flips: ActionCardId.publicity),

  /// Observation (R-058).
  observation(flips: ActionCardId.hardwareStore),

  /// Confiscation (R-059).
  confiscation(flips: ActionCardId.ruralCommune),

  /// Threat (R-060).
  threat(flips: ActionCardId.allies),

  /// Ban (R-061).
  ban(flips: ActionCardId.autonomousCentre),

  /// Internet surveillance (R-062).
  internetSurveillance(blocks: ActionCardId.internet),

  /// Assembly ban (R-063).
  assemblyBan(blocks: ActionCardId.demo),

  /// Surveillance (R-064).
  surveillance(blocks: ActionCardId.hardwareStore),

  /// Court order (R-065).
  courtOrder(blocks: ActionCardId.autonomousCentre);

  new({this.copies = 1, this.blocks, this.flips});

  /// Number of copies of this card in the deck.
  final int copies;

  /// Action card blocked while this card is in play (R-062–R-065, Q1).
  final ActionCardId? blocks;

  /// Action card turned to side B by this one-time card (R-056–R-061, Q1).
  final ActionCardId? flips;

  /// How the card is handled after it is drawn.
  RepressionCardType get type => blocks != null
      ? RepressionCardType.blocking
      : flips != null
      ? RepressionCardType.oneTime
      : RepressionCardType.immediate;

  /// All 18 cards of the repression deck in unshuffled order (R-066).
  static List<RepressionCard> get fullDeck => [
    for (final card in values) ...List.filled(card.copies, card),
  ];
}

/// How a repression card is handled after it is drawn (R-050–R-065).
enum RepressionCardType {
  /// Executed at once; stays in play until the next repression phase.
  immediate,

  /// Blocks an action card until the next repression phase.
  blocking,

  /// Executed at once and removed from the game.
  oneTime,
}
