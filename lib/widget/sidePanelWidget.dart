import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dialog/logoutDialog.dart';
import '../screen/profileScreen.dart';
import 'package:provider/provider.dart';
import 'package:forestapp/provider/userProvider.dart';
import 'package:forestapp/screen/helpScreen.dart';

class SidePanel extends StatefulWidget {
  const SidePanel({Key? key}) : super(key: key);

  @override
  _SidePanelState createState() => _SidePanelState();
}

class _SidePanelState extends State<SidePanel> {
  bool isDarkMode = false;
  Future<String?> _getLoggedInUsername(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context);
    final loggedInUsername = userProvider.loggedInUsername;

    return loggedInUsername ?? ''; // Replace with your actual logic
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
            iconColor: const Color.fromARGB(255, 40, 233, 127),
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
                throw 'Website konnte nicht geladen werden: $url';
              }
            },
          ),
          ListTile(
            leading: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: isDarkMode ? Colors.yellow : Colors.black,
              size: 28,
            ),
            title: Text(
              isDarkMode ? 'Heller Modus' : 'Dunkler Modus',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
          // ),ListTile(
          //   leading: const Icon(
          //     Icons.font_download_outlined,
          //     size: 28,
          //   ), // Add leading icon
          //   title: const Text(
          //     'Schriftgröße',
          //     style: TextStyle(
          //       fontSize: 18,
          //     ),
          //   ),
          //   onTap: () {
          //
          // },
          //  ),
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
    );
  }
}
