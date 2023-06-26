import 'package:flutter/material.dart';
import 'package:forestapp/screen/dashboardScreen.dart';
import 'package:forestapp/screen/mapScreen.dart';
import 'package:forestapp/screen/scanScreen.dart';
import 'package:forestapp/design/bottomNavBarDecoration.dart';
import 'package:forestapp/screen/sensorListScreen.dart';
import '../screen/statisticScreen.dart';
import '../colors/appColors.dart';

class CustomBottomTabBar extends StatefulWidget {
  int index = 0;

  CustomBottomTabBar({int trans_index = 0}) {
    index = trans_index;
  }

  @override
  State<CustomBottomTabBar> createState() => _CustomBottomTabBarState();
}

class _CustomBottomTabBarState extends State<CustomBottomTabBar> {
  final screens = [
    DashboardScreen(),
    StatisticsScreen(),
    MapScreen(),
    ScanScreen(),
    SensorListScreen(),
  ];

  final List<Color> tabColors = [
    primaryAppLightGreen, // Dashboard
    primaryAppLightGreen, // Statistics
    primaryAppLightGreen, // Map
    primaryAppLightGreen, // QR Code
    primaryAppLightGreen, // Sensors
  ];

  void updateSelectedIndex(int newIndex) {
    widget.index = newIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: screens[widget.index],
      bottomNavigationBar: Container(
        decoration: bottomNavBarDecoration2,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: widget.index,
          showUnselectedLabels: false,
          unselectedItemColor: black,
          selectedItemColor: tabColors[widget.index],
          // Use the respective color for the selected tab

          onTap: (value) {
            setState(() {
              widget.index = value;
            });
          },

          items: [
            BottomNavigationBarItem(
              backgroundColor: background,
              icon: Icon(Icons.dashboard_outlined),
              label: 'Dashbaord',
            ),
            BottomNavigationBarItem(
              backgroundColor: background,
              icon: Icon(Icons.line_axis_outlined),
              label: 'Statistik',
            ),
            BottomNavigationBarItem(
              backgroundColor: background,
              icon: Icon(Icons.pin_drop_outlined),
              label: 'Karte',
            ),
            BottomNavigationBarItem(
              backgroundColor: background,
              icon: Icon(Icons.qr_code),
              label: 'QR Code',
            ),
            BottomNavigationBarItem(
              backgroundColor: background,
              icon: Icon(Icons.sensors),
              label: 'Sensoren',
            ),
          ],
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
