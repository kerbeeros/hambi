import 'package:game_domain/game_domain.dart';
import 'package:test/test.dart';

void main() {
  group(Camp, () {
    group('forPlayers', () {
      for (final (players, resources) in [(1, 2), (2, 1), (3, 0), (11, 0)]) {
        test('R-111: $players players start with $players activists '
            'and $resources resources', () {
          expect(
            Camp.forPlayers(players),
            equals(Camp(activists: players, resources: resources)),
          );
        });
      }
    });
  });
}
