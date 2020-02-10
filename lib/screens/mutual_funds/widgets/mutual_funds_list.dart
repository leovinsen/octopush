import 'package:flutter/material.dart';
import 'package:octopush/model/mutual_funds.dart';
import 'package:octopush/styles.dart';

import 'mutual_funds_product_header.dart';
import 'mutual_funds_product_widget.dart.dart';

const expansionTilePadding =
    const EdgeInsets.only(bottom: 10.0, left: 16.0, right: 16.0);

class MutualFundsList extends StatelessWidget {
  final List<MutualFunds> mutualFunds;

  const MutualFundsList({Key key, this.mutualFunds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: mutualFunds.length,
      itemBuilder: (_, index) {
        var mf = mutualFunds[index];

        return Card(
          child: ExpansionTile(
            title: Text(
              mf.categoryName,
              style: captionStyle,
            ),
            children: <Widget>[
                  Padding(
                    padding: expansionTilePadding,
                    child: MutualFundsProductHeader(),
                  ),
                ] +
                mf.products
                    .map(
                      (product) => MutualFundsProductWidget(
                        product: product,
                      ),
                    )
                    .toList(),
          ),
        );
      },
    );
  }
}
