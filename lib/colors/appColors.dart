import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:forestapp/colors/mapDarkMode.dart';
import 'package:forestapp/service/LoginService.dart';

///App Colors
const primaryAppLightGreen = Color.fromARGB(255, 40, 233, 127);
const primaryUnselectedLabelColor = Color.fromARGB(255, 110, 110, 110);

//Basic Colors
const grey = Colors.grey;
const yellow = Color.fromARGB(255, 228, 210, 46);
const green = Colors.green;
const moonColor = Color(0xFF7CA2D8);

Color background = Color.fromARGB(255, 48, 47, 47);
Color backgroundCard = Color.fromARGB(255, 65, 64, 64);
Color white = Color.fromARGB(255, 0, 0, 0); //For some buttons
Color black = Color.fromARGB(255, 255, 255, 255); //Fonts
Color cardShadow = Color.fromARGB(255, 0, 0, 0);
String MapStyle = darkMapStyle;

void updateAppColors(bool isDarkMode) {
  if (isDarkMode) {
    background = Color.fromARGB(255, 48, 47, 47);
    backgroundCard = Color.fromARGB(255, 65, 64, 64);
    white = Colors.black;
    black = Colors.white;
    cardShadow = Colors.black;
    MapStyle = darkMapStyle;
  } else {
    background = Colors.white;
    backgroundCard = Colors.white;
    white = const Color.fromARGB(255, 255, 255, 255);
    black = const Color.fromARGB(255, 0, 0, 0);
    cardShadow = Color.fromARGB(255, 145, 143, 143);
    MapStyle = lightMapStyle;
  }
}

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

String darkMapStyle = '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000033"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]
''';

String normalMapStyle = '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#fefefe"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#d9d9d9"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]
''';
