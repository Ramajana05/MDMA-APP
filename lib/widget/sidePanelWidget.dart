import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../colors/appColors.dart';
import '../dialog/logoutDialog.dart';
import '../screen/profileScreen.dart';
import 'package:provider/provider.dart';
import 'package:forestapp/provider/userProvider.dart';
import 'package:forestapp/screen/helpScreen.dart';

class SidePanel extends StatelessWidget {
  Future<String?> _getLoggedInUsername(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context);
    final loggedInUsername = userProvider.loggedInUsername;

    return loggedInUsername ?? ''; // Replace with your actual logic
  }

  bool isNightMode = false;
  late final Function(bool) onToggle;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isScreenBig = screenHeight >= 600; // Adjust the threshold as needed
    final drawerHeight = isScreenBig ? screenHeight / 2.8 : 0;

    return Drawer(
      child: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              size: 28,
            ),
            title: const Text(
              'Profil',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            iconColor: primaryAppLightGreen,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.public,
              size: 28,
            ),
            title: const Text(
              'Startseite',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            iconColor: Colors.blue,
            onTap: () async {
              const url = 'https://mdma.haveachin.de/';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Die Website $url konnte nicht geladen werden';
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.dark_mode_outlined,
              size: 28,
            ),
            iconColor: blue,
            title: const Text(
              'Nacht Modus',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InstructionsScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.help_outline_outlined,
              size: 28,
            ),
            title: const Text(
              'Hilfe',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InstructionsScreen()),
            ),
          ),
          SizedBox(height: isScreenBig ? screenHeight / 2.8 : 0),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 28,
            ),
            title: const Text('Ausloggen',
                style: TextStyle(
                  fontSize: 18,
                )),
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
