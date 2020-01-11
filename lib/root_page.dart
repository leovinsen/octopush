import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';
import 'bloc/user_state.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      bloc: BlocProvider.of<UserBloc>(context),
      builder: (_, state) {
        if (state is AppStarted) {
          BlocProvider.of<UserBloc>(context).add(GetUser());
          return Container();
        }

        if (state is UserFound) {
          return Center(
            child: Text('Home page'),
          );
        }

        if (state is UserNotFound) {
          return Center(
            child: Text('Onboarding page'),
          );
        }

        return Container();
      },
    );
  }
}