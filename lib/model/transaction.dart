import 'package:equatable/equatable.dart';
import 'package:octopush/database/database.dart';

class Transaction extends Equatable {
  final int id;
  final DateTime dateCreated;
  final int interval;
  final String title;
  final double amount;

  Transaction(
      this.id, this.dateCreated, this.interval, this.title, this.amount);

  Transaction.newDBRecord(int interval, String title, double amount)
      : id = null,
        dateCreated = DateTime.now(),
        interval = interval,
        title = title,
        amount = amount;

  Transaction.fromDB(Map<String, dynamic> map)
      : id = map[COL_ID],
        dateCreated = DateTime.parse(map[COL_DATE_CREATED]),
        interval = map[COL_TIME_INTERVAL],
        title = map[COL_TITLE],
        amount = (map[COL_AMOUNT] is int)
            ? map[COL_AMOUNT].toDouble()
            : map[COL_AMOUNT];

  Map<String, dynamic> toDB() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[COL_ID] = this.id;
    data[COL_DATE_CREATED] = this.dateCreated.toIso8601String();
    data[COL_TIME_INTERVAL] = this.interval;
    data[COL_TITLE] = this.title;
    data[COL_AMOUNT] = this.amount;
    return data;
  }

  @override
  String toString() {
    return "$COL_ID: $id, $COL_DATE_CREATED: $dateCreated, $COL_TIME_INTERVAL: $interval, $COL_TITLE: $title, $COL_AMOUNT: $amount";
  }

  @override
  List<Object> get props => [id, dateCreated, interval, title, amount];
}
