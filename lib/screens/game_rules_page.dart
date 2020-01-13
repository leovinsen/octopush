import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopush/bloc/user_bloc.dart';
import 'package:octopush/styles.dart';

class GameRulesPage extends StatelessWidget {
  final String description =
      '(Description here) Welcome aboard Octo-push!';

  final List rules = [
    '1. This is a 12 days challenge race.',
    '2. Manage and generate your money as much as possible.',
    '3. Remember to consider the proportional budgeting concept.',
    '4. You will be facing 2 challenges and/or options per day (9AM and 3PM).',
    '5. You have 3 hours to make a decision.',
    '6. Your age will be increased by 5 game years in each day (age range: 20 to 75 yo).'
  ];

  @override
  Widget build(BuildContext context) {
    var user = BlocProvider.of<UserBloc>(context).activeUser;

    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(40.0),
          children: <Widget>[
                Text(
                  'Hey, ${user.name}!',
                  textAlign: TextAlign.justify,
                  style: subtitleStyle,
                ),
                Text(
                  description,
                  style: baseStyle,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Game Rules',
                  textAlign: TextAlign.center,
                  style: titleStyle,
                ),
                SizedBox(height: 20.0,)
              ] + _buildRulesList() +
              [
                RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Colors.white,
                  onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => Center())),
                  child: Text('UNDERSTOOD!'),
                )
              ],
        ),
      ),
    );
  }

  List<Widget> _buildRulesList(){
    return rules.map((rule) => Text(rule, style: baseStyle,)).toList();
  }
}
