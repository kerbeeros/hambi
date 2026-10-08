import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

import '../helpers/helpers.dart';

void main() {
  group(RepressionField, () {
    group('activatedRepressionFields', () {
      int activatedCount({required int activists, required int support}) =>
          buildGameState(
            camp: Camp(activists: activists, resources: 0),
            support: support,
          ).activatedRepressionFields.length;

      test('R-090: no field is activated when both tracks are 0', () {
        expect(activatedCount(activists: 0, support: 0), equals(0));
      });

      test('R-090/Q3: a field is activated when the track reaches it', () {
        expect(activatedCount(activists: 2, support: 0), equals(1));
      });

      test('R-090: a field is not activated below its value', () {
        expect(activatedCount(activists: 1, support: 0), equals(0));
      });

      test('AC-005: 7 activists and support 5 activate 3 fields', () {
        expect(activatedCount(activists: 7, support: 5), equals(3));
      });

      test('R-090/Q2: the middle fields use the higher track value', () {
        expect(
          buildGameState(
            camp: const Camp(activists: 0, resources: 0),
            support: 7,
          ).activatedRepressionFields,
          equals({
            RepressionField.middle4,
            RepressionField.middle6,
            RepressionField.support7,
          }),
        );
      });

      test('R-090: all 6 fields are activated at 11 and 11', () {
        expect(activatedCount(activists: 11, support: 11), equals(6));
      });
    });
  });
}
