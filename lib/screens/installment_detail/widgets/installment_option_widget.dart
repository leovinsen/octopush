import 'package:flutter/material.dart';

class InstallmentOptionWidget extends StatelessWidget {
  final String pricePerInterval;
  final int duration;
  final String total;
  final double interest;

  const InstallmentOptionWidget(
      {Key key,
      this.pricePerInterval,
      this.duration,
      this.total,
      this.interest})
      : assert(pricePerInterval != null),
        assert(duration != null),
        assert(total != null),
        assert(interest != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}
