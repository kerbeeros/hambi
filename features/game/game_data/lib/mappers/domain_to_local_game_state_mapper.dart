import 'package:game_data/data_sources/dtos/dtos.dart';
import 'package:game_domain/game_domain.dart';

/// {@template domain_to_local_game_state_mapper}
/// Maps a [GameState] to its stored form.
/// {@endtemplate}
class DomainToLocalGameStateMapper {
  /// {@macro domain_to_local_game_state_mapper}
  const new();

  /// Maps [state] to a [GameStateDto].
  GameStateDto map(GameState state) => GameStateDto(
    playerCount: state.playerCount,
    forest: [
      for (final column in state.forest.columns)
        [
          for (final card in column)
            ForestCardDto(
              state: card.state.name,
              hasSecurity: card.hasSecurity,
              hasActivist: card.hasActivist,
            ),
        ],
    ],
    cardSides: {
      for (final MapEntry(key: card, value: side) in state.cardSides.entries)
        card.name: side.name,
    },
    camp: CampDto(
      activists: state.camp.activists,
      resources: state.camp.resources,
    ),
    support: state.support,
    round: state.round,
    phase: state.phase.name,
    repressionDeck: [for (final card in state.repressionDeck) card.name],
    repressionInPlay: [for (final card in state.repressionInPlay) card.name],
    assignedCards: [for (final card in state.assignedCards) card.name],
    activatedCards: [for (final card in state.activatedCards) card.name],
    pendingDecision: switch (state.pendingDecision) {
      null => null,
      final decision => _mapDecision(decision),
    },
    outcome: state.outcome?.name,
    log: [for (final entry in state.log) _mapLogEntry(entry)],
    repressionCardsToDraw: state.repressionCardsToDraw,
    randomState: state.randomState,
  );

  PendingDecisionDto _mapDecision(PendingDecision decision) =>
      switch (decision) {
        PlaceActivistsDecision(:final activists) => PendingDecisionDto(
          type: 'placeActivists',
          activists: activists,
        ),
        RerollDecision(:final dice) => PendingDecisionDto(
          type: 'reroll',
          dice: dice,
        ),
        ReturnActivistsDecision() => const PendingDecisionDto(
          type: 'returnActivists',
        ),
        NegativePressDecision() => const PendingDecisionDto(
          type: 'negativePress',
        ),
        RestoreCardDecision() => const PendingDecisionDto(type: 'restoreCard'),
        SecurityPlacementDecision(:final column) => PendingDecisionDto(
          type: 'securityPlacement',
          column: column,
        ),
      };

  GameLogEntryDto _mapLogEntry(GameLogEntry entry) => switch (entry) {
    DiceRolled(:final dice) => GameLogEntryDto(type: 'diceRolled', dice: dice),
    DieRerolled(:final index, :final value) => GameLogEntryDto(
      type: 'dieRerolled',
      index: index,
      value: value,
    ),
    RepressionCardDrawn(:final card) => GameLogEntryDto(
      type: 'repressionCardDrawn',
      card: card.name,
    ),
    RepressionDieRolled(:final value) => GameLogEntryDto(
      type: 'repressionDieRolled',
      value: value,
    ),
  };
}
