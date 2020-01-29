import 'package:flutter/material.dart';
import 'package:octopush/styles.dart';

class ChallengeTopNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        Flexible(
          child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                'You have 2 hours 59 minutes to decide!',
                style:
                    largeTextStyleAccent.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
