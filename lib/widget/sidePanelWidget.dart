import 'package:flutter/material.dart';
import 'package:forestapp/dialog/logoutDialog.dart';
import 'package:forestapp/db/sessionProvider.dart';

class SidePanel extends StatelessWidget {
  Future<String?> _getLoggedInUsername() async {
    // Add your logic to retrieve the logged-in username
    // For example, you can use the session provider or any other authentication mechanism

    // Return the username or null if not available
    return 'MDMA'; // Replace with your actual logic
  }

  static const Color startGradientColor = Color.fromARGB(255, 86, 252, 108);
  static const Color endGradientColor = Color.fromARGB(255, 40, 233, 127);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 100,
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
                    width: 4.0,
                  ),
                ),
                gradient: LinearGradient(
                  colors: [
                    startGradientColor,
                    endGradientColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/cover.jpg'),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('Einstellungen'),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('Fragen und Antwort'),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
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
