import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class CurrencyUtils {
  static String formatToIdr(double balance){
    var balanceStr = FlutterMoneyFormatter(
        amount: balance,
        settings: MoneyFormatterSettings(
          symbol: 'IDR',
          thousandSeparator: '.',
          decimalSeparator: '.',
          fractionDigits: 2,
        ));

  return balanceStr.output.symbolOnLeft;
  }
}