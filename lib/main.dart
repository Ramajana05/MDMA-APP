import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestapp/screen/DamagesDashboardScreen.dart';
import 'package:forestapp/screen/dashboardScreen.dart';
import 'package:forestapp/screen/loginScreen.dart';
import 'package:forestapp/screen/mapScreen.dart';
import 'package:forestapp/screen/statisticsScreen.dart';
import 'package:forestapp/screen/warningScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardScreen(),
    StatisticsScreen(),
    MapScreen(),
    const DamagesDashboardScreen(),
    WarningScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(0, 53, 51, 51),
        systemNavigationBarColor: Color.fromARGB(0, 255, 255, 255)));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.space_dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Statistik',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                label: 'Standort',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Schäden',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.warning),
                label: 'Warnungen',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color.fromARGB(255, 31, 158, 80),
            unselectedItemColor: Colors.black,
            onTap: _onItemTapped,
          ),
          bottomSheet: Container(
            height: 8,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2DFFD9),
                  Color(0xFF00FF57),
                ],
              ),
            ),
          ),
        ));
  }
}
