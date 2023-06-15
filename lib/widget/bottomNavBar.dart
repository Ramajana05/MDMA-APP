import 'package:flutter/material.dart';
import 'package:forestapp/screen/dashboardScreen.dart';
import 'package:forestapp/screen/mapScreen.dart';
import 'package:forestapp/screen/scanScreen.dart';
import 'package:forestapp/design/bottomNavBarDecoration.dart';
import 'package:forestapp/screen/sensorListScreen.dart';
import '../screen/statisticScreen.dart';

class BottomTabBar extends StatefulWidget {
  BottomTabBar({Key? key}) : super(key: key);

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int _index = 0;
  final screens = [
    const DashboardScreen(),
    StatisticsScreen(),
    MapScreen(),
    ScanScreen(),
    const SensorListScreen(),
  ];

  final List<Color> tabColors = [
    const Color.fromARGB(204, 0, 165, 22), // Dashboard
    Colors.blue, // Statistics
    Colors.red, // Map
    Colors.blue, // QR Code
    const Color.fromARGB(204, 0, 165, 22), // Sensors
  ];

  void updateSelectedIndex(int newIndex) {
    _index = newIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: Container(
        decoration: bottomNavBarDecoration2,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _index,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.black,
          selectedItemColor: tabColors[
              _index], // Use the respective color for the selected tab

          onTap: (value) {
            setState(() {
              _index = value;
            });
          },
          backgroundColor: const Color.fromARGB(255, 253, 253, 253),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard,
                size: 32, // Increase the size of the icon
              ),
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bar_chart_outlined,
                size: 32, // Increase the size of the icon
              ),
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.pin_drop,
                size: 32, // Increase the size of the icon
              ),
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.qr_code_scanner,
                size: 32, // Increase the size of the icon
              ),
              label: '', // Empty label
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.sensors,
                size: 32, // Increase the size of the icon
              ),
              label: '', // Empty label
            ),
          ],
        ),
      ),
    );
  }
}
