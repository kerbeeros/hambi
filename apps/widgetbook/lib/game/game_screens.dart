import 'package:flutter/material.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:hambi_widgetbook/game/sample_games.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// The board (S-03) in a selectable phase; use the viewport addon for
/// phone and tablet.
@widgetbook.UseCase(name: 'Board', type: GameBoard)
Widget buildGameBoardUseCase(BuildContext context) {
  final phase = context.knobs.object.dropdown(
    label: 'Phase',
    options: const [GamePhase.setup, GamePhase.preparation],
    labelBuilder: (phase) => phase.name,
  );
  return Scaffold(
    body: SafeArea(
      child: GameBoard(
        game: SampleGames.game(
          phase: phase,
          round: phase == GamePhase.setup ? 0 : 5,
        ),
        tab: context.knobs.object.dropdown(
          label: 'Section',
          options: BoardSection.values,
          initialOption: BoardSection.actions,
          labelBuilder: (section) => section.name,
        ),
        onTabSelected: (_) {},
        onCommand: (_) {},
        onLogPressed: () {},
        onMenuPressed: () {},
      ),
    ),
  );
}

/// The result screen (S-04).
@widgetbook.UseCase(name: 'Result', type: GameResultView)
Widget buildGameResultViewUseCase(BuildContext context) {
  final victory = context.knobs.boolean(label: 'Victory', initialValue: true);
  return Scaffold(
    body: GameResultView(
      game: SampleGames.game(
        phase: GamePhase.finished,
        round: 12,
        support: victory ? 6 : 1,
        outcome: victory ? GameOutcome.victory : GameOutcome.defeat,
      ),
      onNewGame: () {},
    ),
  );
}

/// The decision dialogs (D-01–D-05).
@widgetbook.UseCase(name: 'Decisions', type: DecisionDialog)
Widget buildDecisionDialogUseCase(BuildContext context) {
  return DecisionDialog.dialogFor(
    game: SampleGames.game(),
    decision: context.knobs.object.dropdown<PendingDecision>(
      label: 'Decision',
      options: const [
        PlaceActivistsDecision(activists: 2),
        SecurityPlacementDecision(column: 1),
        RerollDecision([2, 5]),
        NegativePressDecision(),
        RestoreCardDecision(),
        ReturnActivistsDecision(),
      ],
      labelBuilder: (decision) => decision.runtimeType.toString(),
    ),
  );
}

/// The dialogs of dice and repression cards (D-06, D-07).
@widgetbook.UseCase(name: 'Log entries', type: LogEntryDialog)
Widget buildLogEntryDialogUseCase(BuildContext context) {
  return LogEntryDialog.dialogFor(
    context.knobs.object.dropdown<GameLogEntry>(
      label: 'Entry',
      options: const [
        DiceRolled([3, 6]),
        DieRerolled(index: 0, value: 1),
        RepressionDieRolled(5),
        RepressionCardDrawn(RepressionCard.publicityCensorship),
      ],
      labelBuilder: (entry) => entry.runtimeType.toString(),
    ),
  );
}

/// The round log (D-09).
@widgetbook.UseCase(name: 'Round log', type: RoundLogSheet)
Widget buildRoundLogSheetUseCase(BuildContext context) {
  return RoundLogSheet(log: SampleGames.game().log);
}
