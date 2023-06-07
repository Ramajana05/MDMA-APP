import 'package:flutter/material.dart';
import 'package:forestapp/design/logOutDialogDecoration.dart';
import 'package:forestapp/screen/loginScreen.dart';

class InformationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Information"),
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
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.battery_full,
                color: Color.fromARGB(255, 46, 202, 51),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                '100% - 60%',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.battery_5_bar,
                color: Colors.orange,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                '60% - 30%',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.battery_2_bar,
                color: Colors.red,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Unter 30%',
                style: TextStyle(fontSize: 16),
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
              ),
              SizedBox(width: 8),
              Text(
                '+ 10',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.person,
                color: Color.fromARGB(255, 128, 197, 130),
              ),
              SizedBox(width: 8),
              Text(
                '5 - 10',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.person,
                color: Color.fromARGB(255, 170, 169, 169),
              ),
              SizedBox(width: 8),
              Text(
                '< 5',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
