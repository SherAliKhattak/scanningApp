// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      textTheme: const TextTheme(headline6: TextStyle(color: Colors.white)),
      primaryColor: Colors.black,
      buttonColor: const Color(0xff893524),
      indicatorColor: const Color(0xffff592a),
      secondaryHeaderColor: Colors.white,
      colorScheme: const ColorScheme.dark(),
      iconTheme: const IconThemeData(color: Colors.grey, opacity: 0.8),
      hintColor: Colors.white,
      primaryColorDark: Colors.white,
      dialogBackgroundColor: const Color(0xff2c3850),
      cardColor: const Color(0xFF2C3850));

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF3F3F3),
    primaryColor: const Color(0xFFF5F5F5),
    indicatorColor: const Color(0xFF8080FF),
    buttonColor: const Color(0xFF80D4FF),
    colorScheme: const ColorScheme.light(),
    secondaryHeaderColor: const Color.fromARGB(255, 56, 55, 55),
    textTheme: const TextTheme(headline6: TextStyle(color: Colors.black)),
    iconTheme: const IconThemeData(color: Colors.black, opacity: 0.8),
    hintColor: Colors.black,
    primaryColorDark: Colors.black,
    dialogBackgroundColor: Colors.white,
    cardColor: Colors.white,
  );
}
