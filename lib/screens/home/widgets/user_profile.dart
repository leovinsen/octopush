import 'package:flutter/material.dart';
import 'package:octopush/screens/home/widgets/income_expenses_info.dart';
import 'package:octopush/screens/home/widgets/user_progress_indicator.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/utils/currency_utils.dart';

class UserProfile extends StatelessWidget {
  final int age;
  final String career;
  final double trb;
  final double income;
  final double expenses;

  const UserProfile(
      {Key key,
      @required this.age,
      @required this.career,
      @required this.trb,
      @required this.income,
      @required this.expenses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: _ProfileSegment(label: 'Your Age:', value: '$age')),
                Container(
                    height: 50,
                    child: VerticalDivider(
                      indent: 5,
                      endIndent: 5,
                      color: accentColor,
                      thickness: 1,
                    )),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      children: <Widget>[
                        _ProfileSegment(
                          label: 'Your Career:',
                          value: career,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        IncomeExpensesInfo(
                          income: income,
                          expenses: expenses,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            trb == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _TrbSegment(
                    trb: trb,
                  ),
          ],
        ),
      ),
    );
  }
}

class _TrbSegment extends StatelessWidget {
  final double trb;

  const _TrbSegment({Key key, this.trb}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _ProfileSegment(
              label: 'Your Current TRB:',
              value: CurrencyUtils.formatToIdr(trb),
            ),
            SizedBox(
              height: 10.0,
            ),
            UserProgressIndicator(
              tier: _getTier(),
            ),
          ],
        ),
        _getIcon(_getTier()),
      ],
    );
  }

  int _getTier() {
    int million = 1000 * 1000;

    if (trb > 200 * million) return 3;

    if (trb > 50 * million) return 2;

    return 1;
  }

  Widget _getIcon(int tier) {
    String path;

    switch (tier) {
      case 1:
        path = 'assets/ic_tier_1.png';
        break;
      case 2:
        path = 'assets/ic_tier_2.png';
        break;
      case 3:
        path = 'assets/ic_tier_3.png';
        break;
    }

    return Image.asset(
      path,
      width: 100,
      height: 100,
    );
  }
}

class _ProfileSegment extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileSegment({Key key, this.label, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: captionStyleAccent,
        ),
        Text(
          value,
          style: subtitleStyleAccent,
        )
      ],
    );
  }
}
