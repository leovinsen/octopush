import 'dart:math';

import 'package:flutter/material.dart';
import 'package:octopush/model/challenge.dart';
import 'package:octopush/screens/notification_detail/widgets/notification_detail_body.dart';
import 'package:octopush/widgets/challenge_description.dart';
import 'package:octopush/widgets/challenge_top_navigation.dart';
import 'package:octopush/widgets/safe_scaffold.dart';

class NotificationDetailPage extends StatelessWidget {
  final Challenge challenge;

  const NotificationDetailPage({Key key, this.challenge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ChallengeTopNavigation(),
              SizedBox(
                height: 10.0,
              ),
              ChallengeDescription(
                description: challenge.description,
                mood: challenge.mood,
                amount: _generateRandomAmount(challenge),
              ),
              SizedBox(
                height: 10.0,
              ),
              NotificationDetailBody(
                challenge: challenge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Generates a random value in the range of [Challenge.lowestReward] to [Challenge.highestReward]
  int _generateRandomAmount(Challenge c) {
    int range = c.highestReward - c.lowestReward;

    if (range == 0) return c.highestReward;

    int random = Random.secure().nextInt(range);

    return c.highestReward - random;
  }
}
