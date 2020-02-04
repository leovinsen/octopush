import 'package:flutter/material.dart';
import 'package:octopush/styles.dart';

class ProductInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _ProductInfoCard(
          text: 'Min. Purchase Amount: 100K',
        ),
        _ProductInfoCard(
          text: 'Next Purchase Amount: 100K',
        ),
        _ProductInfoCard(
          text: 'Min. Sell Amount: 100K',
        ),
      ],
    );
  }
}

class _ProductInfoCard extends StatelessWidget {
  final String text;

  const _ProductInfoCard({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: largeTextStyleAccent.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
