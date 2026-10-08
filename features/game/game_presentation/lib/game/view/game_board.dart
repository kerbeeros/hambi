import 'package:flutter/material.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game/cubit/cubit.dart';
import 'package:game_presentation/game/view_models/view_models.dart';
import 'package:game_presentation/game/widgets/widgets.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

/// {@template game_board}
/// The board (S-03, ADR 0003): header, fixed status bar, forest and action
/// board, and the primary action of the phase.
///
/// Phones show forest and action board as tabs, tablets side by side
/// (UX-09).
/// {@endtemplate}
class GameBoard extends StatelessWidget {
  /// {@macro game_board}
  const new({
    required this.game,
    required this.tab,
    required this.onTabSelected,
    required this.onCommand,
    required this.onLogPressed,
    required this.onMenuPressed,
    super.key,
  });

  /// The game to show.
  final GameState game;

  /// Section shown on phones.
  final BoardSection tab;

  /// Called when the players switch the section.
  final ValueChanged<BoardSection> onTabSelected;

  /// Called with a move of the players.
  final ValueChanged<GameCommand> onCommand;

  /// Opens the round log.
  final VoidCallback onLogPressed;

  /// Opens the game menu.
  final VoidCallback onMenuPressed;

  /// Minimum width for showing forest and action board side by side.
  static const double tabletWidth = 720;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final phaseLabels = [
      GamePhase.preparation,
      GamePhase.action,
      GamePhase.excavation,
      GamePhase.repression,
    ].map((phase) => phase.label(l10n)).toList();
    final forest = ForestGrid(forest: game.forest, showsDetails: true);
    final actions = ActionBoard(game: game, onCommand: onCommand);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RoundHeader(
          title: game.round == 0
              ? l10n.setupTitle
              : l10n.roundTitle(game.round, GameState.lastRound),
          subtitle: game.phase.label(l10n),
          logTooltip: l10n.logTooltip,
          menuTooltip: l10n.menuTooltip,
          onLogPressed: onLogPressed,
          onMenuPressed: onMenuPressed,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.sm,
          ),
          child: PhaseStepper(
            labels: phaseLabels,
            activeIndex: game.phase.stepIndex,
          ),
        ),
        GameStatusBar(game: game),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) =>
                constraints.maxWidth >= tabletWidth
                ? _TabletLayout(forest: forest, actions: actions)
                : _PhoneLayout(
                    game: game,
                    tab: tab,
                    onTabSelected: onTabSelected,
                    forest: forest,
                    actions: actions,
                  ),
          ),
        ),
        _PrimaryAction(game: game, onCommand: onCommand),
      ],
    );
  }
}

class _PhoneLayout extends StatelessWidget {
  const new({
    required this.game,
    required this.tab,
    required this.onTabSelected,
    required this.forest,
    required this.actions,
  });

  final GameState game;
  final BoardSection tab;
  final ValueChanged<BoardSection> onTabSelected;
  final Widget forest;
  final Widget actions;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: BoardTabs(
            tabs: [
              BoardTab(
                label: l10n.tabForest,
                badgeCount: game.forest.threatenedPositions.length,
              ),
              BoardTab(label: l10n.tabActions),
            ],
            selectedIndex: tab.index,
            onSelected: (index) => onTabSelected(BoardSection.values[index]),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: switch (tab) {
              BoardSection.forest => forest,
              BoardSection.actions => actions,
            },
          ),
        ),
      ],
    );
  }
}

class _TabletLayout extends StatelessWidget {
  const new({required this.forest, required this.actions});

  final Widget forest;
  final Widget actions;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          forest,
          const SizedBox(width: AppSpacing.xl),
          Expanded(child: actions),
        ],
      ),
    );
  }
}

/// The confirming action that ends a phase (UX-01).
class _PrimaryAction extends StatelessWidget {
  const new({required this.game, required this.onCommand});

  final GameState game;
  final ValueChanged<GameCommand> onCommand;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (label, command) = switch (game) {
      GameState(phase: GamePhase.setup, pendingDecision: null) => (
        l10n.startGameAction,
        const Continue(),
      ),
      GameState(phase: GamePhase.preparation) => (
        l10n.endPreparationAction,
        const EndPreparation(),
      ),
      _ => (l10n.continueAction, null),
    };
    return ColoredBox(
      color: AppColors.bgSurface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: HambiButton(
            label: label,
            onPressed: command == null ? null : () => onCommand(command),
          ),
        ),
      ),
    );
  }
}
