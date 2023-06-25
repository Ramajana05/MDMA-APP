import 'package:flutter/material.dart';
import 'package:forestapp/service/loginService.dart';
import 'package:url_launcher/url_launcher.dart';

import '../colors/appColors.dart';
import '../dialog/logoutDialog.dart';
import '../screen/profileScreen.dart';
import 'package:provider/provider.dart';
import 'package:forestapp/provider/userProvider.dart';
import 'package:forestapp/screen/helpScreen.dart';
import 'package:forestapp/colors/appColors.dart';

import 'package:forestapp/widget/bottomnavbar.dart';

class SidePanel extends StatefulWidget {
  final VoidCallback? onDarkModeChanged;

  const SidePanel({Key? key, this.onDarkModeChanged}) : super(key: key);

  @override
  State<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends State<SidePanel> {
  Future<String?> _getLoggedInUsername(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final loggedInUsername = userProvider.loggedInUsername;

    return loggedInUsername ?? '';
  }

  ValueNotifier<bool> _isDarkModeNotifier = ValueNotifier<bool>(false);
  int currentIndex = 0; // Store the current index

  @override
  void initState() {
    super.initState();
    checkDarkMode();
  }

  @override
  void dispose() {
    _isDarkModeNotifier.dispose();
    super.dispose();
  }

  void checkDarkMode() async {
    LoginService loginService = LoginService();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final loggedInUsername = userProvider.loggedInUsername;
    final darkModeValue =
        await loginService.fetchDarkModeValue(loggedInUsername!);

    _isDarkModeNotifier.value = darkModeValue;
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
                        title: Text(
                          'Profil',
                          style: TextStyle(
                            fontSize: 18,
                            color: black,
                          ),
                        ),
                        iconColor: primaryAppLightGreen,
                        onTap: () {
                          // Save the current index
                          currentIndex = 0;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(),
                            ),
                          );
                        },
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
                            color: black,
                          ),
                        ),
                        iconColor: blue,
                        onTap: () async {
                          const url = 'https://mdma.haveachin.de/';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Die Website $url konnte nicht geladen werden.';
                          }

                          updateAppColors(_isDarkModeNotifier.value);
                        },
                      ),
                      ListTile(
                        leading: ValueListenableBuilder<bool>(
                          valueListenable: _isDarkModeNotifier,
                          builder: (BuildContext context, bool value,
                              Widget? child) {
                            return Icon(
                              value
                                  ? Icons.dark_mode_outlined
                                  : Icons.wb_sunny_outlined,
                              size: 28,
                              color: value ? moonColor : yellow,
                            );
                          },
                        ),
                        title: Text(
                          _isDarkModeNotifier.value
                              ? 'Dunkler Modus'
                              : 'Heller Modus',
                          style: TextStyle(fontSize: 18, color: black),
                        ),
                        onTap: () async {
                          final loggedInUsername =
                              await _getLoggedInUsername(context);
                          final loginService = LoginService();

                          if (_isDarkModeNotifier.value) {
                            await loginService.updateDarkModeStatus(
                                loggedInUsername!, true);
                          } else {
                            await loginService.updateDarkModeStatus(
                                loggedInUsername!, false);
                          }

                          _isDarkModeNotifier.value =
                              !_isDarkModeNotifier.value;

                          widget.onDarkModeChanged
                              ?.call(); // Notify parent widget about dark mode change

                          updateAppColors(_isDarkModeNotifier.value);

                          // Save the current index
                          currentIndex = 2;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomBottomTabBar(
                                trans_index: 0,
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.help_outline_outlined,
                          size: 28,
                        ),
                        iconColor: grey,
                        title: Text(
                          'Hilfe',
                          style: TextStyle(
                            fontSize: 18,
                            color: black,
                          ),
                        ),
                        onTap: () {
                          // Save the current index
                          currentIndex = 3;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InstructionsScreen(),
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      ListTile(
                        leading: const Icon(
                          Icons.logout,
                          size: 28,
                        ),
                        title: Text(
                          'Ausloggen',
                          style: TextStyle(fontSize: 18, color: black),
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
