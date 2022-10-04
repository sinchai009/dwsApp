import 'dart:ui';

import 'package:flutter/material.dart';

class MyConstant {
  static String domain = 'https://iot-isamu.000webhostapp.com';

  static double latMap = 13.666808253248941;
  static double lngMap = 100.55347167093655;

  static Color dark = Colors.black;
  static Color white = Colors.white;
  static Color red = Colors.red;
  static Color blue = Colors.blue;
  static Color yellow = Colors.yellow;
  static Color green = const Color.fromARGB(255, 6, 149, 10);

  BoxDecoration curveBox() {
    return BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(),
    );
  }

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

  TextStyle h2WhiteStyle() {
    return TextStyle(
      fontSize: 20,
      color: white,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle h3Style() {
    return TextStyle(
      fontSize: 14,
      color: dark,
      fontWeight: FontWeight.normal,
    );
  }
   TextStyle h3ActiveStyle() {
    return TextStyle(
      fontSize: 16,
      color: blue,
      fontWeight: FontWeight.w500,
    );
  }
}
