import 'package:flutter/material.dart';

class topNavBarDecoration {
  static const Color startGradientColor = Color.fromARGB(255, 86, 252, 108);
  static const Color endGradientColor = Color.fromARGB(255, 40, 233, 127);

  static BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [startGradientColor, endGradientColor],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      border: Border(
        bottom: BorderSide(
          color: Color.fromARGB(6, 95, 247, 115),
          width: 4.0,
        ),
      ),
    );
  }

  static TextStyle getTitleTextStyle() {
    return TextStyle(
      color: Color.fromARGB(255, 40, 233, 127),
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
    );
  }
}
