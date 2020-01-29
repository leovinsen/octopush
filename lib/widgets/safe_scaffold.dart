import 'package:flutter/material.dart';

///Used throughout the app
///A scaffold with no appbar which uses a [SafeArea] as its body
class SafeScaffold extends StatelessWidget {
  final Widget body;

  const SafeScaffold({Key key, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: body,
      ),
    );
  }
}
