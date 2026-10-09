import 'package:bloc/bloc.dart';

/// Sections of the rules, shown as tabs (S-05).
enum RulesSection {
  /// Background and goal of the game.
  idea,

  /// Setup and the four phases of a round.
  flow,

  /// Legend of the symbols.
  symbols,

  /// Overview of all action and repression cards.
  cards,
}

/// {@template rules_cubit}
/// The section of the rules shown (S-05).
/// {@endtemplate}
class RulesCubit extends Cubit<RulesSection> {
  /// {@macro rules_cubit}
  new() : super(RulesSection.idea);

  /// The players chose [section].
  void selected(RulesSection section) => emit(section);
}
