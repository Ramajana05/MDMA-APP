import 'dart:ui';
import 'package:flutter/material.dart';

import '../colors/appColors.dart';

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
              child: const Text("Ja"),
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
