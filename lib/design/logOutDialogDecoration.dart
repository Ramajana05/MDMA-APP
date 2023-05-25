import 'package:flutter/material.dart';

class LogOutDecoration {
  static BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    );
  }

  static TextStyle getTitleTextStyle() {
    return TextStyle(
      color: Color.fromARGB(255, 40, 233, 127),
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    );
  }
}
