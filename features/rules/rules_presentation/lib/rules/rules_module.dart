import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rules_presentation/rules/cubit/cubit.dart';

/// {@template rules_module}
/// Provides the [RulesCubit] of the rules screen (S-05).
/// {@endtemplate}
class RulesModule extends StatelessWidget {
  /// {@macro rules_module}
  const new({required this.child, super.key});

  /// The rules view.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => RulesCubit(), child: child);
  }
}
