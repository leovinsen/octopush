import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/user_bloc.dart';
import 'repository/user_data_repository.dart';
import 'root_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Octopush',
        theme: ThemeData(primarySwatch: Colors.red),
        home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _userRepo;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) => {
          setState(() {
            _userRepo = UserDataRepository(prefs);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return _userRepo == null
        ? Center(child: Text('Splash Screen'))
        : BlocProvider(
            create: (_) => UserBloc(_userRepo),
            child: RootPage(),
          );
  }
}
