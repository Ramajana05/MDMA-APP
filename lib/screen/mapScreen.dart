import 'package:flutter/material.dart';
import 'package:forestapp/widget/topNavBar.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 227, 227),
      appBar: TopNavBar(
        title: 'Map',
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text('Map Screen'),
        ),
      ),
    );
  }
}
