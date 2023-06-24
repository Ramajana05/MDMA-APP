import 'package:flutter/material.dart';
import '../colors/appColors.dart';

class MapPopup extends StatelessWidget {
  final String objectName;

  const MapPopup({required this.objectName});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 60,
        color: background,
        child: Center(
          child: Text(
            objectName,
            style: TextStyle(fontSize: 18, color: textColor),
          ),
        ),
      ),
    );
  }
}
