// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'rules_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class RulesLocalizationsEn extends RulesLocalizations {
  RulesLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get rulesTitle => 'Rules';

  @override
  String get backAction => 'Back';

  @override
  String get tabIdea => 'Idea';

  @override
  String get tabFlow => 'Flow';

  @override
  String get tabSymbols => 'Symbols';

  @override
  String get tabCards => 'Cards';

  @override
  String get ideaBackgroundTitle => 'The Hambach Forest';

  @override
  String get ideaBackground => 'With its unique ecosystem, the Hambach Forest was one of the last large mixed forests of Central Europe. In 1978 the energy company RWE (then Rheinbraun) bought the forest from the surrounding municipalities. Since then it has been cleared to mine lignite. Only a tenth of the once 5,500 ha forest is left. But the resistance is strong! The forest is occupied to prevent further destruction. This resistance stands not only for climate justice but also for a world free of domination and capitalist constraints. In this game we practise the uprising for climate justice.';

  @override
  String get ideaGoalTitle => 'Together for climate justice!';

  @override
  String get ideaGoal => 'The game lasts twelve rounds. During this time you try together to prevent the destruction of the Hambach Forest.';

  @override
  String get ideaVictory => 'Victory: after round 12, public support is higher than the number of forest cards RWE has excavated, that is removed from the game.';

  @override
  String get ideaDefeat => 'Defeat: if the number of these cards is equal or higher, you lose. If RWE has excavated a whole forest column, you lose at once.';

  @override
  String get flowSetupTitle => 'Setup';

  @override
  String get flowSetup => 'The forest cards lie green side up in three forest columns of four cards each. All campaign and support cards lie on side A. The camp gets as many activists as there are players. Playing alone, you also get two resources; playing as two, you get one resource. Before the first round you draw and execute as many repression cards as repression fields are reached.';

  @override
  String get flowRound => 'The game lasts twelve rounds. Each round has four phases.';

  @override
  String get flowPreparationTitle => '1. Preparation phase';

  @override
  String get flowPreparation => 'The clock moves on one hour. You decide together what to do this round: the cards show possible actions. The top part shows the conditions you have to meet to activate the actions and benefits in the bottom part. The benefit is only activated when all conditions are met. Blocked cards cannot be used this round.';

  @override
  String get flowActionTitle => '2. Action phase';

  @override
  String get flowAction => 'You carry out the actions in the bottom part of the assigned cards. The activists you placed on top of the cards return to the camp afterwards, the resources are used up. All newly gained activists and resources go to the camp.';

  @override
  String get flowExcavationTitle => '3. Excavator phase';

  @override
  String get flowExcavation => 'RWE tries to clear the forest first and then excavate it. Two dice show which forest column is hit (1–2: FC1, 3–4: FC2, 5–6: FC3); they are handled one after the other. The first card of the column that is not removed yet is hit. If it still shows forest, it is turned over; if it already shows cleared land, it is removed. A security guard on the card is removed first. If an activist stands on the card, it stays unchanged, but the activist is removed from the game. Activists left on the forest can return to the camp.';

  @override
  String get flowRepressionTitle => '4. Repression phase';

  @override
  String get flowRepression => 'First all repression cards of the previous round go back into the deck, which is shuffled. Then you check how many repression fields the success tracks have reached or passed. You draw that many cards, one after the other, and execute each before drawing the next.';

  @override
  String get symbolsActionCardsTitle => 'Symbols of the action cards';

  @override
  String get symbolsMaterialTitle => 'Game pieces';

  @override
  String get symbolActivistPiece => 'Activist: is placed for actions or protects a forest card. The success track shows how many activists are in play.';

  @override
  String get symbolResourcePiece => 'Resource: material and money used up by actions.';

  @override
  String get symbolSecuPiece => 'Security guard on a forest card. You cannot put activists on this card.';

  @override
  String get symbolSupportPiece => 'Public support: at the end it has to be higher than the number of removed forest cards.';

  @override
  String get symbolRepressionField => 'Repression field: when a success track reaches this field, you draw one more card in the repression phase.';

  @override
  String get symbolOneTime => 'One-time: the repression card is removed from the game after it is executed.';

  @override
  String get cardsHint => 'Tap a card to see its details.';

  @override
  String get cardsRepressionTitle => 'Repression cards';
}
