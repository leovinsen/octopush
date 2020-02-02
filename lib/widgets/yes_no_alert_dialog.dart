import 'package:flutter/material.dart';

class YesNoAlertDialog extends StatelessWidget {
  final String content;
  final Function onNoPressed;
  final Function onYesPressed;

  const YesNoAlertDialog(
      {Key key, this.onNoPressed, this.onYesPressed, this.content})
      : assert(content != null),
        assert(onNoPressed != null),
        assert(onYesPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          child: Text('NO'),
          onPressed: onNoPressed,
        ),
        FlatButton(
          child: Text('YES'),
          onPressed: onYesPressed,
        )
      ],
    );
  }
}
