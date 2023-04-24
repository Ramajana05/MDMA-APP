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
          WarningWidget(
            message: "Your battery is running low",
            isWarnung: true,
            iconColor: Color.fromARGB(255, 244, 146, 54),
          ),
          WarningWidget(
            message: "Your battery is running low",
            isWarnung: false,
            iconColor: Color.fromARGB(255, 54, 143, 244),
          ),
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
