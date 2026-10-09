import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rules_presentation/rules_presentation.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

class _MockRulesCubit extends MockCubit<RulesSection> implements RulesCubit;

void main() {
  group(RulesView, () {
    late RulesCubit cubit;
    late int backs;

    setUp(() {
      cubit = _MockRulesCubit();
      backs = 0;
    });

    Future<void> pumpView(WidgetTester tester, RulesSection section) {
      when(() => cubit.state).thenReturn(section);
      return tester.pumpApp(
        BlocProvider.value(
          value: cubit,
          child: RulesView(onBack: () => backs++),
        ),
      );
    }

    group('renders', () {
      testWidgets('S-05: the title and a tab per section', (tester) async {
        await pumpView(tester, RulesSection.idea);

        expect(find.text('Regeln'), findsOneWidget);
        for (final tab in ['Spielidee', 'Ablauf', 'Symbole', 'Karten']) {
          expect(find.text(tab), findsOneWidget);
        }
        expect(
          tester.widget<BoardTabs>(find.byType(BoardTabs)).selectedIndex,
          equals(0),
        );
      });

      testWidgets('UX-10: the idea with victory and defeat', (tester) async {
        await pumpView(tester, RulesSection.idea);

        expect(find.text('Der Hambacher Forst'), findsOneWidget);
        expect(find.textContaining('Sieg: Nach Runde 12'), findsOneWidget);
        expect(find.textContaining('Niederlage:'), findsOneWidget);
      });

      testWidgets('UX-10: the setup and the four phases', (tester) async {
        await pumpView(tester, RulesSection.flow);

        for (final title in [
          'Spielvorbereitung',
          '1. Vorbereitungsphase',
          '2. Aktionsphase',
          '3. Baggerphase',
          '4. Repressionsphase',
        ]) {
          expect(find.text(title), findsOneWidget);
        }
      });

      testWidgets('UX-10: every card symbol and the game pieces', (
        tester,
      ) async {
        await pumpView(tester, RulesSection.symbols);

        expect(
          find.byType(CardSymbolView),
          findsNWidgets(CardSymbol.values.length),
        );
        expect(
          find.text('Ihr müsst eine Ressource einsetzen.'),
          findsOneWidget,
        );
        expect(find.textContaining('Secu: Security'), findsOneWidget);
        expect(find.textContaining('Repressionsfeld:'), findsOneWidget);
        expect(find.textContaining('Einmalig:'), findsOneWidget);
      });

      testWidgets('UX-10: every action card on side A and every repression '
          'card', (tester) async {
        await pumpView(tester, RulesSection.cards);

        expect(
          find.byType(ActionCardView, skipOffstage: false),
          findsNWidgets(ActionCardId.values.length),
        );
        expect(
          tester
              .widgetList<ActionCardView>(
                find.byType(ActionCardView, skipOffstage: false),
              )
              .map((card) => card.sideLabel),
          everyElement(isNull),
        );
        expect(
          find.byType(RepressionCardView, skipOffstage: false),
          findsNWidgets(RepressionCard.values.length),
        );
      });
    });

    group('interaction', () {
      testWidgets('S-05: selects a tapped section', (tester) async {
        await pumpView(tester, RulesSection.idea);

        await tester.tap(find.text('Karten'));

        verify(() => cubit.selected(RulesSection.cards)).called(1);
      });

      testWidgets('UX-10: goes back', (tester) async {
        await pumpView(tester, RulesSection.idea);

        await tester.tap(find.text('Zurück'));

        expect(backs, equals(1));
      });

      testWidgets('UX-10: tapping an action card shows its detail', (
        tester,
      ) async {
        await pumpView(tester, RulesSection.cards);

        await tester.tap(find.text('Sabotage'));
        await tester.pumpAndSettle();

        final detail = tester.widget<ActionCardDetail>(
          find.byType(ActionCardDetail),
        );
        expect(detail.card, equals(ActionCardId.sabotage));
        expect(detail.game, isNull);
      });

      testWidgets('UX-10: tapping a repression card shows its detail', (
        tester,
      ) async {
        await pumpView(tester, RulesSection.cards);

        final razzia = find.text('Razzia', skipOffstage: false);
        await tester.scrollUntilVisible(razzia, 200);
        await tester.tap(razzia);
        await tester.pumpAndSettle();

        expect(
          tester
              .widget<RepressionCardDetail>(find.byType(RepressionCardDetail))
              .card,
          equals(RepressionCard.raid),
        );
      });
    });
  });

  group(RulesModule, () {
    testWidgets('provides a $RulesCubit starting with the idea', (
      tester,
    ) async {
      await tester.pumpApp(RulesModule(child: RulesView(onBack: () {})));

      expect(find.text('Der Hambacher Forst'), findsOneWidget);
    });
  });
}
