import 'package:flutter/material.dart';
import 'package:octopush/screens/career_choice_page.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/widgets/simple_alert_dialog.dart';

class GameRulesPage extends StatefulWidget {
  final String userName;

  GameRulesPage(this.userName);

  @override
  _GameRulesPageState createState() => _GameRulesPageState();
}

class _GameRulesPageState extends State<GameRulesPage> {
  final String description =
      "Congratulations, you've been listed in this race!";

  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Card(
              color: Theme.of(context).accentColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hey, ${widget.userName}!',
                      textAlign: TextAlign.justify,
                      style: subtitleStyleLight,
                    ),
                    Text(
                      description,
                      style: baseStyleLight,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RulesSegment(),
            SizedBox(
              height: 20.0,
            ),
            DisclaimerSegment()
          ],
        ),
      ),
    );
  }
}

class RulesSegment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).accentColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                  Center(
                    child: Text(
                      'Game Rules',
                      textAlign: TextAlign.center,
                      style: titleStyleLight,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  )
                ] +
                _buildRulesList()),
      ),
    );
  }

  List<Widget> _buildRulesList() {
    return <Widget>[
      _buildText(
          '1. The game lasts for 12 days, beginning from when you first register. '),
      _buildV10Gap(),
      _rule2(),
      _buildV10Gap(),
      _rule3(),
      _buildV10Gap(),
      _rule4(),
      _buildV10Gap(),
      _rule5(),
      _buildV10Gap(),
      _rule6(),
      _buildV10Gap(),
      _rule7(),
      _buildV10Gap(),
      _rule8(),
      _buildV10Gap(),
      _rule9(),
      _buildV10Gap(),
      _rule10(),
      _buildV10Gap(),
      _rule11()
    ];
  }

  Widget _rule2() {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: baseStyleLight,
        children: <TextSpan>[
          _buildSpan(text: '2. The goal is to accumulate as much'),
          _buildSpanBold(text: ' Total Relationship Balance (TRB) '),
          _buildSpan(text: 'as possible by the end of the 12 days’ period.'),
          // _buildSpan(
          //     text:
          //         'as possible by the end of the 12 days’ period. Hereby the minimum task list: '),
          // _buildSpan(text: '\n\t\t\t\ta. Have a '),
          // _buildSpanBold(text: 'minimum '),
          // _buildSpan(text: 'TRB of IDR xxx.'),
          // _buildSpan(text: '\n\t\t\t\tb. Have a usable Car & House'),
        ],
      ),
    );
  }

  Widget _rule3() {
    return _buildText(
        '3. Be reminded that every action has its own implications, so be wary of your financial and investment decisions! ' +
            'The game progresses in a way that replicates potential challenges and decisions in real life. ');
  }

  Widget _rule4() {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: baseStyleLight,
        children: <TextSpan>[
          _buildSpan(text: '4. There are '),
          _buildSpanBold(text: '2 sessions '),
          _buildSpan(
              text:
                  'per day (Session 1: 9:00-12:00, Session 2: 15:00-18:00), each representing 2.5 years of virtual life time. Meaning for the entire 12 days, you will be experiencing a total of '),
          _buildSpanBold(text: '55 '),
          _buildSpan(text: 'virtual life time (Age 20-75)'),
        ],
      ),
    );
  }

  Widget _rule5() {
    return _buildText(
        '5. The game will only be playable during the mentioned sessions above. You are still allowed to look at your portfolio throughout the day, however no actions/ change can be made. ');
  }

  Widget _rule6() {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: baseStyleLight,
        children: <TextSpan>[
          _buildSpan(
            text:
                '6. You will receive 1 challenge per session, be sure to always check your mail. Challenge decision will expire at the end of the ',
          ),
          _buildSpanBold(text: 'same '),
          _buildSpan(text: 'session, so decide fast!')
        ],
      ),
    );
  }

  Widget _rule7() {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: baseStyleLight,
        children: <TextSpan>[
          _buildSpan(
            text:
                '7. You have 2 career choices; Employee and Entrepreneur, each with its own characteristics (income stability, fluctuations, and etc). You can only change your career ',
          ),
          _buildSpanBold(text: 'once.')
        ],
      ),
    );
  }

  Widget _rule8() {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: baseStyleLight,
        children: <TextSpan>[
          _buildSpan(
            text: '8. Every decision you made is ',
          ),
          _buildSpanBold(text: 'permanent.')
        ],
      ),
    );
  }

  Widget _rule9() {
    return _buildText(
        '9. You are given few financial instruments throughout the game. Make sure to read all the explanation and key points in each type of products.');
    // return _buildText(
    //     '9. Failure in payments / installments will receive in the deduction of TRB by the following liquidity ranking: (1) Octo Savers (2) Time Deposit.');
  }

  Widget _rule10() {
    return _buildText(
        '10. The game contains probability and randomization; hence you might receive a different challenge as your friends. No cheating!');
  }

  Widget _rule11() {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: baseStyleLight,
        children: <TextSpan>[
          _buildSpanBold(
            text: '11. Summary: ',
          ),
          _buildSpan(
              text:
                  'Accumulate as much money as possible with your own financial strategy, whilst taking on real-life like challenges and problems. Good luck!')
        ],
      ),
    );
  }
}

