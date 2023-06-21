import 'package:flutter/material.dart';

import '../colors/appColors.dart';

class SnackbarWidget extends StatelessWidget {
  final Widget content;

  const SnackbarWidget({required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: double.infinity,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: invertedColor),
            SizedBox(width: 8.0),
            Expanded(
              child: DefaultTextStyle.merge(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                child: content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
