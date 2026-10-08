import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game/cubit/cubit.dart';
import 'package:game_presentation/game/view_models/view_models.dart';
import 'package:game_presentation/game/widgets/forest_grid.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

/// Dialogs for the decisions of the players (D-01–D-05, UX-03).
abstract final class DecisionDialog {
  /// Asks the players for [decision] and returns the chosen move.
  static Future<GameCommand?> show(
    BuildContext context, {
    required GameState game,
    required PendingDecision decision,
  }) => HambiDialog.show<GameCommand>(
    context,
    builder: (_) => switch (decision) {
      PlaceActivistsDecision(:final activists) => _PlaceActivistsDialog(
        forest: game.forest,
        activists: activists,
      ),
      SecurityPlacementDecision(:final column) => _SecurityDialog(
        forest: game.forest,
        column: column,
      ),
      RerollDecision(:final dice) => _RerollDialog(dice: dice),
      NegativePressDecision() => const _NegativePressDialog(),
      RestoreCardDecision() => _RestoreCardDialog(cardSides: game.cardSides),
      ReturnActivistsDecision() => _ReturnActivistsDialog(forest: game.forest),
    },
  );
}

/// D-01: activist of a forest action (R-085).
class _PlaceActivistsDialog extends StatelessWidget {
  const new({required this.forest, required this.activists});

  final Forest forest;
  final int activists;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return HambiDialog(
      title: l10n.placeActivistTitle,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.placeActivistBody(activists)),
          const SizedBox(height: AppSpacing.md),
          _ScaledGrid(
            child: ForestGrid(
              forest: forest,
              showThreats: false,
              isSelectable: (position) => forest
                  .columns[position.column][position.position]
                  .canHoldActivist,
              onCardTap: (position) => Navigator.of(context).pop(
                PlaceActivistOnForest(
                  column: position.column,
                  position: position.position,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// D-01: security guard in the rolled column (R-050, Q14, Q17).
class _SecurityDialog extends StatelessWidget {
  const new({required this.forest, required this.column});

  final Forest forest;
  final int column;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return HambiDialog(
      title: l10n.securityTitle,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.securityBody(column + 1)),
          const SizedBox(height: AppSpacing.md),
          _ScaledGrid(
            child: ForestGrid(
              forest: forest,
              showThreats: false,
              isSelectable: (position) {
                final card = forest.columns[position.column][position.position];
                return position.column == column &&
                    card.state != ForestCardState.removed &&
                    !card.hasSecurity;
              },
              onCardTap: (position) =>
                  Navigator.of(context)
                      .pop(ChooseSecurityCard(position.position)),
            ),
          ),
        ],
      ),
    );
  }
}

/// D-02: sabotage reroll (R-121).
class _RerollDialog extends StatelessWidget {
  const new({required this.dice});

  final List<int> dice;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final navigator = Navigator.of(context);
    return HambiDialog(
      title: l10n.rerollDialogTitle,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.rerollDialogBody),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              for (final die in dice) ...[
                DieView(value: die),
                const SizedBox(width: AppSpacing.md),
              ],
            ],
          ),
        ],
      ),
      actions: [
        for (var index = 0; index < dice.length; index++)
          HambiButton(
            label: l10n.rerollDieAction(index + 1),
            style: HambiButtonStyle.secondary,
            onPressed: () => navigator.pop(RerollDie(index)),
          ),
        HambiButton(
          label: l10n.keepDiceAction,
          onPressed: () => navigator.pop(const Continue()),
        ),
      ],
    );
  }
}

/// D-03: negative press (R-053).
class _NegativePressDialog extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final navigator = Navigator.of(context);
    return HambiDialog(
      title: l10n.repressionNegativePress,
      content: Text(l10n.negativePressBody),
      actions: [
        HambiButton(
          label: l10n.loseSupportAction,
          onPressed: () => navigator.pop(
            const ResolveNegativePress(NegativePressChoice.support),
          ),
        ),
        HambiButton(
          label: l10n.loseActivistAction,
          onPressed: () => navigator.pop(
            const ResolveNegativePress(NegativePressChoice.activist),
          ),
        ),
      ],
    );
  }
}

/// D-04: legal aid (R-055).
class _RestoreCardDialog extends StatelessWidget {
  const new({required this.cardSides});

  final Map<ActionCardId, CardSide> cardSides;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return HambiDialog(
      title: l10n.repressionLegalAid,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.restoreCardBody),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final MapEntry(key: card, value: side) in cardSides.entries)
                if (side == CardSide.b)
                  ActionCardView(
                    category: card.category,
                    title: card.title(l10n),
                    sideLabel: l10n.cardSideB,
                    conditions: card.conditions(side),
                    effects: card.effects(side),
                    onTap: () =>
                        Navigator.of(context).pop(ChooseCardToRestore(card)),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}

/// D-05: activists returning from the forest (R-124).
class _ReturnActivistsDialog extends StatelessWidget {
  const new({required this.forest});

  final Forest forest;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForestSelectionCubit(),
      child: _ReturnActivistsView(forest: forest),
    );
  }
}

class _ReturnActivistsView extends StatelessWidget {
  const new({required this.forest});

  final Forest forest;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selection = context.watch<ForestSelectionCubit>().state;
    final navigator = Navigator.of(context);
    return HambiDialog(
      title: l10n.returnActivistsTitle,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.returnActivistsBody),
          const SizedBox(height: AppSpacing.md),
          _ScaledGrid(
            child: ForestGrid(
              forest: forest,
              showThreats: false,
              selected: selection,
              isSelectable: (position) => forest
                  .columns[position.column][position.position]
                  .hasActivist,
              onCardTap: context.read<ForestSelectionCubit>().toggled,
            ),
          ),
        ],
      ),
      actions: [
        HambiButton(
          label: l10n.returnActivistsAction,
          onPressed: selection.isEmpty
              ? null
              : () => navigator.pop(ReturnActivistsToCamp(selection)),
        ),
        HambiButton(
          label: l10n.keepActivistsAction,
          style: HambiButtonStyle.secondary,
          onPressed: () => navigator.pop(const Continue()),
        ),
      ],
    );
  }
}

/// Shrinks the forest grid to the dialog width on small screens.
class _ScaledGrid extends StatelessWidget {
  const new({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.topLeft,
      child: child,
    );
  }
}
