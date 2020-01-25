import 'package:flutter/material.dart';
import 'package:octopush/screens/career_choice_page.dart';
import 'package:octopush/styles.dart';

class GameRulesPage extends StatelessWidget {
  final String userName;

  GameRulesPage(this.userName);

  final String description = 'Welcome aboard Octo-push!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(40.0),
          children: <Widget>[
                Text(
                  'Hey, $userName!',
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
                SizedBox(
                  height: 20.0,
                )
              ] +
              _buildRulesList() +
              [
                RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Colors.white,
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => CareerChoicePage())),
                  child: Text('UNDERSTOOD!'),
                )
              ],
        ),
      ),
    );
  }

  // List<Widget> _buildRulesList() {
  //   return rules
  //       .map((rule) => Padding(
  //             padding: const EdgeInsets.only(bottom: 8.0),
  //             child: Text(
  //               rule,
  //               style: baseStyle,
  //             ),
  //           ))
  //       .toList();
  // }
  List<Widget> _buildRulesList() {
    return <Widget>[
      _buildText(
          '1. The game lasts for 12 days, beginning from when you first register. '),
      SizedBox(height: 10.0,),
      RichText(
        text: TextSpan(
          style: baseStyle.copyWith(color: Colors.black),
          children: <TextSpan>[
            _buildSpan(text: '2. The goal is to accumulate as much'),
            _buildSpanBold(text: ' Total Relationship Balance (TRB) '),
            _buildSpan(text: 'as possible by the end of the 12 days’ period. Hereby the minimum task list: '),
            _buildSpan(text: '\n\t\t\t\ta. Have a '),
            _buildSpanBold(text: 'minimum '),
            _buildSpan(text: 'TRB of IDR xxx.'),
            _buildSpan(text: '\n\t\t\t\tb. Have a usable Car & House'),
          ],
        ),
      ),
      SizedBox(height: 10.0,),
      _buildText('3. Be reminded that every action has its own implications, so be wary of your financial and investment decisions! ' +
        'The game progresses in a way that replicates potential challenges and decisions in real life. '),
      
    ];
  }

  TextSpan _buildSpan({String text}){
    return TextSpan(text: text);
  }

  TextSpan _buildSpanBold({String text}){
    return TextSpan(text: text, style: _bold());
  }
  final List rules = [
    '4. There are 2 sessions per day (Session 1: 9:00-12:00, Session 2: 15:00-18:00), each representing 2.5 years of virtual life time. '
        'Meaning for the entire 12 days, you will be experiencing a total of 60 virtual life time (Age 20-75)',
    '5. The game will only be playable during the mentioned sessions above.',
    '6. You will receive 1 challenge per session, be sure to always check your mail. '
        'Challenge decision will expire at the end of the same session, so decide fast!',
    '7. You have 2 career choices; Employee and Entrepreneur, each with its own characteristics ' +
        '(income stability, fluctuations, and etc). You can only change your career once.',
    '8. Every decision you made is <b>permanent</b>.',
    '9. Failure in payments / installments will receive in the deduction of TRB by the following liquidity ranking: (1) Octo Savers (2) Time Deposit. ',
    '10. The game contains probability and randomization; hence you might receive a different challenge as your friends. No cheating!',
    '11. <b>Summary:</b> Accumulate as much money as possible with your own financial strategy, whilst taking on real-life like challenges and problems. Good luck!'
  ];

  Text _buildText(String text) {
    return Text(
      text,
      style: baseStyle,
    );
  }

  TextStyle _bold(){
    return baseStyle.copyWith(fontWeight: FontWeight.bold);
  }
}
