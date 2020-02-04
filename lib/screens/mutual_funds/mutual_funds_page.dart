import 'package:flutter/material.dart';
import 'package:octopush/model/mutual_funds.dart';
import 'package:octopush/model/mutual_funds_product.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/widgets/primary_container.dart';
import 'package:octopush/widgets/safe_scaffold.dart';

const List<Map<String, dynamic>> mutualFundsJson = [
  {
    "category_name": "BNP Paribas",
    "products": [
      {"name": "Rupiah Plus IDR", "type": 0, "yield": 23.55},
      {"name": "Omega", "type": 1, "yield": 50.65},
      {"name": "Persona", "type": 2, "yield": 79.20}
    ]
  },
  {
    "category_name": "Schroder Dana",
    "products": [
      {"name": "Likuid", "type": 0, "yield": 25.95},
      {"name": "Andalan II", "type": 1, "yield": 46.20},
      {"name": "Prestasi Plus", "type": 2, "yield": 83.80}
    ]
  },
  {
    "category_name": "FFS Principal",
    "products": [
      {"name": "Cash Fund", "type": 0, "yield": 32.70},
      {"name": "Total Return Bond Fund", "type": 1, "yield": 41.40},
      {"name": "Islamic Equity Growth Syariah", "type": 2, "yield": 80.10}
    ]
  }
];

class MutualFundsPage extends StatelessWidget {
  List<MutualFunds> mutualFunds =
      mutualFundsJson.map((map) => MutualFunds.fromMap(map)).toList();

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _PageHeader(),
              // PageHeader(
              //   pageName: 'Mutual Funds',
              //   headerIconUrl: 'assets/ic_mutual_funds.png',
              // ),
              SizedBox(
                height: 20.0,
              ),
              MutualFundsList(
                mutualFunds: mutualFunds,
              )
            ],
          ),
        ),
      ),
    );
  }
}

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

class MutualFundsProductHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Product',
          style: largeTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          '% Yield YOY',
          style: largeTextStyle.copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class MutualFundsProductWidget extends StatelessWidget {
  final MutualFundsProduct product;

  const MutualFundsProductWidget({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: expansionTilePadding,
      child: GestureDetector(
        onTap: null,
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

class _PageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Options:',
            style: titleStyleLight,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              'assets/ic_mutual_funds.png',
              height: 50,
              width: 50,
            ),
          ),
        ],
      ),
    );
  }
}
