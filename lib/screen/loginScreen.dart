import 'package:flutter/material.dart';
import 'package:forestapp/colors/appColors.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:forestapp/service/loginService.dart';
import 'package:forestapp/widget/bottomNavBar.dart';
import 'package:forestapp/dialog/problemsDialog.dart';
import 'package:forestapp/provider/userProvider.dart';
import 'package:provider/provider.dart';

import '../colors/appColors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _username;
  String? _password;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginService _loginService = LoginService();
  String loggedInUsername = "";
  bool _obscurePassword = true;

  late Database _database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'MDMA.db');

    // Open the database
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create the 'User' table if it doesn't exist
        await db.execute(
          'CREATE TABLE IF NOT EXISTS User (id INTEGER PRIMARY KEY, Username TEXT, Password TEXT)',
        );
      },
    );
  }

  @override
  void dispose() {
    _database.close(); // Close the database connection
    super.dispose();
  }

  Future<bool> _verifyLogin(String username, String password) async {
    final result = await _database.query(
      'User',
      where: 'Username = ? AND Password = ?',
      whereArgs: [username, password],
    );

    return result.isNotEmpty;
  }

  Future<void> _handleLogin(BuildContext context) async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {
      final isLoggedIn =
          await _loginService.performLogin(username, password, context);

      if (isLoggedIn) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setLoggedInUsername(username);
        userProvider.fetchUserDetails();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CustomBottomTabBar(trans_index: 0)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ungültiger Benutzername oder Passwort.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: background,
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width * 0.97,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: loginGrey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Center(
                          child: Text(
                            'Willkommen bei der',
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.w300,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Center(
                          child: Text(
                            'Forest App',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w400,
                              color: primaryAppLightGreen,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode
                            .onUserInteraction, // Enable auto validation
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  labelText: 'Benutzername',
                                  filled: true,
                                  fillColor: background,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                      color: buttonTextColor,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                      color: primaryAppLightGreen,
                                      width: 2.0,
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                    color: buttonTextColor,
                                  ),
                                  focusColor: primaryAppLightGreen,
                                ),
                                style:
                                    TextStyle(fontSize: 16.0, color: textColor),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bitte geben Sie Ihren Benutzername ein';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _username = value?.trim(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Passwort',
                                  filled: true,
                                  fillColor: background,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide:
                                        BorderSide(color: buttonTextColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                      color: primaryAppLightGreen,
                                      width: 2.0,
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                    color: buttonTextColor,
                                  ),
                                  focusColor: primaryAppLightGreen,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color:
                                          buttonTextColor, // Set the color of the icon
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                                style:
                                    TextStyle(fontSize: 16.0, color: textColor),
                                obscureText: _obscurePassword,
                                onChanged: (value) {
                                  setState(() {
                                    _password = value.trim();
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Bitte geben Sie ihr Passwort ein';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _password = value?.trim();
                                },
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                      },
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(
                                          EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                          buttonTextColor,
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          background,
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Abbrechen',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                            color: buttonTextColor),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => _handleLogin(context),
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(
                                          EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                          background,
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          primaryAppLightGreen,
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                            color: buttonTextInversedColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => ProblemDialog(),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 15.0),
                                child: Center(
                                  child: Text(
                                    'Probleme bei der Anmeldung',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: buttonTextColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            )));
  }
}
