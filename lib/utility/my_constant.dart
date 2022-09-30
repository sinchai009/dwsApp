import 'dart:ui';

import 'package:flutter/material.dart';

class MyConstant {
  static Color dark = Colors.black;
  static Color white = Colors.white;
  static Color red = Colors.red;
  static Color blue = Colors.blue;
  static Color yellow = Colors.yellow;
  static Color green = const Color.fromARGB(255, 6, 149, 10);

  TextStyle h1Style() {
    return TextStyle(
      fontSize: 36,
      color: dark,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle h2Style() {
    return TextStyle(
      fontSize: 20,
      color: dark,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle h2RedStyle() {
    return TextStyle(
      fontSize: 20,
      color: red,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle h2BlueStyle() {
    return TextStyle(
      fontSize: 20,
      color: blue,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle h3Style() {
    return TextStyle(
      fontSize: 14,
      color: dark,
      fontWeight: FontWeight.normal,
    );
  }
}
