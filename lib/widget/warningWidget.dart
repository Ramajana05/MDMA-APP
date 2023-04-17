import 'package:flutter/material.dart';

class WarningWidget extends StatelessWidget {
  final String message;

  WarningWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(
              255, 216, 216, 216), // Set the background color to green
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.warning, color: Colors.yellow[800], size: 32.0),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("WARNING",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                SizedBox(height: 8.0),
                Text(message, style: TextStyle(fontSize: 16.0)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
