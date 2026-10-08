import 'package:flutter_test/flutter_test.dart';
import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/game_presentation.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../helpers/helpers.dart';

void main() {
  group(GameStatusBar, () {
    final game = buildGameState(
      camp: const Camp(activists: 7, resources: 2),
      support: 5,
    );

    testWidgets('shows free activists, resources and upcoming draws', (
      tester,
    ) async {
      await tester.pumpApp(GameStatusBar(game: game));

      expect(find.bySemanticsLabel('7 Mitstreiter*innen im Camp'), findsOne);
      expect(find.bySemanticsLabel('2 Ressourcen im Camp'), findsOne);
      expect(find.bySemanticsLabel('3 Repressionskarten drohen'), findsOne);
    });

    testWidgets('R-090: shows both tracks with their repression fields', (
      tester,
    ) async {
      await tester.pumpApp(GameStatusBar(game: game));

      final tracks = tester
          .widgetList<SuccessTrack>(find.byType(SuccessTrack))
          .toList();
      expect(tracks[0].value, equals(7));
      expect(tracks[0].repressionFields, equals({2, 4, 6, 8}));
      expect(tracks[0].activatedFields, equals({2, 4, 6}));
      expect(tracks[1].value, equals(5));
      expect(tracks[1].repressionFields, equals({4, 6, 7, 10}));
      expect(tracks[1].activatedFields, equals({4}));
    });
  });
}
