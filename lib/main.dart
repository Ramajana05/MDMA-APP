import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestapp/provider/userProvider.dart';
import 'package:forestapp/screen/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

import 'colors/appColors.dart';
import 'db/databaseInitializer.dart';
import 'provider/ThemeProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();

  final databaseInitializer = DatabaseInitializer();
  await databaseInitializer.initDatabase();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: background, systemNavigationBarColor: background));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData,
      home: SplashScreen(),
    );
  }
}
