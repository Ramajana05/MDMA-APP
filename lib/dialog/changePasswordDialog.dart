import 'package:flutter/material.dart';

import '../colors/appColors.dart';

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
  String currentPassword = '';
  String newPassword = '';
  String confirmPassword = '';
  bool isLoading = false;
  String errorMessage = '';
  bool _obscurecurrentPassword = true;
  bool _obscurenewPassword = true;

  String getCurrentPasswordValue() {
    return currentPassword;
  }

  String getNewPasswordValue() {
    return newPassword;
  }

  String getConfirmPasswordValue() {
    return confirmPassword;
  }

  void validatePasswords() {
    if (newPassword != confirmPassword) {
      setState(() {
        errorMessage = 'Die Passwörter stimmen nicht überein.';
      });
    } else {
      setState(() {
        errorMessage = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Passwort Ändern',
        style: TextStyle(
          fontSize: 24, // Hier kannst du die gewünschte Schriftgröße einstellen
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.99,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Aktuelles Passwort',
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: primaryAppLightGreen,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    focusColor: primaryAppLightGreen,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurecurrentPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: dialogIconColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurecurrentPassword = !_obscurecurrentPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurecurrentPassword,
                  onChanged: (value) {
                    setState(() {
                      currentPassword = value;
                    });
                    widget.onCurrentPasswordChanged(value);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Neues Passwort',
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: primaryAppLightGreen,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    focusColor: primaryAppLightGreen,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurenewPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: dialogIconColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurenewPassword = !_obscurenewPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurenewPassword,
                  onChanged: (value) {
                    setState(() {
                      newPassword = value;
                    });
                    widget.onNewPasswordChanged(value);
                  },
                ),
              ),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Neues Passwort bestätigen',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: primaryAppLightGreen,
                      width: 2.0,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  focusColor: primaryAppLightGreen,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurenewPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: dialogIconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurenewPassword = !_obscurenewPassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurenewPassword,
                onChanged: (value) {
                  setState(() {
                    confirmPassword = value;
                  });
                  widget.onConfirmPasswordChanged(value);
                },
              ),

              if (isLoading)
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ), // Show CircularProgressIndicator when isLoading is true
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    errorMessage,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onCancelPressed,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.grey,
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 255, 255, 255),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Abbrechen',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onConfirmPressed,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 255, 255, 255),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      primaryAppLightGreen,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator()
                      : const Text(
                          'Bestätigen',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
