import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

/// How a [ForestCard] is shown (R-001).
extension ForestCardPresentation on ForestCard {
  /// Visual state of the card.
  ForestCardViewState get viewState => switch (state) {
    ForestCardState.forest => ForestCardViewState.intact,
    ForestCardState.clearCut => ForestCardViewState.cleared,
    ForestCardState.removed => ForestCardViewState.removed,
  };

  /// Piece standing on the card.
  ForestCardOccupant get occupant => hasActivist
      ? ForestCardOccupant.activist
      : hasSecurity
      ? ForestCardOccupant.secu
      : ForestCardOccupant.none;

  /// Description for screen readers (NF-04); [column] and [position] are
  /// zero-based.
  String semanticLabel(
    GameLocalizations l10n, {
    required int column,
    required int position,
    required bool isThreatened,
  }) {
    final description = [
      switch (state) {
        ForestCardState.forest => l10n.forestStateIntact,
        ForestCardState.clearCut => l10n.forestStateCleared,
        ForestCardState.removed => l10n.forestStateRemoved,
      },
      if (hasActivist) l10n.forestOccupantActivist,
      if (hasSecurity) l10n.forestOccupantSecu,
      if (isThreatened) l10n.forestThreatened,
    ].join(', ');
    return l10n.forestCardLabel(column + 1, position + 1, description);
  }

  /// Title of the card detail (UX-07); [column] and [position] are
  /// zero-based.
  static String detailTitle(
    GameLocalizations l10n, {
    required int column,
    required int position,
  }) => l10n.forestDetailTitle(column + 1, position + 1);

  /// Explanations of state, piece and threat in the card detail (UX-07,
  /// R-123).
  List<String> explanations(
    GameLocalizations l10n, {
    required bool isThreatened,
  }) => [
    switch (state) {
      ForestCardState.forest => l10n.forestDetailIntact,
      ForestCardState.clearCut => l10n.forestDetailCleared,
      ForestCardState.removed => l10n.forestDetailRemoved,
    },
    if (hasActivist) l10n.forestDetailActivist,
    if (hasSecurity) l10n.forestDetailSecu,
    if (isThreatened) l10n.forestDetailThreatened,
  ];
}
