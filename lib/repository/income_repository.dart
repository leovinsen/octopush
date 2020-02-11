import 'package:octopush/model/time_interval.dart';
import 'package:octopush/rules/earning_rules.dart';

class IncomeRepository {
  
  List<int> getIncomeAndExpensesFor(TimeInterval interval) {
    List<int> incomeExpenses = earnings[interval];
    incomeExpenses = incomeExpenses.map((val) => val * 1000 * 1000).toList();
    return incomeExpenses;
  }
}
