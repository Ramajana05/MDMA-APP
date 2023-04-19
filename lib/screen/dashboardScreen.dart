import 'package:flutter/material.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'package:forestapp/widget/warningWidget.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 227, 227),
      appBar: TopNavBar(
        title: 'DASHBOARD',
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: Column(
        children: [
          WarningWidget(message: "Warnungs Beispiel 1"),
          WarningWidget(message: "Warnungs Beispiel 2"),
          WarningWidget(message: "Warnungs Beispiel 3"),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Align(
              alignment: Alignment.bottomCenter,
            ),
          ),
        ],
      ),
    );
  }
}
