import 'package:hambi_app/app/app.dart';
import 'package:hambi_app/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
