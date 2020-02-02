import 'package:flutter/material.dart';
import 'package:octopush/model/installment.dart';
import 'package:octopush/repository/installment_repository.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/utils/currency_utils.dart';
import 'package:octopush/utils/no_glow_scroll.dart';
import 'package:octopush/widgets/primary_container.dart';

import 'widgets/installment_option_list.dart';

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
        child: Container(
          decoration: getPrimaryDecoration(context),
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              Text(
                '$label Options',
                style: titleStyleLight,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              InstallmentImage(
                installmentType: installmentType,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Base price: $basePrice ',
                textAlign: TextAlign.center,
                style: subtitleStyleLight,
              ),
              SizedBox(height: 20.0),
              InstallmentOptionList(options: options),
            ],
          ),
        ),
      ),
    );
  }
}

class InstallmentImage extends StatelessWidget {
  final InstallmentType installmentType;

  const InstallmentImage({Key key, this.installmentType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imagePath;
    switch (installmentType) {
      case InstallmentType.MORTGAGE:
        imagePath = 'assets/ic_mortgage.png';
        break;
      case InstallmentType.AUTOMOBILE:
        imagePath = 'assets/ic_automobile.png';
        break;
    }
    return Image.asset(
      imagePath,
      width: 125,
      height: 125,
    );
  }
}
