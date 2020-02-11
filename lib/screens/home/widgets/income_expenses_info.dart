import 'package:flutter/material.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/utils/currency_utils.dart';

class IncomeExpensesInfo extends StatelessWidget {
  final GlobalKey _tooltipKey = GlobalKey();

  final double income;
  final double expenses;

  IncomeExpensesInfo({Key key, @required this.income, @required this.expenses})
      : assert(income != null),
        assert(expenses != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          final dynamic tooltip = _tooltipKey.currentState;
          tooltip.ensureTooltipVisible();
        },
        child: Tooltip(
          textStyle: baseStyleLight,
          key: _tooltipKey,
          padding: const EdgeInsets.all(8.0),
          message:
              'Next Income     : ${_getIncome()} \nNext Expenses : ${_getExpenses()}',
          child: Icon(
            Icons.info,
            color: Theme.of(context).accentColor,
          ),
        ));
  }

  String _getIncome() {
    return CurrencyUtils.formatToIdr(income);
  }

  String _getExpenses() {
    return CurrencyUtils.formatToIdr(expenses);
  }
}
