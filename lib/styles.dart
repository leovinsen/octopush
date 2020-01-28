import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color accentColor = Color(0xFF880606);
const Color backgroundColor = Color(0xFF262626);

final TextStyle smallTextStyle = baseStyle.copyWith(fontSize: 12.0, fontWeight: FontWeight.w300);
// final TextStyle baseStyle = GoogleFonts.openSans(textStyle: TextStyle(fontSize: 14.0), letterSpacing: -0.5);

final TextStyle baseStyle = TextStyle(fontSize: 14.0, letterSpacing: -0.5);
final TextStyle captionStyle = baseStyle.copyWith(fontSize: 18.0);
final TextStyle titleStyle = baseStyle.copyWith(fontSize: 24.0, fontWeight: FontWeight.w600);
final TextStyle subtitleStyle = baseStyle.copyWith(fontSize: 20.0, fontWeight: FontWeight.w600);

///Light Themes
final TextStyle smallTextStyleLight = smallTextStyle.copyWith(color: Colors.white);
final TextStyle baseStyleLight = baseStyle.copyWith(color: Colors.white);
final TextStyle captionStyleLight = captionStyle.copyWith(color: Colors.white);
final TextStyle titleStyleLight = titleStyle.copyWith(color: Colors.white);
final TextStyle subtitleStyleLight = subtitleStyle.copyWith(color: Colors.white);

//Accent color Themes
final TextStyle smallTextStyleAccent = smallTextStyle.copyWith(color: accentColor);
final TextStyle baseStyleAccent = baseStyle.copyWith(color: accentColor);
final TextStyle captionStyleAccent = captionStyle.copyWith(color: accentColor);
final TextStyle titleStyleAccent = titleStyle.copyWith(color: accentColor);
final TextStyle subtitleStyleAccent = subtitleStyle.copyWith(color: accentColor);