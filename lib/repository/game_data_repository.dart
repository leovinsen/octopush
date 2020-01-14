import 'package:octopush/model/job.dart';
import 'package:octopush/model/game_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

const PREFS_JOB = "job";
const PREFS_BALANCE = "balance";

//Starting balance at 2M IDR
const STARTING_BALANCE = 2000000.0;

class GameDataRepository {
  final SharedPreferences prefs;

  const GameDataRepository(this.prefs);

  GameData getUserData(){
    int jobIndex = prefs.getInt(PREFS_JOB);
    var balance = prefs.getDouble(PREFS_BALANCE);

    if(jobIndex == null) return null;

    var job = Job.values[jobIndex];
    GameData userData = GameData(job, balance);

    return userData;
  }

  Future<bool>saveBalance(double balance) async {
    return prefs.setDouble(PREFS_BALANCE, balance);
  }

  Future<bool> saveUserJob(int job) async {
    return prefs.setInt(PREFS_JOB, job);
  }

  Future<bool> clearUserData() async {
    bool a = await prefs.remove(PREFS_JOB);
    bool b = await prefs.remove(PREFS_BALANCE);
    return a && b;
  }
}