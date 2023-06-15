import 'package:flutter/material.dart';

import 'appColors.dart';

Color getBatteryColor(int batteryLevel) {
  if (batteryLevel >= 90) {
    return primaryGreen; // Green
  } else if (batteryLevel >= 60) {
    return Colors.orangeAccent;
  } else {
    return Colors.red;
  }