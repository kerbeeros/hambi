import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:setup_presentation/setup_presentation.dart';

import '../../helpers/helpers.dart';

class _MockStartCubit extends MockCubit<StartState> implements StartCubit;

class _MockGameRepository extends Mock implements IGameRepository;

void main() {
  group(StartView, () {
    late StartCubit cubit;
    late int newGames;
    late int resumes;
    late int rules;

    setUp(() {
      cubit = _MockStartCubit();
      newGames = 0;
      resumes = 0;
      rules = 0;
    });

    Future<void> pumpView(WidgetTester tester, StartState state) {
      when(() => cubit.state).thenReturn(state);
      return tester.pumpApp(
        BlocProvider.value(
          value: cubit,
          child: StartView(
            onNewGame: () => newGames++,
            onResume: () => resumes++,
            onRules: () => rules++,
          ),
        ),
      );
    }

    testWidgets('AC-060: meets the accessibility guidelines', (tester) async {
      await pumpView(
        tester,
        const StartState(status: StartStatus.ready, hasSavedGame: true),
      );

      await expectMeetsAccessibilityGuidelines(tester);
    });

    testWidgets('S-01: shows the title', (tester) async {
      await pumpView(tester, const StartState(status: StartStatus.ready));

      expect(find.text('Hambi bleibt!'), findsOneWidget);
    });

    testWidgets('shows a progress indicator while loading', (tester) async {
      await pumpView(tester, const StartState());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Neues Spiel'), findsNothing);
    });

    testWidgets('F-01: opens the setup', (tester) async {
      await pumpView(tester, const StartState(status: StartStatus.ready));

      await tester.tap(find.text('Neues Spiel'));

      expect(newGames, equals(1));
    });

    testWidgets('S-01: hides "Fortsetzen" without a saved game', (
      tester,
    ) async {
      await pumpView(tester, const StartState(status: StartStatus.ready));

      expect(find.text('Fortsetzen'), findsNothing);
    });

    testWidgets('F-04: continues a saved game', (tester) async {
      await pumpView(
        tester,
        const StartState(status: StartStatus.ready, hasSavedGame: true),
      );

      await tester.tap(find.text('Fortsetzen'));

      expect(resumes, equals(1));
    });

    testWidgets('UX-10: opens the rules', (tester) async {
      await pumpView(tester, const StartState(status: StartStatus.ready));

      await tester.tap(find.text('Regeln'));

      expect(rules, equals(1));
    });
  });

  group(StartModule, () {
    testWidgets('checks for a saved game', (tester) async {
      final repository = _MockGameRepository();
      when(repository.hasSavedGame).thenAnswer((_) async => true);

      await tester.pumpApp(
        RepositoryProvider<IGameRepository>.value(
          value: repository,
          child: StartModule(
            child: StartView(onNewGame: () {}, onResume: () {}, onRules: () {}),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Fortsetzen'), findsOneWidget);
    });
  });
}
