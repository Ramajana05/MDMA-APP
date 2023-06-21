import 'package:flutter/material.dart';

import '../colors/appColors.dart';

class topNavBarDecoration {
  static const Color startGradientColor = topGreen;
  static const Color endGradientColor = primaryAppLightGreen;

  static BoxDecoration getBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [startGradientColor, endGradientColor],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      border: Border(
        bottom: BorderSide(
          color: topBorderGreen,
          width: 4.0,
        ),
      ),
    );
  }

  static TextStyle getTitleTextStyle() {
    return const TextStyle(
      color: primaryAppLightGreen,
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
    );
  }
}
