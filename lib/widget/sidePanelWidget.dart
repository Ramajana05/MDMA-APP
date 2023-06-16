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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 1,
          child: Column(
            children: [
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
                    fontSize: 18,
                  ),
                ),
                iconColor: Color.fromARGB(255, 40, 233, 127),
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
                    fontSize: 18,
                  ),
                ),
                iconColor: Colors.blue,
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
                  Icons.help_outline_outlined,
                  size: 28,
                ), // Add leading icon
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
              const Spacer(),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  size: 28,
                ), // Add leading icon
                title: const Text(
                  'Ausloggen',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                iconColor: Colors.red,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const LogoutDialog(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
