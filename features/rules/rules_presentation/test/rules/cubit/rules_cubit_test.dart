import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rules_presentation/rules_presentation.dart';

void main() {
  group(RulesCubit, () {
    test('S-05: starts with the game idea', () {
      expect(RulesCubit().state, equals(RulesSection.idea));
    });

    group('selected', () {
      blocTest<RulesCubit, RulesSection>(
        'S-05: shows the chosen section',
        build: RulesCubit.new,
        act: (cubit) => cubit.selected(RulesSection.cards),
        expect: () => [RulesSection.cards],
      );
    });
  });
}
