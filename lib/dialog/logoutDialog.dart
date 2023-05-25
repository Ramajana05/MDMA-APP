import 'package:flutter/material.dart';
import 'package:forestapp/design/logOutDialogDecoration.dart';
import 'package:forestapp/screen/loginScreen.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Ausloggen',
        style: LogOutDecoration.getTitleTextStyle(),
      ),
      content: Row(
        children: [
          //Icon(Icons.warning, color: Colors.orange),
          SizedBox(width: 8.0),
          Text('Wirklich ausloggen?'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Abbrechen',
            style: TextStyle(
              color: Colors.grey, // Set the text color to green
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            ); // Close the dialog
          },
          child: Text('Ausloggen'),
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
