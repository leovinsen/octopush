import 'package:flutter/material.dart';
import 'package:octopush/styles.dart';

class MutualFundsProductHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Product',
          style: largeTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          '5-yrs Hist. Yield',
          style: largeTextStyle.copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
