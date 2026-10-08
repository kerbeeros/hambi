/// The phase the game is in (R-080–R-093).
enum GamePhase {
  /// Board set up, waiting for the initial repression phase (R-113).
  setup,

  /// Players assign activists and resources to action cards (R-080–R-083).
  preparation,

  /// Effects of the activated cards are executed (R-084–R-087).
  action,

  /// The excavator dice are rolled and resolved (R-120–R-124).
  excavation,

  /// Repression cards are drawn and resolved (R-090–R-093).
  repression,

  /// The game is over (R-100, R-101).
  finished,
}
