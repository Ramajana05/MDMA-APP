import 'dart:ui';

import 'package:flutter/material.dart';

import '../provider/ThemeProvider.dart';

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
const red = Color.fromARGB(255, 255, 89, 77);
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
const lightblue = Color.fromARGB(255, 177, 230, 255);

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
const statDeepPurple = Color(0xFF800080);

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

/// Logout Dialog
const black26 = Colors.black26;

///Warning Widget
const warningGrey = Color.fromARGB(255, 170, 170, 170);

///Profile
const lightRed = Color.fromARGB(255, 255, 161, 152);

///TopNavBar
const topGreen = Color.fromARGB(255, 86, 252, 108);
const topBorderGreen = Color.fromARGB(6, 95, 247, 115);

///SensorListItem
const sensorGreen = Color.fromARGB(255, 64, 236, 73);

///SidePanel
const gradient = [
  topGreen,
  primaryAppLightGreen,
];

///Map
const mapGreen = Color.fromARGB(255, 58, 216, 10);
const mapBlue = Color.fromARGB(255, 0, 112, 204);

bool isNightMode = true;
//--Dark Mode Colors
Color iconLightRed = ThemeProvider().passwordIconColor();
Color textLightRed = ThemeProvider().passwordChangeColor();
Color invertedColor = ThemeProvider().invertedColour();
Color textInverted = ThemeProvider().getInvertedTextColor();
Color buttonTextInversedColor = ThemeProvider().getButtonTexInversedColor();
Color buttonTextColor = ThemeProvider().getButtonTextColor();
Color background = white;
Color darkBackground = Color(0xFF555555);
Color lighterBackground = ThemeProvider().changeBackgroundLighter();
Color textColor = ThemeProvider().getTextColor();
Color bottomNavSelectColor = ThemeProvider().getBottomNavColor();
Color iconColour = ThemeProvider().iconColor();
