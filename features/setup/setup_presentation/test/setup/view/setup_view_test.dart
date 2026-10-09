import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:setup_presentation/setup_presentation.dart';

import '../../helpers/helpers.dart';

class _MockSetupCubit extends MockCubit<SetupState> implements SetupCubit;

class _MockGameRepository extends Mock implements IGameRepository;

void main() {
  group(SetupView, () {
    late SetupCubit cubit;
    late List<int> starts;
    late int backs;

    setUp(() {
      cubit = _MockSetupCubit();
      when(() => cubit.state).thenReturn(const SetupState());
      when(() => cubit.startRequested()).thenAnswer((_) async {});
      starts = [];
      backs = 0;
    });

    Future<void> pumpView(WidgetTester tester) => tester.pumpApp(
      BlocProvider.value(
        value: cubit,
        child: SetupView(onStart: starts.add, onBack: () => backs++),
      ),
    );

    testWidgets('AC-060: meets the accessibility guidelines', (tester) async {
      await pumpView(tester);

      await expectMeetsAccessibilityGuidelines(tester);
    });

    testWidgets('S-02: shows the player count', (tester) async {
      await pumpView(tester);

      expect(find.text('3'), findsOneWidget);
      expect(find.bySemanticsLabel('3 Spieler*innen'), findsOneWidget);
    });

    testWidgets('S-02/R-111: shows the starting camp', (tester) async {
      when(() => cubit.state).thenReturn(const SetupState(playerCount: 1));
      await pumpView(tester);

      expect(
        find.text(
          'Ihr startet mit 1 Mitstreiter*innen und 2 Ressourcen im Camp.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('changes the player count', (tester) async {
      await pumpView(tester);

      await tester.tap(find.bySemanticsLabel('Mehr Spieler*innen'));
      await tester.tap(find.bySemanticsLabel('Weniger Spieler*innen'));

      verify(() => cubit.playersIncreased()).called(1);
      verify(() => cubit.playersDecreased()).called(1);
    });

    testWidgets('requests the start', (tester) async {
      await pumpView(tester);

      await tester.tap(find.text('Spiel starten'));

      verify(() => cubit.startRequested()).called(1);
    });

    testWidgets('goes back', (tester) async {
      await pumpView(tester);

      await tester.tap(find.text('Zurück'));

      expect(backs, equals(1));
    });

    testWidgets('F-01: starts the game for the chosen players', (tester) async {
      whenListen(
        cubit,
        Stream.value(
          const SetupState(playerCount: 5, status: SetupStatus.started),
        ),
        initialState: const SetupState(playerCount: 5),
      );
      await pumpView(tester);
      await tester.pump();

      expect(starts, equals([5]));
    });

    group('D-11', () {
      setUp(() {
        whenListen(
          cubit,
          Stream.value(const SetupState(status: SetupStatus.confirmOverwrite)),
          initialState: const SetupState(),
        );
      });

      testWidgets('AC-060: meets the accessibility guidelines', (tester) async {
        await pumpView(tester);
        await tester.pumpAndSettle();

        await expectMeetsAccessibilityGuidelines(tester);
      });

      testWidgets('confirms overwriting the saved game', (tester) async {
        await pumpView(tester);
        await tester.pumpAndSettle();

        expect(find.text('Spielstand überschreiben?'), findsOneWidget);
        await tester.tap(find.text('Neues Spiel starten'));
        await tester.pumpAndSettle();

        verify(() => cubit.overwriteConfirmed()).called(1);
      });

      testWidgets('keeps the saved game', (tester) async {
        await pumpView(tester);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Abbrechen'));
        await tester.pumpAndSettle();

        verify(() => cubit.overwriteCancelled()).called(1);
      });
    });
  });

  group(SetupModule, () {
    testWidgets('provides the setup', (tester) async {
      await tester.pumpApp(
        RepositoryProvider<IGameRepository>.value(
          value: _MockGameRepository(),
          child: SetupModule(
            child: SetupView(onStart: (_) {}, onBack: () {}),
          ),
        ),
      );

      expect(find.text('3'), findsOneWidget);
    });
  });
}
