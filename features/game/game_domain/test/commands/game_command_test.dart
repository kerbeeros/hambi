// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

void main() {
  group(StartGame, () {
    test('supports value equality', () {
      expect(
        StartGame(playerCount: 3, seed: 1),
        equals(StartGame(playerCount: 3, seed: 1)),
      );
    });

    test('differs by seed', () {
      expect(
        StartGame(playerCount: 3, seed: 1),
        isNot(equals(StartGame(playerCount: 3, seed: 2))),
      );
    });
  });

  group(Continue, () {
    test('supports value equality', () {
      expect(Continue(), equals(Continue()));
    });
  });

  group(AssignToCard, () {
    test('supports value equality', () {
      expect(
        AssignToCard(ActionCardId.demo),
        equals(AssignToCard(ActionCardId.demo)),
      );
      expect(
        AssignToCard(ActionCardId.demo),
        isNot(equals(AssignToCard(ActionCardId.allies))),
      );
    });
  });

  group(UndoAssignment, () {
    test('supports value equality', () {
      expect(
        UndoAssignment(ActionCardId.demo),
        equals(UndoAssignment(ActionCardId.demo)),
      );
      expect(
        UndoAssignment(ActionCardId.demo),
        isNot(equals(UndoAssignment(ActionCardId.allies))),
      );
    });
  });

  group(EndPreparation, () {
    test('supports value equality', () {
      expect(EndPreparation(), equals(EndPreparation()));
    });
  });

  group(PlaceActivistOnForest, () {
    test('supports value equality', () {
      expect(
        PlaceActivistOnForest(column: 1, position: 2),
        equals(PlaceActivistOnForest(column: 1, position: 2)),
      );
      expect(
        PlaceActivistOnForest(column: 1, position: 2),
        isNot(equals(PlaceActivistOnForest(column: 2, position: 1))),
      );
    });
  });

  group(RerollDie, () {
    test('supports value equality', () {
      expect(RerollDie(0), equals(RerollDie(0)));
      expect(RerollDie(0), isNot(equals(RerollDie(1))));
    });
  });

  group(ReturnActivistsToCamp, () {
    test('supports value equality', () {
      expect(
        ReturnActivistsToCamp({ForestPosition(column: 0, position: 1)}),
        equals(ReturnActivistsToCamp({ForestPosition(column: 0, position: 1)})),
      );
      expect(
        ReturnActivistsToCamp({ForestPosition(column: 0, position: 1)}),
        isNot(equals(ReturnActivistsToCamp(const {}))),
      );
    });
  });

  group(ResolveNegativePress, () {
    test('supports value equality', () {
      expect(
        ResolveNegativePress(NegativePressChoice.support),
        equals(ResolveNegativePress(NegativePressChoice.support)),
      );
      expect(
        ResolveNegativePress(NegativePressChoice.support),
        isNot(equals(ResolveNegativePress(NegativePressChoice.activist))),
      );
    });
  });

  group(ChooseCardToRestore, () {
    test('supports value equality', () {
      expect(
        ChooseCardToRestore(ActionCardId.internet),
        equals(ChooseCardToRestore(ActionCardId.internet)),
      );
      expect(
        ChooseCardToRestore(ActionCardId.internet),
        isNot(equals(ChooseCardToRestore(ActionCardId.allies))),
      );
    });
  });

  group(ChooseSecurityCard, () {
    test('supports value equality', () {
      expect(ChooseSecurityCard(1), equals(ChooseSecurityCard(1)));
      expect(ChooseSecurityCard(1), isNot(equals(ChooseSecurityCard(2))));
    });
  });
}
