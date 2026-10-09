import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game/bloc/bloc.dart';
import 'package:game_presentation/game/cubit/cubit.dart';
import 'package:game_presentation/game/dialogs/dialogs.dart';
import 'package:game_presentation/game/view/game_board.dart';
import 'package:game_presentation/game/view/game_result_view.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

/// {@template game_view}
/// The game screen: board, result or failure, plus the dialogs that walk
/// the players through each move (UX-01, UX-03).
///
/// Needs a [GameBloc] and a [BoardTabCubit] above it, see `GameModule`.
/// {@endtemplate}
class GameView extends StatelessWidget {
  /// {@macro game_view}
  const new({
    required this.onExit,
    required this.onNewGame,
    required this.onRules,
    super.key,
  });

  /// Leaves the game screen; a running game stays saved.
  final VoidCallback onExit;

  /// Starts over with a new game.
  final VoidCallback onNewGame;

  /// Opens the rules over the game (UX-10).
  final VoidCallback onRules;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GameBloc, GameViewState>(
          listenWhen: (previous, current) =>
              _phaseOf(current) != null &&
              _phaseOf(previous) != _phaseOf(current),
          listener: (context, state) =>
              context.read<BoardTabCubit>().phaseChanged(_phaseOf(state)!),
        ),
        BlocListener<GameBloc, GameViewState>(
          listenWhen: (previous, current) =>
              current is GameInProgress && previous != current,
          listener: (context, state) =>
              _showNextStep(context, state as GameInProgress),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<GameBloc, GameViewState>(
            builder: (context, state) => switch (state) {
              GameLoading() => const Center(child: CircularProgressIndicator()),
              GameFailure(:final reason) => _FailureView(
                reason: reason,
                onExit: onExit,
              ),
              GameInProgress(:final game) => _RunningGame(
                game: game,
                onExit: onExit,
                onRules: onRules,
              ),
              GameFinished(:final game) => GameResultView(
                game: game,
                onNewGame: onNewGame,
              ),
            },
          ),
        ),
      ),
    );
  }

  static GamePhase? _phaseOf(GameViewState state) => switch (state) {
    GameInProgress(:final game) => game.phase,
    _ => null,
  };

  /// Shows the next unseen log entry, or else asks for the open decision.
  static Future<void> _showNextStep(
    BuildContext context,
    GameInProgress state,
  ) async {
    final bloc = context.read<GameBloc>();
    final decision = state.game.pendingDecision;
    if (state.pendingEntries.isNotEmpty) {
      await LogEntryDialog.show(context, state.pendingEntries.first);
      bloc.add(const GameLogEntryAcknowledged());
    } else if (decision != null) {
      final command = await DecisionDialog.show(
        context,
        game: state.game,
        decision: decision,
      );
      if (command != null) bloc.add(GameCommandSubmitted(command));
    }
  }
}

class _RunningGame extends StatelessWidget {
  const new({required this.game, required this.onExit, required this.onRules});

  final GameState game;
  final VoidCallback onExit;
  final VoidCallback onRules;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GameBloc>();
    final tabCubit = context.watch<BoardTabCubit>();
    return GameBoard(
      game: game,
      tab: tabCubit.state,
      onTabSelected: tabCubit.selected,
      onCommand: (command) => bloc.add(GameCommandSubmitted(command)),
      onLogPressed: () => RoundLogSheet.show(context, game.log),
      onMenuPressed: () async {
        switch (await GameMenuSheet.show(context)) {
          case GameMenuAction.rules:
            onRules();
          case GameMenuAction.exit:
            onExit();
          case null:
            break;
        }
      },
    );
  }
}

class _FailureView extends StatelessWidget {
  const new({required this.reason, required this.onExit});

  final GameFailureReason reason;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              switch (reason) {
                GameFailureReason.noSavedGame => l10n.failureNoSavedGame,
                GameFailureReason.loadFailed => l10n.failureLoad,
              },
              style: AppTextStyle.bodyDefault,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            HambiButton(label: l10n.backToStartAction, onPressed: onExit),
          ],
        ),
      ),
    );
  }
}
