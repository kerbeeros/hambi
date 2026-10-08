import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/l10n/l10n.dart';

/// How a [GamePhase] is shown (R-080–R-093).
extension GamePhasePresentation on GamePhase {
  /// Phase name.
  String label(GameLocalizations l10n) => switch (this) {
    GamePhase.setup => l10n.phaseSetup,
    GamePhase.preparation => l10n.phasePreparation,
    GamePhase.action => l10n.phaseAction,
    GamePhase.excavation => l10n.phaseExcavation,
    GamePhase.repression => l10n.phaseRepression,
    GamePhase.finished => l10n.phaseFinished,
  };

  /// Step of the phase stepper; the setup ends with the initial repression
  /// phase (R-113).
  int? get stepIndex => switch (this) {
    GamePhase.preparation => 0,
    GamePhase.action => 1,
    GamePhase.excavation => 2,
    GamePhase.setup || GamePhase.repression => 3,
    GamePhase.finished => null,
  };
}
