import 'package:flutter/material.dart';

class topNavBarDecoration {
  static const Color startGradientColor = Color(0xFF3366FF);
  static const Color endGradientColor = Color(0xFF00CCFF);

  static BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [startGradientColor, endGradientColor],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      border: Border(
        bottom: BorderSide(
          color: Color(0xFF00BFA6),
          width: 12.0,
        ),
      ),
    );
  }

  static TextStyle getTitleTextStyle() {
    return TextStyle(
      color: Color.fromARGB(255, 30, 143, 73),
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
    );
  }
}
