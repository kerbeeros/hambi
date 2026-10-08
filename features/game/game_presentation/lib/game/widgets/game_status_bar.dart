import 'package:flutter/material.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

/// {@template game_status_bar}
/// Fixed status area of the board (ADR 0003): free activists, resources,
/// threatening repression cards and both success tracks.
/// {@endtemplate}
class GameStatusBar extends StatelessWidget {
  /// {@macro game_status_bar}
  const new({required this.game, super.key});

  /// The game to show.
  final GameState game;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final activists = game.activistsInPlay;
    final support = game.support;
    final draws = game.upcomingRepressionDraws;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              StatusChip(
                kind: StatusChipKind.activist,
                label: '${game.camp.activists}',
                semanticLabel: l10n.campActivistsLabel(game.camp.activists),
              ),
              StatusChip(
                kind: StatusChipKind.resource,
                label: '${game.camp.resources}',
                semanticLabel: l10n.campResourcesLabel(game.camp.resources),
              ),
              StatusChip(
                kind: StatusChipKind.repression,
                label: '$draws',
                semanticLabel: l10n.upcomingRepressionLabel(draws),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _Track(
            kind: SuccessTrackKind.activists,
            value: activists,
            semanticLabel: l10n.activistTrackLabel(activists),
          ),
          const SizedBox(height: AppSpacing.xs),
          _Track(
            kind: SuccessTrackKind.support,
            value: support,
            semanticLabel: l10n.supportTrackLabel(support),
          ),
        ],
      ),
    );
  }
}

/// A success track with the repression fields it activates (R-090).
///
/// The middle fields are activated by the higher track (Q2), so they are
/// shown on both tracks, activated where this track reaches them.
class _Track extends StatelessWidget {
  const new({
    required this.kind,
    required this.value,
    required this.semanticLabel,
  });

  final SuccessTrackKind kind;
  final int value;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final ownTrack = switch (kind) {
      SuccessTrackKind.activists => RepressionTrack.activists,
      SuccessTrackKind.support => RepressionTrack.support,
    };
    final fields = [
      for (final field in RepressionField.values)
        if (field.track == ownTrack || field.track == RepressionTrack.both)
          field.value,
    ];
    return SuccessTrack(
      kind: kind,
      value: value,
      repressionFields: fields.toSet(),
      activatedFields: {
        for (final field in fields)
          if (value >= field) field,
      },
      semanticLabel: semanticLabel,
    );
  }
}
