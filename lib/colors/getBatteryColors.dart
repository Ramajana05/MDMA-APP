import 'package:flutter/material.dart';

import 'appColors.dart';

Color getBatteryColor(int batteryLevel) {
  if (batteryLevel > 60) {
    return primaryGreen; // Green
  } else if (batteryLevel <= 60 && batteryLevel > 30) {
    return Colors.orangeAccent;
  } else {
    return Colors.red;
  }
}
