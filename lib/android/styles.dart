import 'package:flutter/material.dart';

const brightness = Brightness.light;
const primaryColor = const Color(0xFF2AACFF);
const accentColor = const Color(0xFFFFFFFF);

ThemeData androidTheme() {
  return ThemeData(
    brightness: brightness,
    textTheme: new TextTheme(
      body1: new TextStyle(
        fontFamily: "Poppins",
      ),
      body2: TextStyle(
        fontFamily: "Poppins",
      ),
      button: TextStyle(
        fontFamily: "Poppins",
      ),
      caption: TextStyle(
        fontFamily: "Poppins",
      ),
      display1: TextStyle(
        fontFamily: "Poppins",
      ),
      display2: TextStyle(
        fontFamily: "Poppins",
      ),
      display3: TextStyle(
        fontFamily: "Poppins",
      ),
      display4: TextStyle(
        fontFamily: "Poppins",
      ),
      headline: TextStyle(
        fontFamily: "Poppins",
      ),
      overline: TextStyle(
        fontFamily: "Poppins",
      ),
      subhead: TextStyle(
        fontFamily: "Poppins",
      ),
      subtitle: TextStyle(
        fontFamily: "Poppins",
      ),
      title: TextStyle(
        fontFamily: "Poppins",
      ),
    ),
    primaryColor: primaryColor,
    accentColor: accentColor,
  );
}
