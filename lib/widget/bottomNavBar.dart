import 'package:flutter/material.dart';
import 'package:forestapp/screen/dashboardScreen.dart';
import 'package:forestapp/screen/mapScreen.dart';
import 'package:forestapp/screen/scanScreen.dart';
import 'package:forestapp/design/bottomNavBarDecoration.dart';
import 'package:forestapp/screen/sensorListScreen.dart';
import '../colors/appColors.dart';
import '../screen/statisticScreen.dart';

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
    const DashboardScreen(),
    const StatisticsScreen(),
    MapScreen(),
    ScanScreen(),
    const SensorListScreen(),
  ];

  void updateSelectedIndex(int newIndex) {
    widget.index = newIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[widget.index],
      bottomNavigationBar: Container(
        decoration: bottomNavBarDecoration2,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: widget.index,
          showUnselectedLabels: false,
          unselectedItemColor: bottomNavColor,
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
              icon: const Icon(Icons.dashboard),
              label: 'Dashbaord',
            ),
            BottomNavigationBarItem(
              backgroundColor: background,
              icon: const Icon(Icons.bar_chart_outlined),
              label: 'Statistik',
            ),
            BottomNavigationBarItem(
              backgroundColor: background,
              icon: const Icon(Icons.pin_drop),
              label: 'Karte',
            ),
            BottomNavigationBarItem(
              backgroundColor: background,
              icon: const Icon(Icons.qr_code_scanner),
              label: 'QR Code',
            ),
            BottomNavigationBarItem(
              backgroundColor: background,
              icon: const Icon(Icons.sensors),
              label: 'Sensoren',
            ),
          ],
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
