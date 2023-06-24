import 'package:flutter/material.dart';

import '../colors/appColors.dart';

class LogOutDecoration {
  static BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
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
