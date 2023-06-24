import 'package:flutter/material.dart';

import '../colors/appColors.dart';

class ThemeProvider extends ChangeNotifier {
  bool isNightMode = true;

  ThemeData get themeData => isNightMode ? ThemeData.dark() : ThemeData.light();

  Color getTextColor() {
    return isNightMode ? black : white;
  }

  Color getInvertedTextColor() {
    return isNightMode ? white : black;
  }

  Color getButtonTextColor() {
    return isNightMode ? grey : white;
  }

  Color getBottomNavColor() {
    return isNightMode ? black : grey.shade100;
  }

  Color getButtonTexInversedColor() {
    return isNightMode ? white : grey;
  }

  Color iconColor() {
    return isNightMode ? black : yellow;
  }

  Color passwordChangeColor() {
    return isNightMode ? red : lightRed;
  }

  Color passwordIconColor() {
    return isNightMode ? red : lightRed;
  }

  Color changeBackground() {
    return isNightMode ? white : darkBackground;
  }

  Color changeBackgroundLighter() {
    return isNightMode ? white : grey.shade600;
  }

  Color invertedColour() {
    return isNightMode ? black.withOpacity(0.5) : black;
  }

  void toggleDarkMode() {
    isNightMode = !isNightMode;
    textColor = getTextColor();
    invertedColor = invertedColour();
    background = changeBackground();
    lighterBackground = changeBackgroundLighter();
    textInverted = getInvertedTextColor();
    iconLightRed = passwordIconColor();
    textLightRed = passwordChangeColor();
    buttonTextInversedColor = getButtonTexInversedColor();
    buttonTextColor = getButtonTextColor();
    bottomNavSelectColor = getBottomNavColor();
    iconColour = iconColor();
    notifyListeners();
  }
}
