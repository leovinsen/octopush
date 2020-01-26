import 'package:flutter/material.dart';
import 'package:octopush/styles.dart';

class SimpleAlertDialog extends StatelessWidget {

  final String text;
  const SimpleAlertDialog(this.text);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(text, style: baseStyle,),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}
