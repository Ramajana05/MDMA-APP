import 'package:flutter/material.dart';
import 'package:forestapp/design/logOutDialogDecoration.dart';
import 'package:forestapp/screen/loginScreen.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key, required this.onLoginSuccess})
      : super(key: key);

  final void Function() onLoginSuccess;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Logout',
        style: LogOutDecoration.getTitleTextStyle(),
      ),
      content: Row(
        children: const [
          //Icon(Icons.warning, color: Colors.orange),
          SizedBox(width: 8.0),
          Text('Are you sure you want to log out?'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Navigator.pushReplacement(
            //   context,
            // MaterialPageRoute(builder: (context) => LoginPage()),
            //     ); // Close the dialog
            //    onLoginSuccess();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: const Text('Log out'),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: Colors.white,
      elevation: 8.0,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
    );
  }
}
