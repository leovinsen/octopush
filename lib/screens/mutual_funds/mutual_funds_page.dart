import 'package:flutter/material.dart';
import 'package:octopush/database/dao/mutual_funds_history_dao.dart';
import 'package:octopush/database/database.dart';
import 'package:octopush/model/mutual_funds.dart';
import 'package:octopush/model/mutual_funds_product.dart';
import 'package:octopush/repository/mutual_funds_history_repository.dart';
import 'package:octopush/repository/transaction_repository.dart';
import 'package:octopush/screens/mutual_funds/widgets/owned_products_list.dart';
import 'package:octopush/service/interval_service.dart';
import 'package:octopush/service/mutual_funds_service.dart';
import 'package:octopush/service/transaction_service.dart';
import 'package:octopush/service/trb_service.dart';
import 'package:octopush/widgets/page_header.dart';
import 'package:octopush/widgets/safe_scaffold.dart';
import 'package:octopush/widgets/section_label.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/mutual_funds_list.dart';

class MutualFundsPage extends StatefulWidget {
  @override
  _MutualFundsPageState createState() => _MutualFundsPageState();
}

class _MutualFundsPageState extends State<MutualFundsPage> {
  Map<MutualFundsProduct, double> _ownedProducts;
  MutualFundsService _service;

  bool _loading = true;

  List<MutualFunds> mutualFunds =
      mutualFundsJson.map((map) => MutualFunds.fromMap(map)).toList();

  @override
  void initState() {
    super.initState();
    createService().then((service) {
      _service = service;
      service.getOwnedProducts().then((result) {
        _ownedProducts = result;
        _loading = false;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: _loading
          ? CircularProgressIndicator()
          : Container(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    PageHeader(
                      pageName: 'Mutual Funds',
                      headerIconUrl: 'assets/ic_mutual_funds.png',
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SectionLabel(
                      iconData: Icons.attach_money,
                      label: 'Your products:',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    OwnedProductsList(
                      ownedProducts: _ownedProducts,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SectionLabel(
                      iconData: Icons.list,
                      label: 'Options:',
                    ),
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

// class _PageHeader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return PrimaryContainer(
//       padding: const EdgeInsets.all(10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Text(
//             'Welcome to Mutual Funds!',
//             style: subtitleStyleLight,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: Image.asset(
//               'assets/ic_mutual_funds.png',
//               height: 50,
//               width: 50,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
