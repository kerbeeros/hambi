import 'package:flutter/widgets.dart';
import 'package:rules_presentation/l10n/l10n.dart';
import 'package:rules_presentation/rules/widgets/rules_paragraph.dart';

/// {@template flow_section}
/// Setup and the four phases of a round (UX-10, spec 3.5–3.6).
/// {@endtemplate}
class FlowSection extends StatelessWidget {
  /// {@macro flow_section}
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RulesParagraph(title: l10n.flowSetupTitle, text: l10n.flowSetup),
        RulesParagraph(text: l10n.flowRound),
        RulesParagraph(
          title: l10n.flowPreparationTitle,
          text: l10n.flowPreparation,
        ),
        RulesParagraph(title: l10n.flowActionTitle, text: l10n.flowAction),
        RulesParagraph(
          title: l10n.flowExcavationTitle,
          text: l10n.flowExcavation,
        ),
        RulesParagraph(
          title: l10n.flowRepressionTitle,
          text: l10n.flowRepression,
        ),
      ],
    );
  }
}
