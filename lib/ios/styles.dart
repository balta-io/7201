import 'package:flutter/cupertino.dart';

const brightness = Brightness.light;
const primaryColor = const Color(0xFF2AACFF);
const accentColor = const Color(0xFFFFFFFF);

CupertinoThemeData iosTheme() {
  return CupertinoThemeData(
    brightness: brightness,
    primaryColor: primaryColor,
  );
}
