import 'dart:ui';

import 'package:flutter/material.dart';

///App Colors
const primaryAppLightGreen = Color.fromARGB(255, 40, 233, 127);
const primaryUnselectedLabelColor = Color.fromARGB(255, 110, 110, 110);
const white = Colors.white;
const black = Colors.black;
const grey = Colors.grey;
Color background = Colors.white;
Color darkBackground = Color(0xFF555555);
Color lighterBackground = changeBackgroundLighter();
const yellow = Colors.yellow;
Color textColor = getTextColor();

///Visitor, Sensor, Humidity, Temperature Colors
const primaryVisitorColor = Color.fromARGB(255, 240, 113, 202);
const red = Colors.red;
const blue = Colors.blue;

///Colors of the map
const primaryVisitorLowCountColor = Color.fromARGB(255, 170, 169, 169);
const primaryVisitorModerateCountColor = Color.fromARGB(255, 128, 197, 130);

///Visitor, Sensor, Humidity, Temperature shadow Colors
const primaryVisitorShadowColor = Color.fromARGB(255, 255, 228, 251);
const primaryTempShadowColor = Color.fromARGB(255, 255, 199, 199);
const primaryHumidityShadowColor = Color.fromARGB(255, 196, 236, 255);

///Battery green color
const primaryGreen = Color.fromARGB(255, 46, 202, 51);
const orangeAccent = Colors.orangeAccent;
const orange = Colors.orange;

/// Bottom Nav Bar
const bottomGreen = Color.fromARGB(255, 41, 235, 15);
const bottomGradient = [
  Color(0xFF2DFFD9),
  Color(0xFF00FF57),
];
const darkGreen = Color.fromARGB(204, 0, 165, 22);
final List<Color> tabColors = [
  darkGreen, // Dashboard
  blue, // Statistics
  red, // Map
  blue, // QR Code
  darkGreen, // Sensors
];
Color bottomNavSelectColor = getBottomNavColor();

/// Logout Dialog
const logoutBlack = Colors.black26;

///Profile
Color iconLightRed = passwordIconColor();
Color textLightRed = passwordChangeColor();
const lightRed = Color.fromARGB(255, 255, 161, 152);

///TopNavBar
const topGreen = Color.fromARGB(255, 86, 252, 108);
const topBorderGreen = Color.fromARGB(6, 95, 247, 115);
Color invertedColor = invertedColour();
Color textInverted = getInvertedTextColor();
Color buttonTextInversedColor = getButtonTexInversedColor();
Color buttonTextColor = getButtonTextColor();

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

bool isNightMode = true;

void toggleNightMode() {
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
}
