import 'package:flutter/material.dart';
import 'package:forestapp/colors/appColors.dart';
import 'package:forestapp/design/logOutDialogDecoration.dart';
import 'package:forestapp/screen/loginScreen.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth * 0.9;

    return Container(
      width: dialogWidth,
      child: AlertDialog(
        title: Text(
          'Ausloggen',
          style: LogOutDecoration.getTitleTextStyle()
              .copyWith(fontSize: 24.0, color: textColor),
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              //Icon(Icons.warning, color: Colors.orange),
              SizedBox(width: 8.0),
              Text(
                'Wirklich ausloggen?',
                style: TextStyle(fontSize: 20.0, color: textColor),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: Text(
              'Abbrechen',
              style: TextStyle(
                color: buttonTextColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('Ausloggen',
                style: TextStyle(fontSize: 20.0, color: lighterBackground)),
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
        backgroundColor: background,
        elevation: 8.0,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
      ),
    );
  }
}
