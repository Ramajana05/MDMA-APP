import 'dart:ui';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  String title;
  String content;
  VoidCallback continueCallBack;

  ConfirmDialog(this.title, this.content, this.continueCallBack);
  TextStyle textStyle = TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: new Text(
            title,
            style: textStyle,
          ),
          content: new Text(
            content,
            style: textStyle,
          ),
          actions: <Widget>[
            TextButton(
              child: new Text("Ja"),
              onPressed: () {
                continueCallBack();
              },
            ),
            TextButton(
              child: Text("Nein"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
