import 'package:flutter/material.dart';

import '../colors/appColors.dart';
import '../provider/ThemeProvider.dart';

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
      backgroundColor: background,
      title: Text(
        'Passwort Ändern',
        style: TextStyle(color: textColor),
      ),
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    labelText: 'Aktuelles Passwort',
                    labelStyle: TextStyle(color: buttonTextColor),
                    filled: true,
                    fillColor: lighterBackground,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: primaryAppLightGreen,
                        width: 2.0,
                      ),
                    ),
                    focusColor: primaryAppLightGreen,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurecurrentPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color.fromARGB(
                            255, 173, 173, 173), // Set the color of the icon
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
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    labelText: 'Neues Passwort',
                    filled: true,
                    fillColor: lighterBackground,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: primaryAppLightGreen,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: buttonTextColor,
                    ),
                    focusColor: primaryAppLightGreen,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurenewPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color.fromARGB(
                            255, 173, 173, 173), // Set the color of the icon
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
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  labelText: 'Neues Passwort bestätigen',
                  filled: true,
                  fillColor: lighterBackground,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: primaryAppLightGreen,
                      width: 2.0,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: buttonTextColor,
                  ),
                  focusColor: primaryAppLightGreen,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurenewPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color.fromARGB(
                          255, 173, 173, 173), // Set the color of the icon
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
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ), // Show CircularProgressIndicator when isLoading is true
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(
                      color: red,
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
                      const EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      grey.shade600,
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      white,
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
              const SizedBox(width: 16.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onConfirmPressed,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      buttonTextInversedColor,
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
                      ? const CircularProgressIndicator()
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
