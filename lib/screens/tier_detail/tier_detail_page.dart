import 'package:flutter/material.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/widgets/safe_scaffold.dart';
import 'package:percent_indicator/percent_indicator.dart';

const tierThreshold = [0, 50000000, 200000000];

class TierDetailPage extends StatelessWidget {
  final double trb;
  final int tier;
  final String imagePath;

  const TierDetailPage(
      {Key key,
      @required this.trb,
      @required this.tier,
      @required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: CircularPercentIndicator(
            lineWidth: 15.0,
            animation: true,
            animationDuration: 2000,
            circularStrokeCap: CircularStrokeCap.round,
            radius: 300.0,
            percent: _calculateRelativeProgress(),
            center: Image.asset(
              imagePath,
              width: 250,
              height: 250,
            ),
            footer: Column(
              children: <Widget>[
                SizedBox(height: 5.0,),
                Text('Tier $tier', style: titleStyleLight,),
                SizedBox(height: 5.0,),
                Text(
                  _getNextTarget(),
                  style: subtitleStyleLight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _calculateRelativeProgress() {
    if (tier == 3) return 1;
    return trb / tierThreshold[tier];
  }

  String _getNextTarget() {
    if (tier == 3) return 'You have reached the highest tier!';

    int trbInMillions = (trb / 1000000).round();
    int thresholdInMillions = (tierThreshold[tier] / 1000000).round();
    return 'Progress: ${trbInMillions}M / ${thresholdInMillions}M IDR ';
  }
}
