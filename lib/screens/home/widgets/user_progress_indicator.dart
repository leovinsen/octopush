import 'package:flutter/material.dart';
import 'package:octopush/styles.dart';

class UserProgressIndicator extends StatelessWidget {
  final int rank;

  const UserProgressIndicator({Key key, this.rank})
      : assert(rank != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Current rank:',
              style: captionStyleAccent,
            ),
            Row(
              children: <Widget>[
                Text(
                  'Rank $rank',
                  style: subtitleStyleAccent,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Icon(
                  Icons.info,
                  size: 25,
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
