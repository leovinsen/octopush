import 'package:octopush/exception/game_not_initialized_exception.dart';
import 'package:octopush/exception/illegal_interval_exception.dart';
import 'package:octopush/model/time_interval.dart';
import 'package:shared_preferences/shared_preferences.dart';

const PREFS_INTERVAL = "interval";

class IntervalService {
  final SharedPreferences prefs;

  IntervalService(this.prefs);

  TimeInterval getCurrentInterval(){
    int intervalIndex = prefs.getInt(PREFS_INTERVAL);

    if (intervalIndex == null) throw GameNotInitializedException(GameNotInitialized.interval);

    return TimeInterval.values[intervalIndex];
  }

  Future<bool> initializeInterval() async {
    return await prefs.setInt(PREFS_INTERVAL, TIME_1A);
  }


  Future<int> incrementInterval() async {
    int interval = prefs.getInt(PREFS_INTERVAL);

    if (interval >= TIME_12B) throw InvalidIntervalAdditionException();

    int newInterval = interval + 1;

    bool success = await prefs.setInt(PREFS_INTERVAL, newInterval);

    return success ? newInterval : -1;
  }
  
}