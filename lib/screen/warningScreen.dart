import 'package:flutter/material.dart';
import 'package:forestapp/widget/topNavBar.dart';

class WarningScreen extends StatefulWidget {
  WarningScreen({Key? key}) : super(key: key);

  @override
  State<WarningScreen> createState() => _WarningScreen();
}

class _WarningScreen extends State<WarningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 227, 227),
      appBar: TopNavBar(
        title: 'Warning',
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text('Warning Screen'),
        ),
      ),
    );
  }
}
