import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;

  const PrimaryButton({Key key, this.onPressed, this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColorDark,
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text('$buttonText'),
    );
  }
}
