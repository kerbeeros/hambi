import 'package:game_data/game_data.dart';
import 'package:hambi_app/app/app.dart';
import 'package:hambi_app/bootstrap.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await bootstrap(
    () => App(
      gameRepository: GameRepository(
        dataSource: LocalGameDataSource(SharedPreferencesAsync()),
      ),
    ),
  );
}
