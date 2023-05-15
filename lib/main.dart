import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestapp/screen/damagesDashboardScreen.dart';
import 'package:forestapp/screen/dashboardScreen.dart';
import 'package:forestapp/screen/loginScreen.dart';
import 'package:forestapp/screen/damageReport.dart';
import 'package:forestapp/screen/statisticsScreenBalkenCHarts.dart';
import 'package:forestapp/widget/bottomNavBar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wakelock/wakelock.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Wakelock.enable();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white, systemNavigationBarColor: Colors.white));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      //home: DashboardScreen(),
    );
  }
}
