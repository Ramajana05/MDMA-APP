import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:forestapp/colors/appColors.dart';

class ConfirmDialog extends StatelessWidget {
  String title;
  String content;
  VoidCallback continueCallBack;

  ConfirmDialog(this.title, this.content, this.continueCallBack, {super.key});

  TextStyle textStyle = const TextStyle(color: black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(
            title,
            style: textStyle,
          ),
          content: Text(
            content,
            style: textStyle,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Ja",
                style: TextStyle(color: textColor),
              ),
              onPressed: () {
                continueCallBack();
              },
            ),
            TextButton(
              child: Text(
                "Nein",
                style: TextStyle(color: textColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
