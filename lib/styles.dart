import 'package:flutter/material.dart';

final TextStyle smallTextStyle = baseStyle.copyWith(fontSize: 12.0);
final TextStyle baseStyle = TextStyle(fontSize: 14.0);
final TextStyle captionStyle = baseStyle.copyWith(fontSize: 18.0, fontWeight: FontWeight.w500);
final TextStyle titleStyle = baseStyle.copyWith(fontSize: 24.0, fontWeight: FontWeight.w600);
final TextStyle subtitleStyle = baseStyle.copyWith(fontSize: 20.0, fontWeight: FontWeight.w600);

///Light Themes
final TextStyle smallTextStyleLight = smallTextStyle.copyWith(color: Colors.white);
final TextStyle baseStyleLight = baseStyle.copyWith(color: Colors.white);
final TextStyle captionStyleLight = captionStyle.copyWith(color: Colors.white);
final TextStyle titleStyleLight = titleStyle.copyWith(color: Colors.white);
final TextStyle subtitleStyleLight = subtitleStyle.copyWith(color: Colors.white);