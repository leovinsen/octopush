import 'package:flutter/material.dart';
import 'package:octopush/model/installment.dart';
import 'package:octopush/utils/currency_utils.dart';

import 'installment_option_widget.dart';

class InstallmentOptionList extends StatelessWidget {
  final List<InstallmentOption> options;

  const InstallmentOptionList({Key key, this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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

        return InstallmentOptionWidget(
          pricePerInterval: pricePerInterval,
          duration: duration,
          total: total,
          interest:  interest,
        );
        
      },
    );
  }
}
