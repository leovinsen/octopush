import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'repository/user_data_repository.dart';

void main() async {

  var sharedPrefs = await SharedPreferences.getInstance();
  var userRepo = UserDataRepository(sharedPrefs);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final UserDataRepository userDataRepository;

  const MyApp({Key key, this.userDataRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Octopush',
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      home: BlocProvider(


      ),
    );
  }
}
