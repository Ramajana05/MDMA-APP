import 'package:flutter/material.dart';
import 'package:forestapp/design/logOutDialogDecoration.dart';

import '../colors/appColors.dart';

class ProblemDialog extends StatelessWidget {
  const ProblemDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Probleme?',
        style: LogOutDecoration.getTitleTextStyle(),
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 8.0),
            Text(
              'Wenden Sie sich an den Support',
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Zurück',
            style: TextStyle(
              color: invertedColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: ElevatedButton.styleFrom(
            primary: primaryAppLightGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: const Text('Ok'),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9.0),
      ),
      backgroundColor: textInverted,
      elevation: 8.0,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
    );
  }
}
