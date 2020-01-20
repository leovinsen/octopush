import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopush/bloc/user_bloc.dart';
import 'package:octopush/bloc/user_event.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
         return Center(
            child: RaisedButton(
              child: Text('Remove user'),
              onPressed: () => BlocProvider.of<UserBloc>(context).add(ClearData()),),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return BlocListener<UserDataBloc, UserDataState>(
  //     bloc: BlocProvider.of<UserDataBloc>(context),
  //     listener: (_, state){
  //       // if (state is UserDataBlocCreated){
  //       //   BlocProvider.of<UserDataBloc>(context).add(GetUserData());
  //       // }

  //       if (state is UserDataUninitialized){
  //         String name = BlocProvider.of<UserBloc>(context).activeUser.name;
  //         Navigator.of(context).push(MaterialPageRoute(builder: (_) => GameRulesPage(name)));
  //       }

  //       if (state is UserDataInitialized){}
  //     },

 

  //     );

  //   // return BlocBuilder<UserDataBloc, UserDataState>(
  //   //   bloc: BlocProvider.of<UserDataBloc>(context),
  //   //   builder: (_, state){
  //   //     if (state is UserDataBlocCreated){
  //   //       BlocProvider.of<UserDataBloc>(context).add(GetUserData());
  //   //     }

  //   //     if (state is UserDataUninitialized){
  //   //       return GameRulesPage();
  //   //     }

  //   //     if (state is UserDataInitialized){}
  //   //     return Center(child: Text('HomePage'),);
  //   //   },


  
}