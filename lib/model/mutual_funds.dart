import 'package:octopush/model/mutual_funds_product.dart';

class MutualFunds {
  final String categoryName;
  final List<MutualFundsProduct> products;

  MutualFunds(this.categoryName, this.products);

  MutualFunds.fromMap(Map<String, dynamic> map)
      : categoryName = map['category_name'],
        products = (map['products'] as List<Map>)
            .map((map) => MutualFundsProduct.fromMap(map))
            .toList();
}
