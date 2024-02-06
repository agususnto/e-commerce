import 'package:flutter/material.dart';


class MyTheme {

  static final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    colorScheme: const ColorScheme.dark(secondary: Colors.white,primary: Colors.black),
    iconTheme: IconThemeData(color: Colors.purple.shade200,opacity: 0.8),
    dividerColor: Colors.black12,
  );

  static final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    colorScheme: const ColorScheme.light(secondary: Colors.black,primary: Colors.red),
    iconTheme: const IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,

  );

}
