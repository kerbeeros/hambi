import 'package:flutter/material.dart';
import 'package:ui_kit/src/icons/icons.dart';
import 'package:ui_kit/src/tokens/tokens.dart';

/// {@template camp_card_view}
/// The camp card with the available activists and resources (R-023).
/// {@endtemplate}
class CampCardView extends StatelessWidget {
  /// {@macro camp_card_view}
  const new({
    required this.title,
    required this.activists,
    required this.resources,
    super.key,
  });

  /// Card title, e.g. "Camp".
  final String title;

  /// Available activists.
  final int activists;

  /// Available resources.
  final int resources;

  /// Card width in logical pixels.
  static const double width = 113;

  /// Card height in logical pixels.
  static const double height = 96;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.cardCamp,
        border: Border.all(color: AppColors.borderDefault),
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyle.cardTitle),
          const Spacer(),
          _Counter(icon: HambiIconData.activist, value: activists),
          const SizedBox(height: AppSpacing.xs),
          _Counter(icon: HambiIconData.resource, value: resources),
        ],
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  const new({required this.icon, required this.value});

  final HambiIconData icon;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HambiIcon(icon, size: 20),
        const SizedBox(width: AppSpacing.xs),
        Text('$value', style: AppTextStyle.numberSmall),
      ],
    );
  }
}
