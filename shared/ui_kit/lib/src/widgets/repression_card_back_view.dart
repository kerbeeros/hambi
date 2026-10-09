import 'package:flutter/material.dart';
import 'package:ui_kit/src/tokens/tokens.dart';
import 'package:ui_kit/src/widgets/repression_card_view.dart';

/// {@template repression_card_back_view}
/// The back of a repression card, as large as a [RepressionCardView] in a
/// dialog.
/// {@endtemplate}
class RepressionCardBackView extends StatelessWidget {
  /// {@macro repression_card_back_view}
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 280,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.cardRepression,
        border: Border.all(color: AppColors.trackRepressionField, width: 6),
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Container(
        width: 72,
        height: 96,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.trackRepressionField, width: 6),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    );
  }
}
