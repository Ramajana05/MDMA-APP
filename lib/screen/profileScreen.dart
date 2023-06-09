import 'package:flutter/material.dart';
import 'package:forestapp/widget/topNavBarBasic.dart';
import 'package:forestapp/dialog/changePasswordDialog.dart';
import 'package:forestapp/screen/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:forestapp/provider/userProvider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:forestapp/service/LoginService.dart';

import '../colors/appColors.dart';

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

  String getCurrentPasswordValue() {
    return currentPassword;
  }

  String getNewPasswordValue() {
    return newPassword;
  }

  String getConfirmPasswordValue() {
    return confirmPassword;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final loggedInUsername = userProvider.loggedInUsername;
    final role = userProvider.role;
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = screenHeight * 0.18;

    return Scaffold(
      backgroundColor: background,
      appBar: TopNavBarBasic(
        title: 'Mein Profil ',
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
              padding: EdgeInsets.fromLTRB(20.0, 24.0, 24.0, 0),
              child: Text(
                'Persönliche Daten',
                style: TextStyle(
                  color: black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                elevation: 1.0,
                color: background, // Soft grey color
                child: Column(
                  children: [
                    buildProfileItem(Icons.person, loggedInUsername ?? ''),
                    const Divider(),
                    buildProfileItem(Icons.phone_android, 'Förster'),
                    const Divider(),
                    FutureBuilder<String>(
                      future: getLocationName(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return buildProfileItem(
                            Icons.location_on,
                            snapshot.data ?? '',
                          );
                        } else if (snapshot.hasError) {
                          return buildProfileItem(Icons.location_off, 'Error');
                        }
                        return buildProfileItem(
                            Icons.location_on, 'Loading...');
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 24.0, 24.0, 0),
              child: Text(
                'Kontoaktionen',
                style: TextStyle(
                  color: black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                elevation: 2.0,
                color: background, // Soft grey color
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return PasswordDialog(
                              onCurrentPasswordChanged: (value) {
                                currentPassword = value;
                              },
                              onNewPasswordChanged: (value) {
                                newPassword = value;
                              },
                              onConfirmPasswordChanged: (value) {
                                confirmPassword = value;
                              },
                              onConfirmPressed: () async {
                                final userProvider = Provider.of<UserProvider>(
                                  context,
                                  listen: false,
                                );
                                final loggedInUsername =
                                    userProvider.loggedInUsername;

                                final loginService = LoginService();
                                final currentPassword = await loginService
                                    .fetchPasswordFromDatabase(
                                  loggedInUsername!,
                                );

                                // Retrieve the entered values for current password, new password, and confirm password
                                final enteredCurrentPassword =
                                    getCurrentPasswordValue();
                                final enteredNewPassword =
                                    getNewPasswordValue();
                                final enteredConfirmPassword =
                                    getConfirmPasswordValue();

                                // Compare the entered values with the current password and each other
                                if (enteredCurrentPassword == currentPassword &&
                                    enteredNewPassword ==
                                        enteredConfirmPassword) {
                                  // Passwords match, perform the password change in the database
                                  await loginService.changePasswordInDatabase(
                                    loggedInUsername,
                                    enteredNewPassword,
                                  );
                                  print('Password changed successfully');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Password changed successfully'),
                                    ),
                                  );

                                  Navigator.of(context).pop();
                                } else {
                                  // Passwords do not match or current password is incorrect
                                  print('Password change failed');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Passwort konnte nicht geändert werden.'),
                                    ),
                                  );
                                }
                              },
                              onCancelPressed: () {
                                // Handle cancel button press
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );
                      },
                      child: buildProfileItem(Icons.lock, 'Passwort Ändern',
                          iconColor: red, textColor: red),
                    ),
                  ],
                ),
              ),
            ),
            /** 
            SizedBox(height: 13),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(
                'Powered by',
                style: TextStyle(
                  color: black,
                  fontSize: 24.0,
                ),
              ),
            ),
            */
          ],
        ),
      ),
    );
  }

  Future<String> getLocationName() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String city = placemark.locality ?? '';
        String country = placemark.country ?? '';
        return '$city, $country';
      }
    } catch (e) {
      print('Error retrieving location: $e');
    }
    return '';
  }

  Widget buildProfileItem(
    IconData iconData,
    String text, {
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(
        iconData,
        color: iconColor ?? black,
        size: 24.0,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 19.0,
          color: textColor ?? black,
        ),
      ),
    );
  }
}
