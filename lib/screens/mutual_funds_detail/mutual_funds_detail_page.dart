import 'package:flutter/material.dart';
import 'package:octopush/database/dao/mutual_funds_history_dao.dart';
import 'package:octopush/database/database.dart';
import 'package:octopush/model/mutual_funds_product.dart';
import 'package:octopush/repository/mutual_funds_history_repository.dart';
import 'package:octopush/repository/transaction_repository.dart';
import 'package:octopush/screens/mutual_funds_detail/widgets/buy_sell_buttons.dart';
import 'package:octopush/screens/mutual_funds_detail/widgets/performance_graph.dart';
import 'package:octopush/service/interval_service.dart';
import 'package:octopush/service/mutual_funds_service.dart';
import 'package:octopush/service/transaction_service.dart';
import 'package:octopush/service/trb_service.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/widgets/primary_container.dart';
import 'package:octopush/widgets/safe_scaffold.dart';
import 'package:octopush/widgets/section_label.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              SizedBox(
                height: 20.0,
              ),
              BuySellButtons(
                onSellPressed: null,
                onBuyPressed: () => _showBuyDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBuyDialog(BuildContext context) {
    final controller = TextEditingController();
    var formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Form(
          key: formKey,
          child: TextFormField(
            keyboardType: TextInputType.number,
            validator: (text) {
              int amount = int.parse(text);
              if (amount <= 100000)
                return 'You entered an amount less than 100K IDR!';

              return null;
            },
            controller: controller,
            decoration: InputDecoration(labelText: 'Amount (min 100K IDR)'),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('NO'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('YES'),
            onPressed: () {
              if (formKey.currentState.validate())
                _buy(
                  context,
                  int.parse(controller.text),
                );
            },
          )
        ],
      ),
    );
  }

  void _buy(BuildContext context, int amount) async {
    await createService()
      ..buyMutualFunds(product, amount.toDouble());
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  Future<MutualFundsService> createService() async {
    var mfRepo = MutualFundsHistoryRepository(
        MutualFundsHistoryDao(await DatabaseProvider.instance.db));

    var intervalService =
        IntervalService(await SharedPreferences.getInstance());

    var transactionService =
        TransactionService(TransactionRepository(), TrbService());

    MutualFundsService service =
        MutualFundsService(mfRepo, intervalService, transactionService);

    return service;
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
