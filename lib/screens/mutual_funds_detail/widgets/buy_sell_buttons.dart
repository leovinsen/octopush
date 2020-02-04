import 'package:flutter/material.dart';

import 'custom_button.dart';

class BuySellButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CustomButton(
            color: Theme.of(context).accentColor,
            onPressed: () => print('a'),
            text: 'SELL',
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: CustomButton(
            color: Colors.green,
            onPressed: () => print('a'),
            text: 'BUY',
          ),
        ),
      ],
    );
  }
}
