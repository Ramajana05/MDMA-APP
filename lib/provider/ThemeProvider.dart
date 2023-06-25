import 'package:flutter/material.dart';

import '../colors/appColors.dart';

class ThemeProvider extends ChangeNotifier {
  bool isNightMode = true;

  ThemeData get themeData => isNightMode ? ThemeData.dark() : ThemeData.light();

  Color getTextColor() {
    return isNightMode ? black : white;
  }

  Color getInvertedColor() {
    return isNightMode ? white : black;
  }

  Color getBackground() {
    return isNightMode ? white : darkBackground;
  }

  Color getLighterBackground() {
    return isNightMode ? white : grey.shade600;
  }

  Color getTextInverted() {
    return isNightMode ? black.withOpacity(0.5) : black;
  }

  Color getIconLightRed() {
    return isNightMode ? red : lightRed;
  }

  Color getTextLightRed() {
    return isNightMode ? red : lightRed;
  }

  Color getButtonTextInversedColor() {
    return isNightMode ? white : grey;
  }

  Color getButtonTextColor() {
    return isNightMode ? grey : white;
  }

  Color getBottomNavColor() {
    return isNightMode ? black : grey.shade100;
  }

  Color getIconColor() {
    return isNightMode ? moonColor : yellow;
  }

  void toggleLightMode() {
    isNightMode;
    textColor = getTextColor();
    invertedColor = getInvertedColor();
    background = getBackground();
    lighterBackground = getLighterBackground();
    textInverted = getTextInverted();
    iconLightRed = getIconLightRed();
    textLightRed = getTextLightRed();
    buttonTextInversedColor = getButtonTextInversedColor();
    buttonTextColor = getButtonTextColor();
    bottomNavColor = getBottomNavColor();
    iconColor = getIconColor();
    notifyListeners();
  }

  void toggleDarkMode() {
    isNightMode = !isNightMode;
    textColor = getTextColor();
    invertedColor = getInvertedColor();
    background = getBackground();
    lighterBackground = getLighterBackground();
    textInverted = getTextInverted();
    iconLightRed = getIconLightRed();
    textLightRed = getTextLightRed();
    buttonTextInversedColor = getButtonTextInversedColor();
    buttonTextColor = getButtonTextColor();
    bottomNavColor = getBottomNavColor();
    iconColor = getIconColor();
    notifyListeners();
  }
}
