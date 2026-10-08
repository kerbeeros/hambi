import 'package:flutter/material.dart';
import 'package:ui_kit/src/icons/icons.dart';
import 'package:ui_kit/src/tokens/tokens.dart';
import 'package:ui_kit/src/widgets/card_symbol_view.dart';

/// Category of an action card, which sets its colors (R-021).
enum ActionCardCategory {
  /// Direct action (green).
  directAction,

  /// Campaign (yellow).
  campaign,

  /// Support (blue).
  support,
}

/// Whether and how an action card can be used in the current round.
enum ActionCardStatus {
  /// Can be assigned.
  available,

  /// Assigned this round.
  assigned,

  /// Blocked by a repression card (R-083).
  blocked,

  /// Its conditions cannot be met (R-042).
  unavailable,
}

/// {@template action_card_view}
/// An action card: title and conditions on the category color, effects on
/// the lighter effect color (R-030–R-041).
/// {@endtemplate}
class ActionCardView extends StatelessWidget {
  /// {@macro action_card_view}
  const new({
    required this.category,
    required this.title,
    required this.conditions,
    required this.effects,
    this.sideLabel,
    this.status = ActionCardStatus.available,
    this.statusLabel,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  /// Category of the card.
  final ActionCardCategory category;

  /// Card title.
  final String title;

  /// Conditions that have to be met to activate the card.
  final List<CardSymbol> conditions;

  /// Effects of the card.
  final List<CardSymbol> effects;

  /// Face-up side, e.g. "B"; `null` hides it.
  final String? sideLabel;

  /// Whether and how the card can be used.
  final ActionCardStatus status;

  /// Short reason shown on the card, e.g. why it cannot be assigned.
  final String? statusLabel;

  /// Description for screen readers.
  final String? semanticLabel;

  /// Called when the card is tapped.
  final VoidCallback? onTap;

  /// Called when the card is long pressed, e.g. to show its details (UX-07).
  final VoidCallback? onLongPress;

  /// Card width in logical pixels.
  static const double width = 113;

  /// Card height in logical pixels.
  static const double height = 96;

  static const double _dimmedOpacity = 0.45;

  static const double _symbolSize = 14;

  @override
  Widget build(BuildContext context) {
    final (conditionColor, effectColor) = switch (category) {
      ActionCardCategory.directAction => (
        AppColors.cardDirectAction,
        AppColors.cardDirectActionEffect,
      ),
      ActionCardCategory.campaign => (
        AppColors.cardCampaign,
        AppColors.cardCampaignEffect,
      ),
      ActionCardCategory.support => (
        AppColors.cardSupport,
        AppColors.cardSupportEffect,
      ),
    };
    final border = switch (status) {
      ActionCardStatus.assigned => const BorderSide(
        color: AppColors.borderDefault,
        width: 3,
      ),
      ActionCardStatus.blocked => const BorderSide(
        color: AppColors.stateBlocked,
        width: 3,
      ),
      _ => const BorderSide(color: AppColors.borderDefault),
    };
    final badge = switch (status) {
      ActionCardStatus.assigned => HambiIconData.check,
      ActionCardStatus.blocked => HambiIconData.lock,
      _ => null,
    };
    final statusLabel = this.statusLabel;
    Widget card = Material(
      color: effectColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: border,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ColoredBox(
                  color: conditionColor,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xs + 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _TitleRow(
                          title: title,
                          sideLabel: sideLabel,
                          badge: badge,
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        _SymbolRow(conditions),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs + 2,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _SymbolRow(effects),
                    ),
                  ),
                ),
              ],
            ),
            if (statusLabel != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _StatusStrip(statusLabel),
              ),
          ],
        ),
      ),
    );
    if (status == ActionCardStatus.unavailable) {
      card = Opacity(opacity: _dimmedOpacity, child: card);
    }
    return Semantics(
      label: semanticLabel,
      button: onTap != null,
      onLongPress: onLongPress,
      excludeSemantics: semanticLabel != null,
      child: SizedBox(width: width, height: height, child: card),
    );
  }
}

class _TitleRow extends StatelessWidget {
  const new({
    required this.title,
    required this.sideLabel,
    required this.badge,
  });

  final String title;
  final String? sideLabel;
  final HambiIconData? badge;

  @override
  Widget build(BuildContext context) {
    final sideLabel = this.sideLabel;
    final badge = this.badge;
    return Row(
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(title, style: AppTextStyle.cardTitle, maxLines: 1),
          ),
        ),
        if (sideLabel != null) ...[
          const SizedBox(width: AppSpacing.xs),
          Text(sideLabel, style: AppTextStyle.caption),
        ],
        if (badge != null) ...[
          const SizedBox(width: AppSpacing.xxs),
          _Badge(badge),
        ],
      ],
    );
  }
}

class _SymbolRow extends StatelessWidget {
  const new(this.symbols);

  final List<CardSymbol> symbols;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xxs,
      runSpacing: AppSpacing.xxs,
      children: [
        for (final symbol in symbols)
          CardSymbolView(symbol, size: ActionCardView._symbolSize),
      ],
    );
  }
}

class _StatusStrip extends StatelessWidget {
  const new(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.bgSurface,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.xxs,
        ),
        child: Text(
          label,
          style: AppTextStyle.caption,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const new(this.icon);

  final HambiIconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.bgSurface,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxs),
        child: HambiIcon(icon, size: 12),
      ),
    );
  }
}
