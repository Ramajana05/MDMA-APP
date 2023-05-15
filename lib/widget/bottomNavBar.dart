import 'package:flutter/material.dart';
import 'package:forestapp/screen/dashboardScreen.dart';
import 'package:forestapp/screen/mapScreen.dart';
import 'package:forestapp/screen/scanScreen.dart';
import 'package:forestapp/screen/alertsScreen.dart';
import 'package:forestapp/design/bottomNavBarDecoration.dart';
import 'package:forestapp/screen/damagesDashboardScreen.dart';
import '../screen/statisticsScreen.dart';

class BottomTabBar extends StatefulWidget {
  BottomTabBar({Key? key}) : super(key: key);

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int _index = 0;
  final screens = [
    DashboardScreen(),
    StatisticsScreen(),
    MapScreen(),
    ScanScreen(),
    DamagesDashboardScreen(),
  ];

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
          selectedItemColor: Color.fromARGB(255, 28, 56, 45),
          onTap: (value) {
            setState(() {
              _index = value;
            });
          },
          backgroundColor: Color.fromARGB(255, 227, 227, 227),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: 'Dash',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.graphic_eq),
              label: 'Statistik',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pin_drop),
              label: 'Karte',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: 'Scanner',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.report),
              label: 'Berichte',
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
