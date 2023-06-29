import 'package:flutter/material.dart';
import 'appColors.dart';

/// Returns the color for the battery based on the battery level.
/// If the [batteryLevel] is greater than 60, returns the primaryGreen color.
/// If the [batteryLevel] is between 30 and 60 (inclusive), returns the orangeAccent color.

Color getBatteryColor(int batteryLevel) {
  if (batteryLevel > 60) {
    return primaryGreen; // Green
  } else if (batteryLevel <= 60 && batteryLevel > 30) {
    return Colors.orangeAccent;
  } else {
    return red;
  }
}

Color getVisitorColor(int visitorCount) {
  if (visitorCount >= 10) {
    return primaryGreen;
  } else if (visitorCount >= 5 && visitorCount <= 10) {
    return infoGreen;
  } else {
    return infoGrey;
  }
}
