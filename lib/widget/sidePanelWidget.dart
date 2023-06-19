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
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 86, 252, 108),
                  primaryAppLightGreen,
                ],
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
            ), // Add leading icon
            title: const Text(
              'Profil',
              style: TextStyle(
                fontSize: 20,
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
            ), // Add leading icon
            title: const Text(
              'Startseite',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            iconColor: primaryHumidityColor,
            onTap: () async {
              const url = 'https://mdma.haveachin.de/';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Konnte diese Website nicht laden $url';
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.dark_mode_outlined,
              size: 28,
            ), //
            iconColor: const Color.fromARGB(255, 7, 19, 29),
            title: const Text(
              'Nacht modus',
              style: TextStyle(
                fontSize: 20,
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
            ), // Add leading icon
            title: const Text(
              'Hilfe',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InstructionsScreen()),
            ),
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 28,
            ), // Add leading icon
            title: const Text(
              'Ausloggen',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            iconColor: primaryTempColor,
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
