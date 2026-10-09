import 'package:flutter/material.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game/view_models/view_models.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

/// The card detail (D-08): an enlarged card with explanations (UX-07).
abstract final class CardDetailDialog {
  /// Shows the detail of the action [card] in [game]; without a game, e.g.
  /// in the rules (UX-10), side A without a status.
  static Future<void> showActionCard(
    BuildContext context, {
    required ActionCardId card,
    GameState? game,
  }) => HambiDialog.show<void>(
    context,
    dismissible: true,
    builder: (_) => ActionCardDetail(game: game, card: card),
  );

  /// Shows the detail of the forest [card] at [position].
  static Future<void> showForestCard(
    BuildContext context, {
    required ForestCard card,
    required ForestPosition position,
    required bool isThreatened,
  }) => HambiDialog.show<void>(
    context,
    dismissible: true,
    builder: (_) => ForestCardDetail(
      card: card,
      position: position,
      isThreatened: isThreatened,
    ),
  );

  /// Shows the detail of the repression [card].
  static Future<void> showRepressionCard(
    BuildContext context, {
    required RepressionCard card,
  }) => HambiDialog.show<void>(
    context,
    dismissible: true,
    builder: (_) => RepressionCardDetail(card: card),
  );
}

/// {@template action_card_detail}
/// D-08 for an action card: the card on its current side, its conditions
/// and effects explained and its status (UX-07). Without a [game], side A
/// without a status (UX-10).
/// {@endtemplate}
class ActionCardDetail extends StatelessWidget {
  /// {@macro action_card_detail}
  const new({required this.card, this.game, super.key});

  /// The game the card is part of, if any.
  final GameState? game;

  /// The card to explain.
  final ActionCardId card;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final game = this.game;
    final side = game?.cardSides[card] ?? CardSide.a;
    final status = game?.assignmentStatus(card) ?? AssignmentStatus.available;
    final statusLabel = status == AssignmentStatus.assigned
        ? l10n.statusAssigned
        : status.label(l10n);
    return _CardDetail(
      title: card.title(l10n),
      card: _Enlarged(
        size: const Size(ActionCardView.width, ActionCardView.height),
        child: ActionCardView(
          category: card.category,
          title: card.title(l10n),
          sideLabel: side == CardSide.b ? l10n.cardSideB : null,
          conditions: card.conditions(side),
          effects: card.effects(side),
          status: status.viewStatus,
          statusLabel: status.label(l10n),
        ),
      ),
      children: [
        if (statusLabel != null) Text(statusLabel, style: AppTextStyle.label),
        _SymbolSection(
          title: l10n.detailConditions,
          symbols: card.conditions(side),
        ),
        _SymbolSection(title: l10n.detailEffects, symbols: card.effects(side)),
      ],
    );
  }
}

/// {@template forest_card_detail}
/// D-08 for a forest card: state, piece and threat explained (UX-07).
/// {@endtemplate}
class ForestCardDetail extends StatelessWidget {
  /// {@macro forest_card_detail}
  const new({
    required this.card,
    required this.position,
    required this.isThreatened,
    super.key,
  });

  /// The card to explain.
  final ForestCard card;

  /// Where the card lies in the forest.
  final ForestPosition position;

  /// Whether the next excavator in its column hits the card (R-123).
  final bool isThreatened;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _CardDetail(
      title: ForestCardPresentation.detailTitle(
        l10n,
        column: position.column,
        position: position.position,
      ),
      card: _Enlarged(
        size: const Size(ForestCardView.width, ForestCardView.height),
        child: ForestCardView(
          state: card.viewState,
          occupant: card.occupant,
          isTarget: isThreatened,
        ),
      ),
      children: [
        for (final explanation in card.explanations(
          l10n,
          isThreatened: isThreatened,
        ))
          Text(explanation),
      ],
    );
  }
}

/// {@template repression_card_detail}
/// D-08 for a repression card: the large card and its kind (UX-07).
/// {@endtemplate}
class RepressionCardDetail extends StatelessWidget {
  /// {@macro repression_card_detail}
  const new({required this.card, super.key});

  /// The card to explain.
  final RepressionCard card;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _CardDetail(
      title: card.title(l10n),
      card: RepressionCardView(
        title: card.title(l10n),
        description: card.description(l10n),
        kind: card.kind,
      ),
      children: [Text(card.kindExplanation(l10n))],
    );
  }
}

class _CardDetail extends StatelessWidget {
  const new({required this.title, required this.card, required this.children});

  final String title;
  final Widget card;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return HambiDialog(
      title: title,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: card),
          for (final child in children) ...[
            const SizedBox(height: AppSpacing.md),
            child,
          ],
        ],
      ),
      actions: [
        HambiButton(
          label: context.l10n.closeAction,
          style: HambiButtonStyle.secondary,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

/// Shows a board card of [size] larger, as the detail is meant for reading.
class _Enlarged extends StatelessWidget {
  const new({required this.size, required this.child});

  final Size size;
  final Widget child;

  static const double _scale = 1.6;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * _scale,
      height: size.height * _scale,
      child: FittedBox(child: child),
    );
  }
}

class _SymbolSection extends StatelessWidget {
  const new({required this.title, required this.symbols});

  final String title;
  final List<CardSymbol> symbols;

  @override
  Widget build(BuildContext context) {
    final counts = <CardSymbol, int>{};
    for (final symbol in symbols) {
      counts[symbol] = (counts[symbol] ?? 0) + 1;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.label),
        for (final MapEntry(key: symbol, value: count) in counts.entries)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: _SymbolExplanation(symbol: symbol, count: count),
          ),
      ],
    );
  }
}

class _SymbolExplanation extends StatelessWidget {
  const new({required this.symbol, required this.count});

  final CardSymbol symbol;
  final int count;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (count > 1) ...[
          Text(l10n.detailSymbolCount(count), style: AppTextStyle.label),
          const SizedBox(width: AppSpacing.xxs),
        ],
        CardSymbolView(symbol),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(symbol.explanation(l10n))),
      ],
    );
  }
}
