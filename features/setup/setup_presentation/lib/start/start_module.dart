import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_domain/game_domain.dart';
import 'package:setup_presentation/start/cubit/cubit.dart';

/// {@template start_module}
/// Provides the [StartCubit] of the start screen; needs an
/// [IGameRepository] above it.
/// {@endtemplate}
class StartModule extends StatelessWidget {
  /// {@macro start_module}
  const new({required this.child, super.key});

  /// The start screen, usually a `StartView`.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = StartCubit(context.read<IGameRepository>());
        unawaited(cubit.loaded());
        return cubit;
      },
      child: child,
    );
  }
}