class DisclaimerSegment extends StatefulWidget {
  @override
  _DisclaimerSegmentState createState() => _DisclaimerSegmentState();
}

class _DisclaimerSegmentState extends State<DisclaimerSegment> {
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).accentColor,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
                  Text(
                    'Disclaimer',
                    textAlign: TextAlign.center,
                    style: titleStyleLight,
                  ),
                  SizedBox(
                    height: 20.0,
                  )
                ] +
                _buildDisclaimerList() +
                [
                  _buildCheckboxAgreement(context),
                  _buildButtonSubmit(context),
                ],
          ),
        ));
  }

  List<Widget> _buildDisclaimerList() {
    return <Widget>[
      RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style: baseStyleLight,
          children: <TextSpan>[
            _buildSpan(
              text:
                  '1. The rates and other financial calculations used is for illustration and learning purposes only, hence mentioned products or services might not reflect the ',
            ),
            _buildSpanBold(text: 'actual '),
            _buildSpan(text: 'ones in real life. ')
          ],
        ),
      ),
      _buildV10Gap(),
      _buildText(
          '2. CIMB Niaga do not provide any financial advices with and throughout the game.'),
      _buildV10Gap(),
      _buildText(
          '3. The application has the right to store all necessary data.')
    ];
  }

  Widget _buildCheckboxAgreement(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Checkbox(
              value: _agreeToTerms,
              onChanged: (val) {
                setState(() {
                  _agreeToTerms = val;
                });
              },
              checkColor: Colors.white,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: Theme.of(context).primaryColorDark),
        ),
        Text(
          'I hereby agree to terms & conditions',
          style: baseStyleLight,
        )
      ],
    );
  }

  Widget _buildButtonSubmit(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      textColor: Colors.black,
      onPressed: () => _next(context),
      child: Text('Next', style: captionStyleAccent,),
    );
  }

  void _next(BuildContext context) {
    if (_agreeToTerms) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => CareerChoicePage()));
    } else {
      showDialog(
          context: context,
          builder: (_) => SimpleAlertDialog(
              'You have not agreed to the terms & conditions'));
    }
  }
}

Text _buildText(String text) {
  return Text(
    text,
    textAlign: TextAlign.justify,
    style: baseStyleLight,
  );
}

TextStyle _bold() {
  return baseStyleLight.copyWith(fontWeight: FontWeight.bold);
}

SizedBox _buildV10Gap() {
  return SizedBox(
    height: 10.0,
  );
}

TextSpan _buildSpan({String text}) {
  return TextSpan(text: text);
}

TextSpan _buildSpanBold({String text}) {
  return TextSpan(text: text, style: _bold());
}
