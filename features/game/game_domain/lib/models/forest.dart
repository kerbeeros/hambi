import 'package:equatable/equatable.dart';

/// State of a single forest card (R-001).
enum ForestCardState {
  /// Green, untouched forest.
  forest,

  /// Brown, cleared forest.
  clearCut,

  /// Removed by the excavator.
  removed,
}

/// {@template forest_card}
/// A forest card with its state and the pieces standing on it.
/// {@endtemplate}
class ForestCard extends Equatable {
  /// {@macro forest_card}
  const new({
    this.state = ForestCardState.forest,
    this.hasSecurity = false,
    this.hasActivist = false,
  });

  /// Current state of the card.
  final ForestCardState state;

  /// Whether a security guard stands on the card (R-050).
  final bool hasSecurity;

  /// Whether an activist stands on the card (R-085).
  final bool hasActivist;

  /// Whether an activist may be placed on the card (R-085, Q11, Q19).
  bool get canHoldActivist =>
      state != ForestCardState.removed && !hasSecurity && !hasActivist;

  /// Returns a copy with the given fields replaced.
  ForestCard copyWith({
    ForestCardState? state,
    bool? hasSecurity,
    bool? hasActivist,
  }) => ForestCard(
    state: state ?? this.state,
    hasSecurity: hasSecurity ?? this.hasSecurity,
    hasActivist: hasActivist ?? this.hasActivist,
  );

  @override
  List<Object> get props => [state, hasSecurity, hasActivist];
}

/// {@template forest}
/// The forest: 3 columns (WS1–WS3) of 4 cards each (R-020).
///
/// Columns and positions are zero-based: column `0` is WS1 and position `0`
/// is the leftmost card.
/// {@endtemplate}
class Forest extends Equatable {
  /// {@macro forest}
  new({required List<List<ForestCard>> columns})
    : columns = List.unmodifiable(columns.map(List<ForestCard>.unmodifiable));

  /// Creates an untouched forest (R-110).
  factory initial() => Forest(
    columns: List.generate(
      columnCount,
      (_) => List.filled(cardsPerColumn, const ForestCard()),
    ),
  );

  /// Number of forest columns.
  static const int columnCount = 3;

  /// Number of cards per forest column.
  static const int cardsPerColumn = 4;

  /// The forest columns, each ordered from left to right.
  final List<List<ForestCard>> columns;

  /// All forest cards, column by column.
  Iterable<ForestCard> get cards => columns.expand((column) => column);

  /// Whether ([column], [position]) is a card of the forest.
  static bool contains({required int column, required int position}) =>
      column >= 0 &&
      column < columnCount &&
      position >= 0 &&
      position < cardsPerColumn;

  /// Returns a copy in which the card at ([column], [position]) is [card].
  Forest replace({
    required int column,
    required int position,
    required ForestCard card,
  }) => Forest(
    columns: [
      for (var c = 0; c < columnCount; c++)
        [
          for (var p = 0; p < cardsPerColumn; p++)
            if (c == column && p == position) card else columns[c][p],
        ],
    ],
  );

  @override
  List<Object> get props => [columns];
}
