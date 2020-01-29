import 'package:flutter/material.dart';
import 'package:octopush/styles.dart';

class PaymentOptionCard extends StatelessWidget {
  final String label;
  final String imagePath;
  final Function onTap;
  final double height;
  final double width;

  const PaymentOptionCard({Key key, this.label, this.imagePath, this.onTap, this.height, this.width})
      : assert(label != null),
        assert(imagePath != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: onTap == null ? Colors.grey : Colors.white,
        ),
        padding: const EdgeInsets.all(0.0),
        width: width ?? 100,
        height: height ?? 100,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imagePath,
              width: 50,
              height: 50,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              label,
              style: baseStyle,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
