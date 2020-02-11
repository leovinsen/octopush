import 'package:flutter/material.dart';
import 'package:octopush/styles.dart';

class QrSuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: backgroundColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/ic_happy_octo_employee_1.png',
              width: 200,
              height: 200,
            ),
            Container(
              width: 200,
              child: Text(
                'Congrats, you earned 1M IDR!',
                textAlign: TextAlign.center,
                style: largeTextStyleLight,
              ),
            ),
          ],
        ),
      );
  }
}