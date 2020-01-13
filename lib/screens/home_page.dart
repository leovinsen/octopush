import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopush/bloc/user_bloc.dart';
import 'package:octopush/bloc/user_data/user_data_bloc.dart';
import 'package:octopush/bloc/user_data/user_data_event.dart';
import 'package:octopush/bloc/user_data/user_data_state.dart';
import 'package:octopush/bloc/user_event.dart';
import 'package:octopush/screens/game_rules_page.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserDataBloc, UserDataState>(
      bloc: BlocProvider.of<UserDataBloc>(context),
      listener: (_, state){
        // if (state is UserDataBlocCreated){
        //   BlocProvider.of<UserDataBloc>(context).add(GetUserData());
        // }

        if (state is UserDataUninitialized){
          String name = BlocProvider.of<UserBloc>(context).activeUser.name;
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => GameRulesPage(name)));
        }

        if (state is UserDataInitialized){}
      },

      child: Center(
            child: RaisedButton(
              child: Text('Remove user'),
              onPressed: () => BlocProvider.of<UserDataBloc>(context).add(ClearUserData()),),
    )

      );

    // return BlocBuilder<UserDataBloc, UserDataState>(
    //   bloc: BlocProvider.of<UserDataBloc>(context),
    //   builder: (_, state){
    //     if (state is UserDataBlocCreated){
    //       BlocProvider.of<UserDataBloc>(context).add(GetUserData());
    //     }

    //     if (state is UserDataUninitialized){
    //       return GameRulesPage();
    //     }

    //     if (state is UserDataInitialized){}
    //     return Center(child: Text('HomePage'),);
    //   },


    
  }
}