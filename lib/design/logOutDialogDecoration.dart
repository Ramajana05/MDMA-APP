import 'package:flutter/material.dart';
import '../colors/appColors.dart';

/// The `LogOutDecoration` class provides static methods to retrieve the box decoration and text style
/// used for the log out section.

class LogOutDecoration {
  static BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    );
  }

  static TextStyle getTitleTextStyle() {
    return const TextStyle(
      color: primaryAppLightGreen,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    );
  }
}
