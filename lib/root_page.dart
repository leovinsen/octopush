import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopush/screens/game_rules_page.dart';

import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';
import 'bloc/user_state.dart';
import 'screens/home_page.dart';
import 'screens/registration_page.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        bloc: BlocProvider.of<UserBloc>(context),
        builder: (_, state) {
          print('state: $state');
          if (state is UserNotFound) {
            return _animatePage(RegistrationPage());
          }

          if (state is UserAdded) {
            return _animatePage(GameRulesPage(state.name));
          }

          if (state is GameDataFound) {
            return _animatePage(HomePage());
          }

          if (state is GameDataNotFound) {
            return _animatePage(GameRulesPage(state.name));
          }

          if (state is DataCleared) {
            return _animatePage(RegistrationPage());
          }

          BlocProvider.of<UserBloc>(context).add(GetUser());
          return Center(
            child: Text('Splash page'),
          );
        });
  }

  Widget _animatePage(Widget widget) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 250),
      child: widget,
      // transitionBuilder: (Widget child, Animation<double> animation) {
      //   return SlideTransition(
      //     position: Tween<Offset>(
      //       begin: const Offset(0, 0.25),
      //       end: Offset.zero,
      //     ).animate(animation),
      //     child: child,
      //   );
      // },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return BlocListener(
  //     listener: (_, state) {
  //       if (state is UserNotFound) {
  //         _pushPage(context, RegistrationPage());
  //       }

  //       if (state is UserAdded) {
  //         _pushPage(context, GameRulesPage(state.name));
  //       }

  //       if (state is GameDataFound) {
  //         _pushPage(context, HomePage());
  //       }

  //       if (state is GameDataNotFound) {
  //         _pushPage(context, GameRulesPage(state.name));
  //       }

  //       if (state is DataCleared) {
  //         _pushPage(context, RegistrationPage());
  //       }
  //     },
  //     bloc: BlocProvider.of<UserBloc>(context),
  //     child: Center(
  //       child: Text('Splash Page'),
  //     ),
  //   );
  // }

  // void _pushPage(BuildContext context, Widget screen) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(builder: (_) => screen),
  //   );
  // }
}
