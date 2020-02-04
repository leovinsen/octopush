import 'package:flutter/material.dart';
import 'package:octopush/styles.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final Function onPressed;
  final String text;

  const CustomButton({Key key, this.color, this.onPressed, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: color),
        child: Text('SELL', style: titleStyleLight),
      ),
    );
  }
}
