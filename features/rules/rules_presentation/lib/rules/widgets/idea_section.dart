import 'package:flutter/widgets.dart';
import 'package:rules_presentation/l10n/l10n.dart';
import 'package:rules_presentation/rules/widgets/rules_paragraph.dart';

/// {@template idea_section}
/// Background, goal and end of the game (UX-10, R-100, R-101).
/// {@endtemplate}
class IdeaSection extends StatelessWidget {
  /// {@macro idea_section}
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RulesParagraph(
          title: l10n.ideaBackgroundTitle,
          text: l10n.ideaBackground,
        ),
        RulesParagraph(title: l10n.ideaGoalTitle, text: l10n.ideaGoal),
        RulesParagraph(text: l10n.ideaVictory),
        RulesParagraph(text: l10n.ideaDefeat),
      ],
    );
  }
}
