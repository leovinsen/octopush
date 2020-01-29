import 'package:flutter/material.dart';
import 'package:octopush/model/installment.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/widgets/primary_container.dart';

import 'installment_detail_page.dart';

const String mortgage = 'Mortgage';
const String automobile = 'CIMB Niaga Auto Finance';

class InstallmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.center,
        child: PrimaryContainer(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Which installments would you like to make?',
                style: titleStyleLight,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InstallmentOptionCard(
                      imagePath: 'assets/ic_mortgage.png',
                      label: mortgage,
                      onTap: () => _pushPage(
                        context: context,
                        index: 0,
                        label: mortgage,
                      ),
                    ),
                  ),
                  Expanded(
                    child: InstallmentOptionCard(
                      imagePath: 'assets/ic_automobile.png',
                      label: automobile,
                      onTap: () => _pushPage(
                        context: context,
                        index: 1,
                        label: automobile,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pushPage({BuildContext context, int index, String label}) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) =>
          InstallmentDetailPage(InstallmentType.values[index], label),
    ));
  }
}

class InstallmentOptionCard extends StatelessWidget {
  final String label;
  final Function onTap;
  final String imagePath;

  const InstallmentOptionCard({Key key, this.label, this.onTap, this.imagePath})
      : assert(label != null),
        assert(onTap != null),
        assert(imagePath != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Card(
        elevation: 1.0,
        child: Container(
          height: 175,
          padding: const EdgeInsets.only(top: 20.0, bottom: 10.0, left: 20.0, right: 20.0,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                imagePath,
                height: 80,
                width: 80,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '$label',
                style: captionStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
