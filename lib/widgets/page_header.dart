import 'package:flutter/material.dart';

import '../styles.dart';
import 'primary_container.dart';

class PageHeader extends StatelessWidget {
  final String pageName;
  final String headerIconUrl;

  const PageHeader({Key key, this.pageName, this.headerIconUrl})
      : assert(pageName != null),
        assert(headerIconUrl != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hi!',
                style: subtitleStyleLight,
              ),
              Text(
                'Welcome to $pageName!',
                style: subtitleStyleLight,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              headerIconUrl,
              height: 50,
              width: 50,
            ),
          ),
        ],
      ),
    );
  }
}
