import 'package:octopush/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const PREFS_NAME = "name";
const PREFS_PHONE = "phone";
const PREFS_UNIVERSITY = "university";

class UserDataRepository {

 final SharedPreferences prefs;

 const UserDataRepository(this.prefs);

 User getUser() {
   var name = prefs.getString(PREFS_NAME);
   var phone = prefs.getString(PREFS_PHONE);
   var univ = prefs.getString(PREFS_UNIVERSITY);

   //Ensure no field is null
   if(name == null || phone == null || univ == null) return null;

   return User(name, phone, univ);
 }

 void saveUser(User user) async {
   print('$user');
   await prefs.setString(PREFS_NAME, user.name);
   await prefs.setString(PREFS_PHONE, user.phone);
   await prefs.setString(PREFS_UNIVERSITY, user.university);
 }

 Future<bool> clearUser() async{
   return await prefs.clear();
 }
}