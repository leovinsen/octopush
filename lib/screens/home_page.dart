import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopush/bloc/home/home_bloc.dart';
import 'package:octopush/bloc/home/home_event.dart';
import 'package:octopush/bloc/home/home_state.dart';
import 'package:octopush/bloc/user_bloc.dart';
import 'package:octopush/bloc/user_event.dart';
import 'package:octopush/model/challenge.dart';
import 'package:octopush/model/job.dart';
import 'package:octopush/model/time_interval.dart';
import 'package:octopush/screens/notification_list_page.dart';
import 'package:octopush/screens/quiz_challenge_page.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/utils/currency_utils.dart';
import 'package:octopush/utils/date_utils.dart';
import 'package:octopush/widgets/clickable_label.dart';
import 'package:octopush/widgets/notification_button.dart';
import 'package:octopush/widgets/yes_no_alert_dialog.dart';

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

  List<Challenge> challenges;

  @override
  void initState() {
    super.initState();
    name = BlocProvider.of<UserBloc>(context).activeUser.name.split(" ")[0];

    var gameData = BlocProvider.of<UserBloc>(context).gameData;
    career = gameData.job == Job.values[0] ? "Employee" : "Self-Employed";

    age = _calculateAge(gameData.currentInterval.index);
    day = _calculateDay(gameData.currentInterval.index);

    balance = BlocProvider.of<UserBloc>(context).gameData.balance;
    challenges = [];
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
        child: BlocListener<HomeBloc, HomeState>(
          bloc: BlocProvider.of<HomeBloc>(context),
          child: _body(context),
          listener: (BuildContext context, state) {
            print(state);
            if (state is HomeStateLoaded) {
              setState(() {
                age = _calculateAge(state.interval);
                day = _calculateDay(state.interval);
                challenges = state.challenges;
              });
            }

            if (state is HomeStateIncremented) {
              setState(() {
                age = _calculateAge(state.interval);
                day = _calculateDay(state.interval);
                challenges = state.challenges;
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
              SizedBox(
                height: 10.0,
              ),
              _aboutUser(context),
              SizedBox(
                height: 10.0,
              ),
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
              ClickableLabel(
                onTap: () => _incrementInterval(context),
                iconData: Icons.calendar_today,
                label: 'Advance day',
              ),
              ClickableLabel(
                onTap: () => _pushPage(
                  context,
                  MinesweeperPage(),
                ),
                iconData: Icons.games,
                label: 'Minesweeper',
              ),
              ClickableLabel(
                  onTap: () => _pushPage(
                        context,
                        QuizChallengeSplashPage(),
                      ),
                  iconData: Icons.question_answer,
                  label: 'Who Wants to be a Jutawan'),
              SizedBox(
                height: 20.0,
              ),
              ClickableLabel(
                onTap: () => _clearDataConfirmation(context),
                iconData: Icons.cancel,
                label: 'Clear game data',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _incrementInterval(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(IncrementInterval());
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
          NotificationButton(
            onTap: () => _pushPage(
                context,
                NotificationListPage(
                  challenges: challenges,
                )),
            hasNotification: _userHasNotification(),
          ),
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
              imageUrl: 'assets/ic_octo_savers.png',
              label: 'Octo Savers',
              onTap: () => _pushPage(context, OctoSaversPage()),
            ),
            _buildOptionsCard(
              imageUrl: 'assets/ic_time_deposit.png',
              label: 'Time Deposit',
            ),
            _buildOptionsCard(
              imageUrl: 'assets/ic_mutual_funds.png',
              label: 'Mutual Funds',
            ),
          ],
        ),
        Row(
          children: <Widget>[
            _buildOptionsCard(
              imageUrl: 'assets/ic_installments.png',
              label: 'Installments',
              onTap: () => _pushPage(context, InstallmentPage()),
            ),
            _buildOptionsCard(
              imageUrl: 'assets/ic_bancassurance.png',
              label: 'Bancassurance',
            ),
          ],
        )
      ],
    );
  }

  Widget _buildOptionsCard({String imageUrl, String label, Function onTap}) {
    assert(imageUrl != null);
    return Expanded(
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(0.0),
            width: 100,
            height: 100,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  imageUrl,
                  width: 50,
                  height: 50,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  label,
                  style: baseStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _clearDataConfirmation(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => YesNoAlertDialog(
              content:
                  'This will delete all of your progress and account information. Proceed?',
              onNoPressed: () => Navigator.of(context).pop(),
              onYesPressed: () {
                 Navigator.of(context).pop();
                BlocProvider.of<UserBloc>(context).add(ClearData());
              },
            ));
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => page,
    ));
  }

  bool _userHasNotification() {
    for (Challenge c in challenges) {
      if (!c.done) return true;
    }

    return false;
  }
}
