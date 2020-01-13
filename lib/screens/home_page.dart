import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopush/bloc/user_data/user_data_bloc.dart';
import 'package:octopush/bloc/user_data/user_data_event.dart';
import 'package:octopush/bloc/user_data/user_data_state.dart';

import 'career_choice_page.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<UserDataBloc, UserDataState>(
      bloc: BlocProvider.of<UserDataBloc>(context),
      builder: (_, state){
        if (state is UserDataBlocCreated){
          BlocProvider.of<UserDataBloc>(context).add(GetUserData());
        }

        if (state is UserDataUninitialized){
          return CareerChoicePage();
        }

        return Container();
      },


      );
    // return Center(
    //         child: RaisedButton(
    //           child: Text('Remove user'),
    //           onPressed: () => BlocProvider.of<UserBloc>(context).add(ClearUser()),),
    // );
  }
}