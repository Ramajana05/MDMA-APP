import 'package:flutter/material.dart';

class PasswordDialog extends StatefulWidget {
  final ValueChanged<String> onCurrentPasswordChanged;
  final ValueChanged<String> onNewPasswordChanged;
  final ValueChanged<String> onConfirmPasswordChanged;
  final VoidCallback onConfirmPressed;
  final VoidCallback onCancelPressed;

  PasswordDialog({
    required this.onCurrentPasswordChanged,
    required this.onNewPasswordChanged,
    required this.onConfirmPasswordChanged,
    required this.onConfirmPressed,
    required this.onCancelPressed,
  });

  @override
  _PasswordDialogState createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  bool isLoading = false;
  String errorMessage = '';

  void _handleConfirmPressed() {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    // Simulate an asynchronous operation
    Future.delayed(Duration(seconds: 2), () {
      // Perform your password change logic here
      // Replace this with actual password change code

      // Simulate a success response
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Passwort Ändern'),
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Aktuelles Passwort',
                ),
                obscureText: true,
                onChanged: widget.onCurrentPasswordChanged,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Neues Passwort',
                ),
                obscureText: true,
                onChanged: widget.onNewPasswordChanged,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Neues Passwort bestätigen',
                ),
                obscureText: true,
                onChanged: widget.onConfirmPasswordChanged,
              ),
              if (isLoading)
                CircularProgressIndicator()
              else if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: widget.onCancelPressed,
          child: Text(
            'Abbrechen',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        TextButton(
          onPressed: widget.onConfirmPressed,
          child: isLoading ? CircularProgressIndicator() : Text('Bestätigen'),
        ),
      ],
    );
  }
}
