import 'package:octopush/model/job.dart';
import 'package:octopush/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const PREFS_NAME = "name";
const PREFS_PHONE = "phone";
const PREFS_UNIVERSITY = "university";
const PREFS_JOB = "job";

class UserDataRepository {

 final SharedPreferences prefs;

 const UserDataRepository(this.prefs);

 User getUser() {
   var name = prefs.getString(PREFS_NAME);
   var phone = prefs.getString(PREFS_PHONE);
   var univ = prefs.getString(PREFS_UNIVERSITY);
   var job = prefs.getInt(PREFS_JOB);

   //Ensure no field is null
   if(name == null || phone == null || univ == null || job == null) return null;

   return User(name, phone, univ, Job.values[job]);
 }

 void saveUser(User user) async {
   print('$user');
   await prefs.setString(PREFS_NAME, user.name);
   await prefs.setString(PREFS_PHONE, user.phone);
   await prefs.setString(PREFS_UNIVERSITY, user.university);
   await prefs.setInt(PREFS_JOB, user.job.index);
 }

 Future<bool> clearUser() async{
   return await prefs.clear();
 }
}