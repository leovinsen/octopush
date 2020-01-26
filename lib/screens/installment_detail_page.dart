import 'package:flutter/material.dart';
import 'package:octopush/model/installment.dart';
import 'package:octopush/repository/installment_repository.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/utils/currency_utils.dart';
import 'package:octopush/utils/no_glow_scroll.dart';

class InstallmentDetailPage extends StatelessWidget {
  final InstallmentType installmentType;
  final String label;

  InstallmentDetailPage(this.installmentType, this.label)
      : repository = InstallmentRepository();

  final InstallmentRepository repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    List<InstallmentOption> options =
        repository.getOptions(this.installmentType);
    var basePrice =
        CurrencyUtils.formatToIdr(basePrices[installmentType.index].toDouble());

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: ListView(
          children: <Widget>[
            Text(
              '$label Options',
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Text(
              'Base price: $basePrice ',
              textAlign: TextAlign.center,
              style: subtitleStyle,
            ),
            SizedBox(height: 20.0),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (_, index) {
                  var option = options[index];
                  var pricePerInterval =
                      CurrencyUtils.formatToIdr(option.intervalInstallment);
                  var duration = option.duration;
                  var total = CurrencyUtils.formatToIdr(option.amount);
                  var interest = option.interest;

                  return Card(
                    child: ListTile(
                      isThreeLine: true,
                      title: Text('$pricePerInterval per interval'),
                      subtitle: Text('$duration intervals \nTotal: $total'),
                      trailing: Text(
                        '$interest %',
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
