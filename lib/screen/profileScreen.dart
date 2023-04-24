import 'package:flutter/material.dart';
import 'package:forestapp/widget/topNavBar.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 227, 227),
      appBar: TopNavBar(
        title: 'Profile',
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text('Profile Screen'),
        ),
      ),
    );
  }
}
