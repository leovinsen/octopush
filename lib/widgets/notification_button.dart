import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  final bool hasNotification;
  final Function onTap;

  const NotificationButton({Key key, this.hasNotification, this.onTap})
      : assert(hasNotification != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
          iconSize: 50,
          icon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          onPressed: onTap,
        ),
        hasNotification
            ? Positioned(
                top: 11,
                right: 5,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 15,
                    minHeight: 15,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
