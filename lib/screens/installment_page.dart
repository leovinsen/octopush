import 'package:flutter/material.dart';
import 'package:octopush/model/installment.dart';
import 'package:octopush/styles.dart';

import 'installment_detail_page.dart';

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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Theme.of(context).accentColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Which installments would you like to make?',
                style: titleStyleLight,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.0),
              Row(
                children: <Widget>[
                  _buildHalfOfScreen(
                    iconData: Icons.home,
                    label: 'Mortgage',
                    onTap: () => _pushPage(
                      context: context,
                      index: 0,
                      label: 'Mortgage',
                    ),
                  ),
                  _buildHalfOfScreen(
                    iconData: Icons.directions_car,
                    label: 'Automobile',
                    onTap: () => _pushPage(
                      context: context,
                      index: 1,
                      label: 'Automobile',
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

  Widget _buildHalfOfScreen({IconData iconData, String label, Function onTap}) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap(),
        child: Card(
          elevation: 1.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  iconData,
                  size: 80,
                  color: Colors.redAccent,
                ),
                SizedBox(
                  height: 20.0,
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
      ),
    );
  }
}
