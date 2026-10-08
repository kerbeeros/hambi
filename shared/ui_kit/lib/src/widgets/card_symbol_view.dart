import 'package:flutter/material.dart';
import 'package:ui_kit/src/icons/icons.dart';
import 'package:ui_kit/src/tokens/tokens.dart';
import 'package:ui_kit/src/widgets/repression_symbol.dart';

/// Condition and effect symbols of an action card (R-030–R-041).
enum CardSymbol {
  /// Place an activist (○).
  activist,

  /// Place a resource (□).
  resource,

  /// Lower support (−☺).
  loseSupport,

  /// Gain support (+☺).
  gainSupport,

  /// New activist for the camp (+M).
  gainActivist,

  /// New resource for the camp (+R).
  gainResource,

  /// The placed activist moves onto the forest (M→Wald).
  activistToForest,

  /// Reroll an excavator die (Würfel↻).
  rerollDie,

  /// Draw one repression card less (−Repression).
  preventRepression,
}

/// {@template card_symbol_view}
/// Renders a [CardSymbol] with icons and a short sign.
/// {@endtemplate}
class CardSymbolView extends StatelessWidget {
  /// {@macro card_symbol_view}
  const new(this.symbol, {this.size = 18, super.key});

  /// The symbol to render.
  final CardSymbol symbol;

  /// Size of the icons in logical pixels.
  final double size;

  @override
  Widget build(BuildContext context) {
    HambiIcon icon(HambiIconData data) => HambiIcon(data, size: size);
    final activist = icon(HambiIconData.activist);
    final resource = icon(HambiIconData.resource);
    final support = icon(HambiIconData.support);
    final children = switch (symbol) {
      CardSymbol.activist => [activist],
      CardSymbol.resource => [resource],
      CardSymbol.loseSupport => [const _Sign('−'), support],
      CardSymbol.gainSupport => [const _Sign('+'), support],
      CardSymbol.gainActivist => [const _Sign('+'), activist],
      CardSymbol.gainResource => [const _Sign('+'), resource],
      CardSymbol.activistToForest => [
        activist,
        icon(HambiIconData.arrow),
        icon(HambiIconData.fir),
      ],
      CardSymbol.rerollDie => [
        icon(HambiIconData.die),
        icon(HambiIconData.reroll),
      ],
      CardSymbol.preventRepression => [
        const _Sign('−'),
        const RepressionSymbol(),
      ],
    };
    return Row(mainAxisSize: MainAxisSize.min, children: children);
  }
}

class _Sign extends StatelessWidget {
  const new(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
      child: Text(text, style: AppTextStyle.numberSmall),
    );
  }
}
