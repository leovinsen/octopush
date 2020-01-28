import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopush/bloc/interval/interval_bloc.dart';
import 'package:octopush/bloc/interval/interval_event.dart';
import 'package:octopush/bloc/interval/interval_state.dart';
import 'package:octopush/bloc/user_bloc.dart';
import 'package:octopush/bloc/user_event.dart';
import 'package:octopush/model/job.dart';
import 'package:octopush/model/time_interval.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/utils/currency_utils.dart';
import 'package:octopush/utils/date_utils.dart';

import 'installment_page.dart';
import 'minesweeper_page.dart';
import 'octo_savers_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name;
  int age;
  int day;
  String career;
  double balance;

  @override
  void initState() {
    super.initState();
    name = BlocProvider.of<UserBloc>(context).activeUser.name.split(" ")[0];

    var gameData = BlocProvider.of<UserBloc>(context).gameData;
    career = gameData.job == Job.values[0] ? "Employee" : "Self-Employed";

    age = _calculateAge(gameData.currentInterval.index);
    day = _calculateDay(gameData.currentInterval.index);

    balance = BlocProvider.of<UserBloc>(context).gameData.balance;
  }

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
      body: SafeArea(
        child: BlocListener<IntervalBloc, IntervalState>(
          child: _body(context),
          listener: (BuildContext context, state) {
            if (state is IntervalUpdated) {
              setState(() {
                age = _calculateAge(state.interval);
                day = _calculateDay(state.interval);
              });

              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Text(
                      "Day advanced - now it's day $day session ${state.interval % 2 + 1}"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('OK'),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  ///for [currentInterval] see [TimeInterval].
  int _calculateAge(int intervalIndex) {
    int ageOffset = ((intervalIndex) / 2).floor() * 5;
    return 20 + ageOffset;
  }

  int _calculateDay(int intervalIndex) {
    int day = ((intervalIndex) / 2).floor() + 1;
    return day;
  }

  Widget _body(BuildContext context) {
    return Container(
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
              SizedBox(height: 10.0,),
              _aboutUser(context),
              SizedBox(height: 10.0,),
              _buildLabel(context, Icons.attach_money, 'Your Options'),
              SizedBox(
                height: 20.0,
              ),
              _yourOptions(context),
              SizedBox(
                height: 20.0,
              ),
              _buildLabel(
                context,
                Icons.history,
                'Click to see transaction history',
              ),
              InkWell(
                onTap: () => _incrementInterval(context),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: _buildLabel(
                    context,
                    Icons.calendar_today,
                    'Advance day',
                  ),
                ),
              ),
              InkWell(
                onTap: () => _clearData(context),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: _buildLabel(
                    context,
                    Icons.cancel,
                    'Clear game data',
                  ),
                ),
              ),
              InkWell(
                  onTap: () => _pushPage(context, MinesweeperPage()),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: _buildLabel(context, Icons.games, 'Minesweeper'),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _incrementInterval(BuildContext context) {
    BlocProvider.of<IntervalBloc>(context).add(IncrementInterval());
  }

  Widget _greetings(BuildContext context) {
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
                "It's day $day out of 12",
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
    return Card(
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: _buildAboutYouSegment(
                        label: 'Your Age:', value: '$age')),
                Container(
                    height: 50,
                    child: VerticalDivider(
                      indent: 5,
                      endIndent: 5,
                      color: accentColor,
                      thickness: 1,
                    )),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: _buildAboutYouSegment(
                          label: 'Your Career:', value: career),
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: _buildAboutYouSegment(
                  label: 'Your Current TRB:',
                  value: CurrencyUtils.formatToIdr(balance)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAboutYouSegment({String label, String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: captionStyleAccent,
        ),
        Text(
          value,
          style: subtitleStyleAccent,
        )
      ],
    );
  }

  Widget _yourOptions(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildOptionsCard(
              label: 'Octo Savers',
              onTap: () => _pushPage(context, OctoSaversPage()),
            ),
            _buildOptionsCard(
              label: 'Time Deposit',
            ),
            _buildOptionsCard(
              label: 'Mutual Funds',
            ),
          ],
        ),
        Row(
          children: <Widget>[
            _buildOptionsCard(
              label: 'Installments',
              onTap: () => _pushPage(context, InstallmentPage()),
            ),
            _buildOptionsCard(
              label: 'Bancassurance',
            ),
          ],
        )
      ],
    );
  }

  Widget _buildOptionsCard({String label, Function onTap}) {
    return Expanded(
      child: Card(
        child: InkWell(
          onTap: onTap,
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

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => page,
    ));
  }
}
