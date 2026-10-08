import 'package:flutter/material.dart';
import 'package:ui_kit/src/tokens/tokens.dart';

/// {@template repression_symbol}
/// Small repression card symbol, used in counters and card effects.
/// {@endtemplate}
class RepressionSymbol extends StatelessWidget {
  /// {@macro repression_symbol}
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 16,
      decoration: BoxDecoration(
        color: AppColors.cardRepression,
        border: Border.all(color: AppColors.trackRepressionField, width: 2),
        borderRadius: BorderRadius.circular(AppRadius.sm / 2),
      ),
    );
  }
}
