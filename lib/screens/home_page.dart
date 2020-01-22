import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:octopush/bloc/user_bloc.dart';
import 'package:octopush/bloc/user_event.dart';
import 'package:octopush/model/job.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/utils/date_utils.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      // appBar: AppBar(
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.mail),
      //       onPressed: () => print('notifications'),
      //     )
      //   ],
      // ),
      // drawer: Drawer(),
      body: SafeArea(child: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      // color: Color(0xFF262626),
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTimeLabel(context),
              SizedBox(
                height: 10.0,
              ),
              _greetings(context),
              SizedBox(
                height: 10.0,
              ),
              _buildLabel(context, Icons.person, 'About you'),
              _aboutUser(context),
              _buildLabel(context, Icons.attach_money, 'Your Options'),
              SizedBox(
                height: 20.0,
              ),
              _yourOptions(),
              SizedBox(
                height: 20.0,
              ),
              _buildLabel(
                  context, Icons.history, 'Click to see transaction history')
            ],
          ),
        ),
      ),
    );
  }

  Widget _greetings(BuildContext context) {
    var name = BlocProvider.of<UserBloc>(context).activeUser.name.split(" ")[0];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).accentColor,
      ),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hey, $name!',
                style: titleStyle.copyWith(color: Colors.white),
              ),
              Text(
                "It's day 1 out of 12",
                style: subtitleStyle.copyWith(color: Colors.white),
              ),
            ],
          ),
          IconButton(
            iconSize: 50,
            icon: Icon(
              Icons.email,
              color: Colors.white,
            ),
            onPressed: () => print('notif'),
          )
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context, IconData iconData, String label) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).accentColor,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            iconData,
            color: Colors.white,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            label,
            style: captionStyleLight,
          )
        ],
      ),
    );
  }

  Widget _buildTimeLabel(BuildContext context) {
    var dt = DateTime.now();

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).accentColor,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              DateUtils.formatDate(dt),
              style: smallTextStyleLight,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Local time: ${DateUtils.formatTime(dt)}',
              style: smallTextStyleLight,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _aboutUser(BuildContext context) {
    var job = BlocProvider.of<UserBloc>(context).gameData.job;
    var jobStr = job == Job.values[0] ? "Employee" : "Self-Employed";

    var balance = BlocProvider.of<UserBloc>(context).gameData.balance;
    var balanceStr = FlutterMoneyFormatter(
        amount: balance,
        settings: MoneyFormatterSettings(
          symbol: 'IDR',
          thousandSeparator: '.',
          decimalSeparator: '.',
          fractionDigits: 2,
        ));

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child:
                      _buildAboutYouSegment(label: 'Your Age:', value: '20')),
              Container(
                  height: 50,
                  child: VerticalDivider(
                    indent: 5,
                    endIndent: 5,
                    color: Colors.black87,
                    thickness: 1,
                  )),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: _buildAboutYouSegment(
                        label: 'Your Career:', value: jobStr),
                  )),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: _buildAboutYouSegment(
                label: 'Your Current TRB:', value: balanceStr.output.symbolOnLeft),
          )
        ],
      ),
    );
  }

  Widget _buildAboutYouSegment({String label, String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: captionStyle,
        ),
        Text(
          value,
          style: subtitleStyle,
        )
      ],
    );
  }

  Widget _yourOptions() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildOptionsCard(label: 'Octo Savers'),
            _buildOptionsCard(label: 'Time Deposit'),
            _buildOptionsCard(label: 'Mutual Funds'),
          ],
        ),
        Row(
          children: <Widget>[
            _buildOptionsCard(label: 'Installments'),
            _buildOptionsCard(label: 'Bancassurance'),
          ],
        )
      ],
    );
  }

  Widget _buildOptionsCard({String label}) {
    return Expanded(
      child: Card(
        child: InkWell(
          onTap: () => print(''),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            width: 110,
            height: 150,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/logo_cimb.png'),
                Text(
                  label,
                  style: baseStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _clearData(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(ClearData());
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
