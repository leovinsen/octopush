import 'package:flutter/material.dart';
import 'package:octopush/model/mutual_funds_product.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/utils/currency_utils.dart';

class OwnedProductsList extends StatelessWidget {
  final Map<MutualFundsProduct, double> ownedProducts;

  const OwnedProductsList({Key key, this.ownedProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MapEntry<MutualFundsProduct, double>> entries =
        ownedProducts.entries.toList()..removeWhere((entry) => entry.value <= 0);

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: entries.length,
      itemBuilder: (_, index) {
        var entry = entries[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  entry.key.name,
                  style: largeTextStyleAccent.copyWith(
                      fontWeight: FontWeight.w600),
                ),
                
                Text(
                  '${CurrencyUtils.formatToIdr(entry.value)}',
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
