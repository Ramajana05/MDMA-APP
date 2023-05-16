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

import 'package:forestapp/screen/scanScreen.dart';
import 'package:forestapp/widget/bottomNavBar.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:forestapp/service/loginService.dart';

import 'dart:io';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  await initDatabase();
  runApp(MyApp());
}

Future<void> initDatabase() async {
  try {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'MDMADatabase.db');

    final databaseExists = await File(path).exists();

    if (!databaseExists) {
      final dbAssetPath = await getDatabaseAssetPath();
      await copyDatabase(dbAssetPath, path);
    }
  } catch (e) {
    // Handle any errors that occur during database initialization
    print('Database initialization failed: $e');
    rethrow;
  }
}

Future<String> getDatabaseAssetPath() async {
  try {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final manifest = json.decode(manifestContent) as Map<String, dynamic>;
    final dbPath = manifest.keys
        .firstWhere((key) => key.contains('assets/database/MDMADatabase.db'));
    return dbPath;
  } catch (e) {
    // Handle any errors related to loading the asset manifest
    print('Error loading database asset path: $e');
    rethrow;
  }
}

Future<void> copyDatabase(String dbAssetPath, String dbPath) async {
  try {
    final byteData = await rootBundle.load(dbAssetPath);
    final bytes = byteData.buffer.asUint8List();

    await File(dbPath).writeAsBytes(bytes);
  } catch (e) {
    // Handle any errors related to copying the database
    print('Error copying database: $e');
    rethrow;
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white, systemNavigationBarColor: Colors.white));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: LoginPage(),
      home: BottomTabBar(),
    );
  }
}
