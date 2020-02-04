import 'package:flutter/material.dart';
import 'package:octopush/styles.dart';

class ProductHoldings extends StatelessWidget {
  final List<String> holdings;

  const ProductHoldings({Key key, this.holdings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: holdings.length,
      itemBuilder: (_, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              holdings[index],
              style: largeTextStyleAccent.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
    );
  }
}
