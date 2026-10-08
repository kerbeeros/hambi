import 'package:game_data/data_sources/dtos/dtos.dart';
import 'package:game_domain/game_domain.dart';

/// {@template local_to_domain_game_state_mapper}
/// Maps a stored game state back to a [GameState].
/// {@endtemplate}
class LocalToDomainGameStateMapper {
  /// {@macro local_to_domain_game_state_mapper}
  const new();

  /// Maps [dto] to a [GameState].
  ///
  /// Throws [FormatException] when the DTO contains unknown names, misses
  /// a value required by its variant, or the forest or action cards are
  /// incomplete.
  GameState map(GameStateDto dto) {
    _validate(dto);
    return _map(dto);
  }

  void _validate(GameStateDto dto) {
    if (dto.forest.length != Forest.columnCount ||
        dto.forest.any((column) => column.length != Forest.cardsPerColumn)) {
      throw const FormatException('Forest must have 3 columns of 4 cards');
    }
    if (dto.cardSides.length != ActionCardId.values.length) {
      throw const FormatException('Every action card needs a side');
    }
  }

  GameState _map(GameStateDto dto) => GameState(
    playerCount: dto.playerCount,
    forest: Forest(
      columns: [
        for (final column in dto.forest)
          [
            for (final card in column)
              ForestCard(
                state: _byName(ForestCardState.values, card.state),
                hasSecurity: card.hasSecurity,
                hasActivist: card.hasActivist,
              ),
          ],
      ],
    ),
    cardSides: {
      for (final MapEntry(key: card, value: side) in dto.cardSides.entries)
        _byName(ActionCardId.values, card): _byName(CardSide.values, side),
    },
    camp: Camp(activists: dto.camp.activists, resources: dto.camp.resources),
    support: dto.support,
    round: dto.round,
    phase: _byName(GamePhase.values, dto.phase),
    repressionDeck: _repressionCards(dto.repressionDeck),
    repressionInPlay: _repressionCards(dto.repressionInPlay),
    assignedCards: _actionCards(dto.assignedCards),
    activatedCards: _actionCards(dto.activatedCards),
    pendingDecision: switch (dto.pendingDecision) {
      null => null,
      final decision => _mapDecision(decision),
    },
    outcome: switch (dto.outcome) {
      null => null,
      final outcome => _byName(GameOutcome.values, outcome),
    },
    log: [for (final entry in dto.log) _mapLogEntry(entry)],
    repressionCardsToDraw: dto.repressionCardsToDraw,
    randomState: dto.randomState,
  );

  List<RepressionCard> _repressionCards(List<String> names) => [
    for (final name in names) _byName(RepressionCard.values, name),
  ];

  Set<ActionCardId> _actionCards(List<String> names) => {
    for (final name in names) _byName(ActionCardId.values, name),
  };

  PendingDecision _mapDecision(PendingDecisionDto dto) => switch (dto.type) {
    'placeActivists' => PlaceActivistsDecision(
      activists: _required(dto.activists, dto.type),
    ),
    'reroll' => RerollDecision(_required(dto.dice, dto.type)),
    'returnActivists' => const ReturnActivistsDecision(),
    'negativePress' => const NegativePressDecision(),
    'restoreCard' => const RestoreCardDecision(),
    'securityPlacement' => SecurityPlacementDecision(
      column: _required(dto.column, dto.type),
    ),
    final type => throw FormatException('Unknown decision type', type),
  };

  GameLogEntry _mapLogEntry(GameLogEntryDto dto) => switch (dto.type) {
    'diceRolled' => DiceRolled(_required(dto.dice, dto.type)),
    'dieRerolled' => DieRerolled(
      index: _required(dto.index, dto.type),
      value: _required(dto.value, dto.type),
    ),
    'repressionCardDrawn' => RepressionCardDrawn(
      _byName(RepressionCard.values, _required(dto.card, dto.type)),
    ),
    'repressionDieRolled' => RepressionDieRolled(
      _required(dto.value, dto.type),
    ),
    final type => throw FormatException('Unknown log entry type', type),
  };

  T _byName<T extends Enum>(List<T> values, String name) {
    for (final value in values) {
      if (value.name == name) return value;
    }
    throw FormatException('Unknown $T name', name);
  }

  T _required<T extends Object>(T? value, String type) =>
      value ?? (throw FormatException('Missing value for $type'));
}
