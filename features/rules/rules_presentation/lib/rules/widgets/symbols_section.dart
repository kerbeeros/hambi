import 'package:flutter/material.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:game_presentation/l10n/l10n.dart' show GameLocalizations;
import 'package:rules_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

/// {@template symbols_section}
/// Legend of the card symbols and game pieces (UX-10).
/// {@endtemplate}
class SymbolsSection extends StatelessWidget {
  /// {@macro symbols_section}
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final gameL10n = GameLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.symbolsActionCardsTitle, style: AppTextStyle.headingH2),
        for (final symbol in CardSymbol.values)
          _LegendRow(
            symbol: CardSymbolView(symbol),
            text: symbol.explanation(gameL10n),
          ),
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.symbolsMaterialTitle, style: AppTextStyle.headingH2),
        _LegendRow(
          symbol: const HambiIcon(HambiIconData.activist),
          text: l10n.symbolActivistPiece,
        ),
        _LegendRow(
          symbol: const HambiIcon(HambiIconData.resource),
          text: l10n.symbolResourcePiece,
        ),
        _LegendRow(
          symbol: const HambiIcon(HambiIconData.secu),
          text: l10n.symbolSecuPiece,
        ),
        _LegendRow(
          symbol: const HambiIcon(HambiIconData.support),
          text: l10n.symbolSupportPiece,
        ),
        _LegendRow(
          symbol: const RepressionSymbol(),
          text: l10n.symbolRepressionField,
        ),
        _LegendRow(
          symbol: const HambiIcon(HambiIconData.oneTime),
          text: l10n.symbolOneTime,
        ),
      ],
    );
  }
}

class _LegendRow extends StatelessWidget {
  const new({required this.symbol, required this.text});

  final Widget symbol;
  final String text;

  static const double _symbolWidth = 64;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: _symbolWidth,
            child: Align(alignment: Alignment.centerLeft, child: symbol),
          ),
          Expanded(child: Text(text, style: AppTextStyle.bodyDefault)),
        ],
      ),
    );
  }
}
