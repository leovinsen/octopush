class MutualFundsProduct {
  final int id;
  final String name;
  final MutualFundsType type;
  final double yieldRate;

  MutualFundsProduct(this.name, this.type, this.yieldRate, this.id);

  MutualFundsProduct.fromMap(Map<String,dynamic> map):
    id = map['id'],
    name = map['name'],
    type = MutualFundsType.values[map['type']],
    yieldRate = map['yield'];
}

enum MutualFundsType {
  MONEY_MARKET,
  FIXED_INCOME,
  EQUITY
}