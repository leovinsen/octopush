class MutualFundsProduct {
  final String name;
  final MutualFundsType type;

  MutualFundsProduct(this.name, this.type);

  MutualFundsProduct.fromMap(Map<String,dynamic> map):
    name = map['name'],
    type = MutualFundsType.values[map['type']];
}

enum MutualFundsType {
  MONEY_MARKET,
  FIXED_INCOME,
  EQUITY
}