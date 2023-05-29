import 'package:flutter/material.dart';
import 'package:forestapp/widget/topNavBarBasic.dart';
import 'package:forestapp/dialog/changePasswordDialog.dart';
import 'package:forestapp/dialog/deleteProfileDialog.dart';
import 'package:forestapp/screen/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:forestapp/provider/userProvider.dart';

class ProfileScreen extends StatefulWidget {
  final String? currentUsername;

  ProfileScreen({
    this.currentUsername,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String currentPassword = '';
  String newPassword = '';
  String confirmPassword = '';

  void changePassword() {
    // Implement the logic to change the password
    // Validate the input and perform the necessary actions
    // For demonstration purposes, let's print the new password
    print('New Password: $newPassword');
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final loggedInUsername = userProvider.loggedInUsername;
    final role = userProvider.role;
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = screenHeight * 0.18;

    return Scaffold(
      appBar: TopNavBarBasic(
        title: 'Mein Profil',
        returnStatus: true,
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0),
              child: Text(
                'Informationen',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 1.0,
                color: Colors.grey[150], // Soft grey color
                child: Column(
                  children: [
                    buildProfileItem(Icons.person, loggedInUsername ?? ''),
                    Divider(),
                    buildProfileItem(Icons.phone_android, 'Förster'),
                    Divider(),
                    buildProfileItem(
                        Icons.location_on, 'Heilbronn, Deutschland'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0),
              child: Text(
                'Aktionen',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 2.0,
                color:
                    const Color.fromARGB(255, 255, 255, 255), // Soft grey color
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return PasswordDialog(
                              onCurrentPasswordChanged: (value) {
                                // Handle current password change
                              },
                              onNewPasswordChanged: (value) {
                                // Handle new password change
                              },
                              onConfirmPasswordChanged: (value) {
                                // Handle confirm new password change
                              },
                              onConfirmPressed: () {
                                // Handle confirm button press
                                Navigator.of(context).pop();
                              },
                              onCancelPressed: () {
                                // Handle cancel button press
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );
                      },
                      child: buildProfileItem(Icons.lock, 'Passwort Ändern'),
                    ),
                    Divider(),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => DeleteProfileDialog(
                            onCancelPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            onDeletePressed: () {
                              Navigator.of(context).pop();
                              // Handle account deletion logic
                            },
                          ),
                        );
                      },
                      child: buildProfileItem(Icons.delete, 'Account Löschen'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem(IconData icon, String text) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color.fromARGB(255, 24, 23, 23),
        size: 20.0,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
          color: const Color.fromARGB(255, 20, 20, 20),
        ),
      ),
    );
  }
}
