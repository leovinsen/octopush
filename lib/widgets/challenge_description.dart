import 'dart:math';

import 'package:flutter/material.dart';
import 'package:octopush/model/mood.dart';
import 'package:octopush/styles.dart';

const List<String> sadIconPath = [
  'ic_sad_octo_employee_1.png',
  'ic_sad_octo_employee_2.png',
  'ic_sad_octo_self_employed_1.png',
  'ic_sad_octo_self_employed_2.png',
];

const List<String> happyIconPath = [
  'ic_happy_octo_employee_1.png',
  'ic_happy_octo_employee_2.png',
  'ic_happy_octo_self_employed_1.png',
  'ic_happy_octo_self_employed_2.png',
];

class ChallengeDescription extends StatelessWidget {
  final String description;
  final Mood mood;
  final int amount;

  ///amount of cash paid / received in Million IDR

  const ChallengeDescription(
      {Key key, this.description, this.mood, this.amount})
      : assert(description != null),
        assert(mood != null),
        assert(amount != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).accentColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            _getOctoImage(),
            height: 100,
            width: 75,
          ),
          Flexible(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    description,
                    style: baseStyleLight,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    amount.isNegative
                        ? 'Cost: ${amount.abs()} Million IDR'
                        : 'Reward: $amount Million IDR',
                    style: captionStyleLight,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String _getOctoImage() {
    var path = "assets/";
    var randomIndex = Random.secure().nextInt(4);

    switch (mood) {
      case Mood.SAD:
        path += sadIconPath[randomIndex];
        break;
      case Mood.HAPPY:
        path += happyIconPath[randomIndex];
        break;
    }

    return path;
  }
}
