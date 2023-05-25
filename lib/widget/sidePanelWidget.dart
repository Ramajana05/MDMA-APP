import 'package:flutter/material.dart';
import 'package:forestapp/dialog/logoutDialog.dart';
import 'package:forestapp/db/sessionProvider.dart';
import 'package:url_launcher/url_launcher.dart';

class SidePanel extends StatelessWidget {
  Future<String?> _getLoggedInUsername() async {
    // Add your logic to retrieve the logged-in username
    // For example, you can use the session provider or any other authentication mechanism

    // Return the username or null if not available
    return ''; // Replace with your actual logic
  }

  static const Color startGradientColor = Color.fromARGB(255, 86, 252, 108);
  static const Color endGradientColor = Color.fromARGB(255, 40, 233, 127);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            // Wrap Container with Expanded
            child: Container(
              width: double.infinity,
              height: 80, // Adjust the height as desired
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    startGradientColor,
                    endGradientColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ), // Set the width to occupy the entire available space
              child: DrawerHeader(
                child: FutureBuilder<String?>(
                  future: _getLoggedInUsername(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // While waiting for the future to complete, show a loading indicator
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // If an error occurred, display an error message
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // If the future completed successfully, display the username
                      final String? username = snapshot.data;
                      return Text(
                        username ?? 'Unknown',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      );
                    }
                  },
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person), // Add leading icon
            title: Text('Profil'),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            leading: Icon(Icons.public), // Add leading icon
            title: Text('Website'),
            onTap: () async {
              const url =
                  'https://www.hs-heilbronn.de/de'; // Replace with your desired URL
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.logout), // Add leading icon
            title: Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => LogoutDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}
