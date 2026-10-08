import 'package:flutter/material.dart';
import 'package:ui_kit/src/tokens/tokens.dart';

/// {@template hambi_dialog}
/// Dialog of the Hambi design system, used for decisions (D-01–D-07).
/// {@endtemplate}
class HambiDialog extends StatelessWidget {
  /// {@macro hambi_dialog}
  const new({
    required this.title,
    required this.content,
    this.actions = const [],
    super.key,
  });

  /// Dialog title.
  final String title;

  /// Dialog body.
  final Widget content;

  /// Buttons below the content, stacked vertically.
  final List<Widget> actions;

  /// Shows a dialog that can only be closed through its actions, because
  /// game decisions must not be skipped by tapping outside (UX-03).
  static Future<T?> show<T>(
    BuildContext context, {
    required WidgetBuilder builder,
  }) => showDialog<T>(
    context: context,
    barrierDismissible: false,
    builder: builder,
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.bgSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: AppTextStyle.headingH2),
            const SizedBox(height: AppSpacing.lg),
            Flexible(
              child: SingleChildScrollView(
                child: DefaultTextStyle(
                  style: AppTextStyle.bodyDefault,
                  child: content,
                ),
              ),
            ),
            for (final action in actions) ...[
              const SizedBox(height: AppSpacing.sm),
              action,
            ],
          ],
        ),
      ),
    );
  }
}

/// {@template hambi_bottom_sheet}
/// Bottom sheet of the Hambi design system, e.g. round log and game menu.
/// {@endtemplate}
class HambiBottomSheet extends StatelessWidget {
  /// {@macro hambi_bottom_sheet}
  const new({required this.title, required this.child, super.key});

  /// Sheet title.
  final String title;

  /// Sheet body.
  final Widget child;

  /// Shows a modal bottom sheet.
  static Future<T?> show<T>(
    BuildContext context, {
    required WidgetBuilder builder,
  }) => showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: AppColors.bgSurface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
    ),
    builder: builder,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          bottom: AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: AppTextStyle.headingH2),
            const SizedBox(height: AppSpacing.md),
            Flexible(
              child: SingleChildScrollView(
                child: DefaultTextStyle(
                  style: AppTextStyle.bodyDefault,
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
