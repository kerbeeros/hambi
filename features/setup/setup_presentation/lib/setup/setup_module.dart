import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_domain/game_domain.dart';
import 'package:setup_presentation/setup/cubit/cubit.dart';

/// {@template setup_module}
/// Provides the [SetupCubit] of the setup screen; needs an
/// [IGameRepository] above it.
/// {@endtemplate}
class SetupModule extends StatelessWidget {
  /// {@macro setup_module}
  const new({required this.child, super.key});

  /// The setup screen, usually a `SetupView`.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetupCubit(context.read<IGameRepository>()),
      child: child,
    );
  }
}
