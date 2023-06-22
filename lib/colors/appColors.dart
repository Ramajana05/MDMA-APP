import 'dart:ui';

import 'package:flutter/material.dart';

///App Colors
const primaryAppLightGreen = Color.fromARGB(255, 40, 233, 127);
const primaryUnselectedLabelColor = Color.fromARGB(255, 110, 110, 110);
const white = Colors.white;
const black = Colors.black;
const grey = Colors.grey;
const yellow = Colors.yellow;
const green = Colors.green;

///Login
final gradientColors = [topGreen, primaryAppLightGreen];
const loginGrey = Color.fromARGB(255, 158, 158, 158);

///Information Dialog
const infoGreen = Color.fromARGB(255, 128, 197, 130);
const infoGrey = Color.fromARGB(255, 170, 169, 169);

///Visitor, Sensor, Humidity, Temperature Colors
const primaryVisitorColor = Color.fromARGB(255, 240, 113, 202);
const red = Colors.red;
const blue = Colors.blue;

///Colors of the map
const primaryVisitorLowCountColor = Color.fromARGB(255, 170, 169, 169);
const primaryVisitorModerateCountColor = Color.fromARGB(255, 128, 197, 130);

///Dashboard
const primaryVisitorShadowColor = Color.fromARGB(255, 255, 228, 251);
const primaryTempShadowColor = Color.fromARGB(255, 255, 199, 199);
const primaryHumidityShadowColor = Color.fromARGB(255, 196, 236, 255);
const transparent = Colors.transparent;
const deepPurple = Colors.deepPurple;
const turquoise = Color.fromARGB(255, 194, 255, 241);

///Battery color
const primaryGreen = Color.fromARGB(255, 46, 202, 51);
const orangeAccent = Colors.orangeAccent;
const orange = Colors.orange;

/// Help
const black54 = Colors.black54;
const blueGrey = Color.fromARGB(255, 127, 127, 128);
const limeGreen = Color.fromARGB(255, 58, 243, 33);
final List<Color> colorsList = [
  green,
  black,
  red,
  black,
  green,
  green,
  green,
  blue,
  blueGrey,
  red,
  limeGreen,
];

///Statistics
const deepOrange = Colors.deepOrange;
const statBlue = Color.fromARGB(255, 56, 162, 197);
const statGreen = Color.fromRGBO(38, 158, 38, 0.2);

///SnackbarWidget
const redAccent = Colors.redAccent;

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

///Warning Widget
const warningGrey = Color.fromARGB(255, 170, 170, 170);

///Profile
const lightRed = Color.fromARGB(255, 255, 161, 152);

///TopNavBar
const topGreen = Color.fromARGB(255, 86, 252, 108);
const topBorderGreen = Color.fromARGB(6, 95, 247, 115);

///SensorListItem
const sensorGreen = Color.fromARGB(255, 64, 236, 73);

///Map
const mapGreen = Color.fromARGB(255, 58, 216, 10);
const mapBlue = Color.fromARGB(255, 0, 112, 204);

//--Dark Mode Colors
Color iconLightRed = passwordIconColor();
Color textLightRed = passwordChangeColor();
Color invertedColor = invertedColour();
Color textInverted = getInvertedTextColor();
Color buttonTextInversedColor = getButtonTexInversedColor();
Color buttonTextColor = getButtonTextColor();
Color background = white;
Color darkBackground = Color(0xFF555555);
Color lighterBackground = changeBackgroundLighter();
Color textColor = getTextColor();

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
