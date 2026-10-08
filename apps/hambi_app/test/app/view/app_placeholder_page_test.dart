import 'package:flutter_test/flutter_test.dart';
import 'package:hambi_app/app/app.dart';

import '../../helpers/helpers.dart';

void main() {
  group(AppPlaceholderPage, () {
    testWidgets('renders localized app title', (tester) async {
      await tester.pumpApp(const AppPlaceholderPage());

      expect(find.text('Hambi bleibt!'), findsOneWidget);
    });
  });
}
