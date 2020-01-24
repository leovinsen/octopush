import 'package:flutter/material.dart';

class PrimaryContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  

  const PrimaryContainer({this.child, this.padding} ) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.padding ?? const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).accentColor,
      ),
      child: child,
    );
  }
}
