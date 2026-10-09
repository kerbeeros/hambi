import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// {@template rules_paragraph}
/// A paragraph of the rules with an optional [title].
/// {@endtemplate}
class RulesParagraph extends StatelessWidget {
  /// {@macro rules_paragraph}
  const new({required this.text, this.title, super.key});

  /// Heading of the paragraph, if any.
  final String? title;

  /// Body of the paragraph.
  final String text;

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title, style: AppTextStyle.headingH2),
            const SizedBox(height: AppSpacing.xs),
          ],
          Text(text, style: AppTextStyle.bodyDefault),
        ],
      ),
    );
  }
}
