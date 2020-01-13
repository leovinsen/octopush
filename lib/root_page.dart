import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopush/bloc/user_data/user_data_bloc.dart';
import 'package:octopush/repository/user_data_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/user_bloc.dart';
import 'bloc/user_data/user_data_event.dart';
import 'bloc/user_event.dart';
import 'bloc/user_state.dart';
import 'screens/home_page.dart';
import 'screens/registration_page.dart';

class RootPage extends StatelessWidget {
  final SharedPreferences _prefs;

  RootPage(this._prefs);

  // TODO : Replace BlocBuilder with BlocListener to send Navigation events
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      bloc: BlocProvider.of<UserBloc>(context),
      builder: (_, state) {
        if (state is AppStarted) {
          BlocProvider.of<UserBloc>(context).add(GetUser());
        }

        if (state is UserFound) {
          return BlocProvider<UserDataBloc>(
            create: (_) { 
              var bloc = UserDataBloc(UserDataRepository(_prefs));
              bloc.add(GetUserData());
              return bloc;
              },
            child: HomePage(),
          );
        }

        if (state is UserNotFound) {
          return RegistrationPage();
        }

        return Center(
          child: Text('a'),
        );
      },
    );
  }
}
