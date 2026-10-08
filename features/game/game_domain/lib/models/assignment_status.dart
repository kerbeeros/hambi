/// Whether an action card can be assigned, and why not (R-042, R-043,
/// R-083, UX-02).
enum AssignmentStatus {
  /// The card can be assigned.
  available,

  /// The card is already assigned this round.
  assigned,

  /// The card is blocked by a repression card.
  blocked,

  /// Too few activists in the camp.
  notEnoughActivists,

  /// Too few resources in the camp.
  notEnoughResources,

  /// Support too low.
  notEnoughSupport,

  /// Cards can only be assigned in the preparation phase.
  notInPreparation,
}
