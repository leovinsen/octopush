import 'package:flutter_test/flutter_test.dart';
import 'package:octopush/model/time_interval.dart';
import 'package:octopush/repository/game_data_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  test('Increment interval should work', () async {
    TestWidgetsFlutterBinding.ensureInitialized();

    SharedPreferences.setMockInitialValues({
      PREFS_INTERVAL: 0,
      PREFS_JOB : 0,
      PREFS_BALANCE : STARTING_BALANCE
    });

    final gameDataRepo = GameDataRepository(await SharedPreferences.getInstance());

    await gameDataRepo.incrementInterval();
    var gameData = gameDataRepo.getGameData();
    expect(gameData.currentInterval, TimeInterval.DAY1_B);
  });
}