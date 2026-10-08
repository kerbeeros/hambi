// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

void main() {
  group(ForestCard, () {
    test('supports value equality', () {
      expect(
        ForestCard(state: ForestCardState.clearCut, hasActivist: true),
        equals(ForestCard(state: ForestCardState.clearCut, hasActivist: true)),
      );
    });

    test('differs when a security guard is placed', () {
      expect(ForestCard(hasSecurity: true), isNot(equals(ForestCard())));
    });

    group('copyWith', () {
      test('keeps unspecified fields', () {
        expect(
          ForestCard(hasActivist: true).copyWith(hasSecurity: true),
          equals(ForestCard(hasActivist: true, hasSecurity: true)),
        );
      });
    });
  });
}
