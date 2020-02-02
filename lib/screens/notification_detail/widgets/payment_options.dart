import 'package:flutter/material.dart';
import 'package:octopush/styles.dart';

import 'payment_option_card.dart';

const _widgetHeight = 140.0;

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
                    height: _widgetHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: PaymentOptionCard(
                    imagePath: 'assets/ic_time_deposit.png',
                    label: 'Time Deposit',
                    height: _widgetHeight,
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
                    height: _widgetHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: PaymentOptionCard(
                    imagePath: 'assets/ic_bancassurance.png',
                    label: 'Bancassurance',
                    height: _widgetHeight,
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
