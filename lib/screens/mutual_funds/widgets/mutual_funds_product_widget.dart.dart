import 'package:flutter/material.dart';
import 'package:octopush/model/mutual_funds_product.dart';
import 'package:octopush/screens/mutual_funds_detail/mutual_funds_detail_page.dart';
import 'package:octopush/styles.dart';

import 'mutual_funds_list.dart';

class MutualFundsProductWidget extends StatelessWidget {
  final MutualFundsProduct product;

  const MutualFundsProductWidget({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: expansionTilePadding,
      child: GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MutualFundsDetailPage(product: product),
            ),
          );
        },
        // onTap: () => Navigator.of(context).pushNamed(routeMutualFundsDetail),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              product.name,
              style: baseStyle,
            ),
            Text(
              '${product.yieldRate}%',
              style: baseStyle,
            )
          ],
        ),
      ),
    );
  }
}
