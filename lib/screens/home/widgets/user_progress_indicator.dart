import 'package:flutter/material.dart';
import 'package:octopush/screens/tier_detail/tier_detail_page.dart';
import 'package:octopush/styles.dart';

class UserProgressIndicator extends StatelessWidget {
  final int tier;
  final double trb;
  final String imagePath;

  const UserProgressIndicator({Key key, this.tier, this.trb, this.imagePath})
      : assert(tier != null),
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
              'Current tier:',
              style: captionStyleAccent,
            ),
            Row(
              children: <Widget>[
                Text(
                  'Tier $tier',
                  style: subtitleStyleAccent,
                ),
                SizedBox(
                  width: 5.0,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TierDetailPage(
                          trb: trb, tier: tier, imagePath: imagePath),
                    ),
                  ),
                  child: Icon(
                    Icons.info,
                    size: 25.0,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
