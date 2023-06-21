import 'package:flutter/material.dart';
import 'package:forestapp/colors/appColors.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'package:forestapp/widget/warningWidget.dart';

class AlertScreen extends StatefulWidget {
  AlertScreen({Key? key}) : super(key: key);

  @override
  State<AlertScreen> createState() => _AlertScreen();
}

class _AlertScreen extends State<AlertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: TopNavBar(
        title: 'Alert',
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: Column(
        children: [
          WarningWidget(message: "Your phone is about to overheat"),
          WarningWidget(message: "Your battery is running low"),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text('Alert Screen'),
            ),
          ),
        ],
      ),
    );
  }
}
