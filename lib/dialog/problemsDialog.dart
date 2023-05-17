import 'package:flutter/material.dart';
import 'package:forestapp/design/logOutDialogDecoration.dart';

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
            Text('Wenden Sie sich an den Support'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Zurück',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Ok'),
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 40, 233, 127),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9.0),
      ),
      backgroundColor: Colors.white,
      elevation: 8.0,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
    );
  }
}
