import 'package:flutter/material.dart';
import 'package:forestapp/design/logOutDialogDecoration.dart';
import 'package:forestapp/screen/loginScreen.dart';

class InformationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Information",
        style: TextStyle(fontSize: 22), // Increase the font size as desired
      ),
      backgroundColor: Color.fromARGB(220, 255, 255, 255),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "Sensoren Akkustand",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Icon(
                Icons.battery_full,
                color: Color.fromARGB(255, 46, 202, 51),
                size: 22,
              ),
              SizedBox(width: 8),
              Text(
                '100% - 60%',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.battery_5_bar,
                color: Colors.orange,
                size: 22,
              ),
              SizedBox(width: 8),
              Text(
                '60% - 30%',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.battery_2_bar,
                color: Colors.red,
                size: 22,
              ),
              SizedBox(width: 8),
              Text(
                'Unter 30%',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                "Standort Bevölkerung",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.person,
                color: Color.fromARGB(255, 46, 202, 51),
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                '+ 10',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.person,
                color: Color.fromARGB(255, 128, 197, 130),
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                '5 - 10',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.person,
                color: Color.fromARGB(255, 170, 169, 169),
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
