import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hambi_app/app/app.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  group(App, () {
    testWidgets('renders $AppPlaceholderPage', (tester) async {
      await tester.pumpWidget(const App());

      expect(find.byType(AppPlaceholderPage), findsOneWidget);
    });

    testWidgets('uses $AppTheme', (tester) async {
      await tester.pumpWidget(const App());

      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app.theme, equals(AppTheme.light));
    });
  });
}
