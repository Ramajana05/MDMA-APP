import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestapp/screen/damagesDashboardScreen.dart';
import 'package:forestapp/screen/dashboardScreen.dart';
import 'package:forestapp/screen/loginScreen.dart';
import 'package:forestapp/screen/damageReport.dart';
import 'package:forestapp/widget/bottomNavBar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:forestapp/service/loginService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(0, 231, 229, 229),
        systemNavigationBarColor: Color.fromARGB(0, 255, 255, 255)));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      //home: BottomTabBar(),
    );
  }
}
