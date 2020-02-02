import 'package:flutter/material.dart';
import 'package:octopush/styles.dart';

class NotificationActionButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const NotificationActionButton({Key key, this.text, this.onPressed})
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: RaisedButton(
        onPressed: onPressed,
        color: Colors.green[900],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            text,
            style: titleStyleLight,
          ),
        ),
      ),
    );
  }
}
