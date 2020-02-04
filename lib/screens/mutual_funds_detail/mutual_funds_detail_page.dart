import 'package:flutter/material.dart';
import 'package:octopush/model/mutual_funds_product.dart';
import 'package:octopush/screens/mutual_funds_detail/widgets/buy_sell_buttons.dart';
import 'package:octopush/screens/mutual_funds_detail/widgets/performance_graph.dart';
import 'package:octopush/service/trb_service.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/widgets/primary_container.dart';
import 'package:octopush/widgets/safe_scaffold.dart';
import 'package:octopush/widgets/section_label.dart';

import 'widgets/product_holdings.dart';
import 'widgets/product_info.dart';

const List<List<String>> holdings = [
  ["BTN", "BRI Agro", "Commonwealth", "Maybank Indonesia", "UOB Indonesia"],
  ["Corporate Obligation", "Government Obligation"],
  ["BTN", "BCA", "Mandiri Persero", "BRI", "Telkom Indonesia"],
  ["Adira", "Danamon", "BCA Finance", "Sukuk", "Corporate Bond"],
  ["Corporate Bonds"],
  ["Mandiri", "BCA", "BRI", "Telkom", "United Tractors"],
  ["Adira Dinamika Finance", "BTN"],
  ["Corporate Bonds"],
  ["Astra International", "Barito Pacific", "Indofood", "Telkom", "Unilever"]
];

// const List<List<double>> fees = [
//   []
// ]

class MutualFundsDetailPage extends StatelessWidget {
  final MutualFundsProduct product;

  TrbService trbService = TrbService();

  MutualFundsDetailPage({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _PageHeader(
                trbService: trbService,
              ),
              SizedBox(
                height: 20.0,
              ),
              SectionLabel(
                iconData: Icons.business,
                label: 'Top Holdings',
              ),
              SizedBox(
                height: 5.0,
              ),
              ProductHoldings(
                holdings: holdings[product.id],
              ),
              SizedBox(
                height: 20.0,
              ),
              SectionLabel(
                iconData: Icons.info_outline,
                label: 'Information',
              ),
              SizedBox(
                height: 5.0,
              ),
              ProductInfo(),
              SizedBox(
                height: 20.0,
              ),
              SectionLabel(
                iconData: Icons.call_missed_outgoing,
                label: 'Performance',
              ),
              SizedBox(
                height: 10.0,
              ),
              PerformanceGraph(),
              SizedBox(height: 20.0,),
              BuySellButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  final TrbService trbService;

  const _PageHeader({Key key, this.trbService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Your balance in product: ',
                style: subtitleStyleLight,
              ),
              FutureBuilder(
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    var trb = snapshot.data;
                    return Text(
                      'Welcome to $trb!',
                      style: subtitleStyleLight,
                    );
                  }

                  return CircularProgressIndicator();
                },
              )
            ],
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
