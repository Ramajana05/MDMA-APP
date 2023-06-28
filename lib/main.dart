import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestapp/colors/appColors.dart';
import 'package:forestapp/screen/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:forestapp/db/databaseInitializer.dart';
import 'package:forestapp/provider/userProvider.dart';
import 'package:forestapp/service/loginService.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: background,
      systemNavigationBarColor: background,
    ));

    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(); // You can display a loading indicator here
        }

        if (snapshot.hasError || snapshot.data == null) {
          // Handle error if dark mode initialization fails
          return Container(); // You can display an error message here
        }

        return ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: snapshot.data! ? Brightness.dark : Brightness.light,
              // Define your light mode theme here
              //...
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              // Define your dark mode theme here
              //...
            ),
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
