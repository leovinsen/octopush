import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopush/repository/game_data_repository.dart';
import 'package:octopush/routes.dart';
import 'package:octopush/screens/mutual_funds/mutual_funds_page.dart';
import 'package:octopush/screens/quiz_challenge_page.dart';
import 'package:octopush/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/user_bloc.dart';
import 'repository/user_repository.dart';
import 'root_page.dart';
import 'screens/minesweeper_page.dart';
import 'screens/mutual_funds_detail/mutual_funds_detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  var userRepo = UserRepository(prefs);
  var gameDataRepo = GameDataRepository(prefs);
  runApp(
    BlocProvider<UserBloc>(
      child: MyApp(),
      create: (_) => UserBloc(userRepo, gameDataRepo),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Octopush',
        routes: {
          '/' : (_) => RootPage(),
          '/minesweeper': (_) => MinesweeperPage(),
          '/quiz': (_) => QuizChallengeSplashPage(),
          routeMutualFunds: (_) => MutualFundsPage(),
          routeMutualFundsDetail: (_) => MutualFundsDetailPage()
        },
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: accentColor,
          scaffoldBackgroundColor: backgroundColor,
        ),
        initialRoute: '/',);
  }
}

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {

//   @override
//   Widget build(BuildContext context) {
//     return _userRepo == null && _gameDataRepo == null
//         ? Center(child: Text('Splash Screen'))
//         : BlocProvider(
//             create: (_) {
//               return UserBloc(_userRepo, _gameDataRepo);
//               },
//             child: RootPage(),
//           );
//   }
// }
