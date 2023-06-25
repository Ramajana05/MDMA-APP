import 'package:flutter/material.dart';

import 'appColors.dart';

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
