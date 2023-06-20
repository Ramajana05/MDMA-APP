import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../colors/appColors.dart';
import '../dialog/logoutDialog.dart';
import '../screen/profileScreen.dart';
import 'package:provider/provider.dart';
import 'package:forestapp/provider/userProvider.dart';
import 'package:forestapp/screen/helpScreen.dart';

import 'bottomNavBar.dart';

class SidePanel extends StatefulWidget {
  const SidePanel({Key? key}) : super(key: key);

  @override
  State<SidePanel> createState() => _SidePanel();
}

class _SidePanel extends State<SidePanel> {
  Future<String?> _getLoggedInUsername(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context);
    final loggedInUsername = userProvider.loggedInUsername;

    return loggedInUsername ?? ''; // Replace with your actual logic
  }

  bool _lightMode = false; //( true-->Light mode  /  false-->Dark mode )
  changeThemeMode() {
    setState(() {
      if (_lightMode) {
        // colors of Light Mode
        primarybackgroundColor = Colors.white;
        dashboard_background_Color=Colors.white;

        _lightMode = false;
      } else {
        // colors of Dark Mode
        primarybackgroundColor = Colors.black;
        dashboard_text_Color=Colors.black;

        _lightMode = true;
      }
    });
  }

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
                  primarybackgroundColor,
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
                Icons.dark_mode_outlined,
                size: 28,
              ), //
              iconColor: const Color.fromARGB(255, 7, 19, 29),
              title: Text(
                _lightMode ? 'Light mode' : 'Dark mode',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () => {
                    changeThemeMode(),
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => CustomBottomTabBar()),
                    // ),
                  }),
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
