import 'package:octopush/model/job.dart';
import 'package:octopush/model/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

const PREFS_JOB = "job";
const PREFS_BALANCE = "balance";

//Starting balance at 2M IDR
const STARTING_BALANCE = 2000000.0;

class UserDataRepository {
  final SharedPreferences prefs;

  const UserDataRepository(this.prefs);

  UserData getUserData(){
    var job = Job.values[prefs.getInt(PREFS_JOB)];
    var balance = prefs.getDouble(PREFS_BALANCE);

    if(job == null) return null;

    UserData userData = UserData(job, balance);

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