import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_domain/game_domain.dart';
import 'package:setup_presentation/l10n/l10n.dart';
import 'package:setup_presentation/setup/cubit/cubit.dart';
import 'package:ui_kit/ui_kit.dart';

/// {@template setup_view}
/// The setup of a new game (S-02): number of players and starting camp,
/// with a confirmation before a saved game is replaced (D-11).
/// {@endtemplate}
class SetupView extends StatelessWidget {
  /// {@macro setup_view}
  const new({required this.onStart, required this.onBack, super.key});

  /// Starts a new game for the given number of players.
  final ValueChanged<int> onStart;

  /// Returns to the start screen.
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<SetupCubit, SetupState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status != SetupStatus.editing,
      listener: (context, state) async {
        if (state.status == SetupStatus.started) {
          onStart(state.playerCount);
        } else {
          await _confirmOverwrite(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.setupTitle,
                      style: AppTextStyle.headingH1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      l10n.playerCountLabel,
                      style: AppTextStyle.label,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const _PlayerCountPicker(),
                    const SizedBox(height: AppSpacing.lg),
                    const _StartingCampHint(),
                    const SizedBox(height: AppSpacing.xl),
                    HambiButton(
                      label: l10n.startGameAction,
                      onPressed: context.read<SetupCubit>().startRequested,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    HambiButton(
                      label: l10n.backAction,
                      style: HambiButtonStyle.secondary,
                      onPressed: onBack,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmOverwrite(BuildContext context) async {
    final l10n = context.l10n;
    final cubit = context.read<SetupCubit>();
    final confirmed = await HambiDialog.show<bool>(
      context,
      builder: (dialogContext) => HambiDialog(
        title: l10n.overwriteTitle,
        content: Text(l10n.overwriteBody),
        actions: [
          HambiButton(
            label: l10n.overwriteConfirmAction,
            onPressed: () => Navigator.of(dialogContext).pop(true),
          ),
          HambiButton(
            label: l10n.overwriteCancelAction,
            style: HambiButtonStyle.secondary,
            onPressed: () => Navigator.of(dialogContext).pop(false),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      cubit.overwriteConfirmed();
    } else {
      cubit.overwriteCancelled();
    }
  }
}

class _PlayerCountPicker extends StatelessWidget {
  const new();

  static const double _buttonWidth = 64;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<SetupCubit>();
    final playerCount = context.select<SetupCubit, int>(
      (cubit) => cubit.state.playerCount,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _StepButton(
          label: '−',
          semanticLabel: l10n.decreasePlayersAction,
          onPressed: cubit.playersDecreased,
        ),
        SizedBox(
          width: _buttonWidth * 1.5,
          child: Semantics(
            label: l10n.playerCountValue(playerCount),
            excludeSemantics: true,
            child: Text(
              '$playerCount',
              style: AppTextStyle.display,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        _StepButton(
          label: '+',
          semanticLabel: l10n.increasePlayersAction,
          onPressed: cubit.playersIncreased,
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const new({
    required this.label,
    required this.semanticLabel,
    required this.onPressed,
  });

  final String label;
  final String semanticLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      excludeSemantics: true,
      child: SizedBox(
        width: _PlayerCountPicker._buttonWidth,
        child: HambiButton(
          label: label,
          style: HambiButtonStyle.secondary,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class _StartingCampHint extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final camp = context.select<SetupCubit, Camp>(
      (cubit) => cubit.state.startingCamp,
    );
    return Text(
      context.l10n.startingCampHint(camp.activists, camp.resources),
      style: AppTextStyle.bodySmall,
      textAlign: TextAlign.center,
    );
  }
}
