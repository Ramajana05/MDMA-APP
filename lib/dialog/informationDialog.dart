import 'package:flutter/material.dart';
import 'package:forestapp/design/logOutDialogDecoration.dart';
import 'package:forestapp/screen/loginScreen.dart';

import '../colors/appColors.dart';

class InformationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Information",
        style: TextStyle(fontSize: 22), // Increase the font size as desired
      ),
      backgroundColor: white,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: const [
              Text(
                "Sensoren Akkustand",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              Icon(
                Icons.battery_full,
                color: primaryGreen,
                size: 22,
              ),
              SizedBox(width: 8),
              Text(
                '100% - 60%',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(
                Icons.battery_5_bar,
                color: primaryOrange,
                size: 22,
              ),
              SizedBox(width: 8),
              Text(
                '60% - 30%',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(
                Icons.battery_2_bar,
                color: red,
                size: 22,
              ),
              SizedBox(width: 8),
              Text(
                'Unter 30%',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text(
                "Standort Bevölkerung",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(
                Icons.person,
                color: primaryGreen,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                '+ 10',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(
                Icons.person,
                color: primaryVisitorModerateCountColor,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                '5 - 10',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(
                Icons.person,
                color: primaryVisitorLowCountColor,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                '< 5',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
