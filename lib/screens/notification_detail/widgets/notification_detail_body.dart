import 'package:flutter/material.dart';
import 'package:octopush/model/challenge.dart';
import 'package:octopush/model/time_interval.dart';

import 'notification_action_button.dart';
import 'payment_options.dart';

class NotificationDetailBody extends StatelessWidget {
  final Challenge challenge;

  const NotificationDetailBody({Key key, this.challenge}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Hardcode special cases
    switch (challenge.timeInterval) {
      case TimeInterval.DAY1_B:
        //Open Minesweeper page
        return NotificationActionButton(
          text: 'Play Now!',
          onPressed: () => Navigator.of(context).pushNamed('/minesweeper') ,
        );
        break;
      case TimeInterval.DAY2_B:
        //Car
        break;
      case TimeInterval.DAY5_A:
        //House
        break;
      case TimeInterval.DAY11_B:
        //Open Who Wants To Be A Jutawan game
        return NotificationActionButton(
          text: 'Play Now!',
          onPressed: () => Navigator.of(context).pushNamed('/quiz') ,
        );
        break;
      default:
        break;
    }

    //Most notifications will use the following Widget
    return challenge.lowestReward.isNegative
        ? PaymentOptions()
        : NotificationActionButton(
          text: 'Claim Rewards',
          onPressed: null,
        );
  }
}
