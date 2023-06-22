import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../colors/appColors.dart';
import '../dialog/logoutDialog.dart';
import '../screen/profileScreen.dart';
import 'package:provider/provider.dart';
import 'package:forestapp/provider/userProvider.dart';
import 'package:forestapp/screen/helpScreen.dart';

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

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width <= 600;
    bool isScrollable = isSmallScreen;
    return Drawer(
      backgroundColor: background,
      child: Container(
        height: MediaQuery.of(context).size.height / 1,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              physics: isScrollable
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              topGreen,
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
                        ),
                        title: Text(
                          'Profil',
                          style: TextStyle(
                            fontSize: 18,
                            color: getTextColor(),
                          ),
                        ),
                        iconColor: primaryAppLightGreen,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.public,
                          size: 28,
                        ),
                        title: Text(
                          'Startseite',
                          style: TextStyle(
                            fontSize: 18,
                            color: getTextColor(),
                          ),
                        ),
                        iconColor: blue,
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
                        ),
                        iconColor: getTextColor(),
                        title: Text(
                          'Hilfe',
                          style: TextStyle(
                            fontSize: 18,
                            color: getTextColor(),
                          ),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InstructionsScreen()),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          isNightMode
                              ? Icons.dark_mode_outlined
                              : Icons.light_mode_outlined,
                          size: 28,
                        ),
                        iconColor: iconColor(),
                        title: Text(
                          isNightMode ? 'Dunkler Modus' : 'Heller Modus',
                          style: TextStyle(
                            fontSize: 18,
                            color: getTextColor(),
                          ),
                        ),
                        onTap: () => setState(() {
                          toggleNightMode();
                        }),
                      ),
                      const Spacer(),
                      ListTile(
                        leading: const Icon(
                          Icons.logout,
                          size: 28,
                        ),
                        title: Text(
                          'Ausloggen',
                          style: TextStyle(fontSize: 18, color: textColor),
                        ),
                        iconColor: red,
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
          },
        ),
      ),
    );
  }
}
