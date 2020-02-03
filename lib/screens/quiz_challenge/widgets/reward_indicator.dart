import 'package:flutter/material.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/utils/currency_utils.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RewardIndicator extends StatefulWidget {
  double currentReward;
  double nextReward;
  double maxReward;

  RewardIndicator({this.currentReward, this.nextReward, this.maxReward})
      : assert(currentReward != null),
        assert(nextReward != null),
        assert(maxReward != null);

  @override
  _RewardIndicatorState createState() => _RewardIndicatorState();
}

class _RewardIndicatorState extends State<RewardIndicator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Reward: ',
              style: subtitleStyleLight,
            ),
            SizedBox(
              width: 0.0,
            ),
            Flexible(
              child: LinearPercentIndicator(
                // width: MediaQuery.of(context).size.width,
                animation: true,
                lineHeight: 25.0,
                animationDuration: 1000,
                percent: _calculatePercent(),
                center: Text(
                  _getWinningsText(),
                  style: largeTextStyle.copyWith(color: Colors.white),
                ),
                linearStrokeCap: LinearStrokeCap.butt,
                progressColor: accentColor,
                backgroundColor: Colors.grey,
              ),
            ),
          ],
        ),
        // SizedBox(height: 10.0,),
        // Text('Next: ${_getNextRewardText()} ', style: captionStyleLight,)
      ],
    );
  }

  double _calculatePercent() {
    return widget.currentReward / widget.maxReward;
  }

  String _getWinningsText() {
    return CurrencyUtils.formatToIdr(widget.currentReward);
  }

  // String _getNextRewardText(){
  //   return CurrencyUtils.formatToIdr(widget.nextReward);
  // }
}
