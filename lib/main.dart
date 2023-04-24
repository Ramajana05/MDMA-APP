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
      title: "Forest App",
      debugShowCheckedModeBanner: false,
      home: LoginPage(
        onLoginSuccess: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                body: _widgetOptions.elementAt(_selectedIndex),
                bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.space_dashboard),
                      label: 'Dashboard',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.bar_chart),
                      label: 'Statistic',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.location_on),
                      label: 'Location',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.notifications),
                      label: 'DamageDashboard',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.warning),
                      label: 'Warnings',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,
                  onTap: _onItemTapped,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
