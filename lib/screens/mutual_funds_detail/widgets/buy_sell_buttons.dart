import 'package:flutter/material.dart';

import 'custom_button.dart';

class BuySellButtons extends StatelessWidget {
  final Function onBuyPressed;
  final Function onSellPressed;

  const BuySellButtons({Key key, this.onBuyPressed, this.onSellPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CustomButton(
            color: Theme.of(context).accentColor.withOpacity(0.3),
            onPressed: onSellPressed,
            text: 'SELL',
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: CustomButton(
            color: Colors.green,
            onPressed: onBuyPressed,
            text: 'BUY',
          ),
        ),
      ],
    );
  }
}
