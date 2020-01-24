import 'package:flutter/material.dart';
import 'package:octopush/styles.dart';

import 'primary_container.dart';

class SectionLabel extends StatelessWidget {
  final IconData iconData;
  final String label;

  const SectionLabel({this.iconData, this.label})
      : assert(iconData != null),
        assert(label != null);

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          Icon(
            iconData,
            color: Colors.white,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            label,
            style: captionStyleLight,
          )
        ],
      ),
    );
  }
}
