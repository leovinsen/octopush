import 'package:octopush/exception/illegal_interval_exception.dart';
import 'package:octopush/model/job.dart';
import 'package:octopush/model/game_data.dart';
import 'package:octopush/model/time_interval.dart';
import 'package:shared_preferences/shared_preferences.dart';

const PREFS_JOB = "job";
const PREFS_INTERVAL = "interval";

class GameDataRepository {
  final SharedPreferences prefs;

  const GameDataRepository(this.prefs);

  GameData getGameData() {
    int jobIndex = prefs.getInt(PREFS_JOB);
    int intervalIndex = prefs.getInt(PREFS_INTERVAL);

    ///If job index is null then game is not yet initialized by user
    if (jobIndex == null || intervalIndex == null)
      return null;

    var job = Job.values[jobIndex];

    var interval = TimeInterval.values[intervalIndex];

    GameData userData = GameData(job, interval);

    return userData;
  }

  Future<bool> initializeData(int jobIndex) async {
    bool a = await prefs.setInt(PREFS_JOB, jobIndex);
    bool b = await prefs.setInt(PREFS_INTERVAL, TIME_1A);

    return a && b;
  }

  Future<bool> clearUserData() async {
    return await prefs.clear();
  }

  Future<int> incrementInterval() async {
    int interval = prefs.getInt(PREFS_INTERVAL);

    if (interval >= TIME_12B) throw InvalidIntervalAdditionException();

    int newInterval = interval + 1;

    bool success = await prefs.setInt(PREFS_INTERVAL, newInterval);

    return success ? newInterval : -1;
  }
}
