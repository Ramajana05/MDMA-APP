import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:forestapp/screen/splashScreen.dart';
import 'package:wakelock/wakelock.dart';

import 'package:forestapp/db/databaseInitializer.dart';
import 'package:forestapp/provider/userProvider.dart';
import 'package:forestapp/screen/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();

  final databaseInitializer = DatabaseInitializer();
  await databaseInitializer.initDatabase();

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

enum ThemeMode { light, dark }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white, systemNavigationBarColor: Colors.white));
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
