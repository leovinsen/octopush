import 'package:octopush/base/base_entity.dart';
import 'package:octopush/database/schema/schema_mutual_funds_history.dart';
import 'package:octopush/model/time_interval.dart';

class MutualFundsHistory extends BaseEntity {
  final int id;
  final int productId;
  final DateTime dateCreated;
  final TimeInterval purchaseInterval;
  final double amount;

  MutualFundsHistory.newDBRecord(int productId, int interval, double amount)
      : id = null,
        productId = productId,
        dateCreated = DateTime.now(),
        purchaseInterval = TimeInterval.values[interval],
        amount = amount;

  MutualFundsHistory.fromDB(Map<String, dynamic> map)
      : id = map[MF_HISTORY_ID],
        productId = map[MF_HISTORY_PRODUCT_ID],
        dateCreated = DateTime.parse(map[MF_HISTORY_DATETIME]),
        purchaseInterval = TimeInterval.values[map[MF_HISTORY_PURCHASE_INTERVAL]],
        amount = (map[MF_HISTORY_AMOUNT] as int).toDouble();

  Map<String, dynamic> toDB() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[MF_HISTORY_ID] = this.id;
    data[MF_HISTORY_PRODUCT_ID] = this.productId;
    data[MF_HISTORY_DATETIME] = this.dateCreated.toIso8601String();
    data[MF_HISTORY_PURCHASE_INTERVAL] = this.purchaseInterval.index;
    data[MF_HISTORY_AMOUNT] = this.amount;
    return data;
  }

  @override
  String toString() {
    return "$MF_HISTORY_ID: $id, $MF_HISTORY_PRODUCT_ID: $productId, $MF_HISTORY_DATETIME: $dateCreated, $MF_HISTORY_PURCHASE_INTERVAL: $purchaseInterval, $MF_HISTORY_AMOUNT: $amount";
  }

  @override
  List<Object> get props =>
      [id, productId, dateCreated, purchaseInterval, amount];
}
