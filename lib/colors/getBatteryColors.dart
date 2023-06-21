import 'package:flutter/material.dart';

import 'appColors.dart';

Color getBatteryColor(int batteryLevel) {
  if (batteryLevel >= 90) {
    return primaryGreen;
  } else if (batteryLevel >= 60) {
    return orangeAccent;
  } else if (batteryLevel <= 40 && batteryLevel >= 60) {
    return orange;
  } else {
    return red;
  }
}