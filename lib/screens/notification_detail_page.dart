import 'dart:math';

import 'package:flutter/material.dart';
import 'package:octopush/model/challenge.dart';
import 'package:octopush/widgets/challenge_description.dart';
import 'package:octopush/widgets/challenge_top_navigation.dart';
import 'package:octopush/widgets/payment_option_card.dart';
import 'package:octopush/widgets/safe_scaffold.dart';

import '../styles.dart';

const optionHeight = 140.0;

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
                amount: _getAmount(challenge),
              ),
              SizedBox(
                height: 10.0,
              ),
              challenge.lowestReward.isNegative
                  ? PaymentOptions()
                  : Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: RaisedButton(
                        onPressed: () => print(''),
                        color: Colors.green[900],
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Claim Rewards',
                            style: titleStyleLight,
                          ),
                        ),
                      ),
                  )
            ],
          ),
        ),
      ),
    );
  }

  int _getAmount(Challenge c) {
    int range = c.highestReward - c.lowestReward;

    if (range == 0) return c.highestReward;

    int random = Random.secure().nextInt(range);

    return c.highestReward - random;
  }
}

class PaymentOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 40.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'How would you like to pay?',
            style: subtitleStyleLight,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Table(
          children: <TableRow>[
            TableRow(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 4.0, bottom: 8.0),
                  child: PaymentOptionCard(
                    imagePath: 'assets/ic_octo_savers.png',
                    onTap: () => print(''),
                    label: 'Octo Savers',
                    height: optionHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: PaymentOptionCard(
                    imagePath: 'assets/ic_time_deposit.png',
                    label: 'Time Deposit',
                    height: optionHeight,
                  ),
                ),
              ],
            ),
            TableRow(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: PaymentOptionCard(
                    imagePath: 'assets/ic_mutual_funds.png',
                    label: 'Mutual Funds',
                    height: optionHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: PaymentOptionCard(
                    imagePath: 'assets/ic_bancassurance.png',
                    label: 'Bancassurance',
                    height: optionHeight,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
