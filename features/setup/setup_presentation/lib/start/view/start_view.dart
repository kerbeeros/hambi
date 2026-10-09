import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setup_presentation/l10n/l10n.dart';
import 'package:setup_presentation/start/cubit/cubit.dart';
import 'package:ui_kit/ui_kit.dart';

/// {@template start_view}
/// The start screen (S-01): new game, if there is a saved game continue
/// (F-04), and the rules (UX-10).
/// {@endtemplate}
class StartView extends StatelessWidget {
  /// {@macro start_view}
  const new({
    required this.onNewGame,
    required this.onResume,
    required this.onRules,
    super.key,
  });

  /// Opens the setup of a new game.
  final VoidCallback onNewGame;

  /// Continues the saved game.
  final VoidCallback onResume;

  /// Opens the rules.
  final VoidCallback onRules;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<StartCubit>().state;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: HambiLogo(semanticLabel: l10n.appTitle),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.startSubtitle,
                    style: AppTextStyle.bodyDefault,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  if (state.status == StartStatus.loading)
                    const Center(child: CircularProgressIndicator())
                  else ...[
                    HambiButton(
                      label: l10n.newGameAction,
                      onPressed: onNewGame,
                    ),
                    if (state.hasSavedGame) ...[
                      const SizedBox(height: AppSpacing.sm),
                      HambiButton(
                        label: l10n.resumeGameAction,
                        style: HambiButtonStyle.secondary,
                        onPressed: onResume,
                      ),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    HambiButton(
                      label: l10n.rulesAction,
                      style: HambiButtonStyle.secondary,
                      onPressed: onRules,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
