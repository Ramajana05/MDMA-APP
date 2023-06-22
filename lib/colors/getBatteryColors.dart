import 'package:flutter/material.dart';

import 'appColors.dart';

Color getBatteryColor(int batteryLevel) {
  if (batteryLevel >= 90) {
    return primaryGreen;
  } else if (batteryLevel >= 75) {
    return primaryGreen;
  } else if (batteryLevel >= 60) {
    return orange;
  } else if (batteryLevel >= 45) {
    return orange;
  } else if (batteryLevel >= 30) {
    return red;
  } else if (batteryLevel >= 15) {
    return red;
  } else if (batteryLevel >= 5) {
    return red;
  } else {
    return red;
  }
}
