import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dialog/logoutDialog.dart';
import '../screen/profileScreen.dart';

class SidePanel extends StatelessWidget {
  Future<String?> _getLoggedInUsername() async {
    // Add your logic to retrieve the logged-in username
    // For example, you can use the session provider or any other authentication mechanism

    // Return the username or null if not available
    return 'MDMA'; // Replace with your actual logic
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 86, 252, 108),
                  Color.fromARGB(255, 40, 233, 127),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/1158/1158504.png'),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<String?>(
                    future: _getLoggedInUsername(),
                    builder: (BuildContext context,
                        AsyncSnapshot<String?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // While waiting for the future to complete, show a loading indicator
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // If an error occurred, display an error message
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // If the future completed successfully, display the username
                        final String? username = snapshot.data;
                        return Text(
                          username ?? 'Unknown',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person), // Add leading icon
            title: const Text('Profile'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.public), // Add leading icon
            title: const Text('Website'),
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
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout), // Add leading icon
            title: const Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const LogoutDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}
