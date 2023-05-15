import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:forestapp/service/loginService.dart';
import 'package:forestapp/widget/bottomNavBar.dart';
import 'package:forestapp/widget/TopNavBarBasic.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginService _loginService = LoginService();

  late Database _database;

  final gradientColors = [
    Color.fromARGB(255, 95, 230, 151),
    Color.fromARGB(255, 165, 245, 198),
  ];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'MDMADatabase.db');

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

  Future<bool> _verifyLogin(String email, String password) async {
    final result = await _database.query(
      'User',
      where: 'Username = ? AND Password = ?',
      whereArgs: [email, password],
    );

    return result.isNotEmpty;
  }

  Future<void> _handleLogin(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      final isLoggedIn =
          await _loginService.performLogin(email, password, context);

      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomTabBar()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ungültige E-Mail oder Passwort.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBarBasic(
        title: 'Login',
        returnStatus: false,
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 375,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 158, 158, 158).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            autovalidateMode:
                AutovalidateMode.onUserInteraction, // Enable auto validation
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Benutzername',
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 40, 233, 127),
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    focusColor: Color.fromARGB(255, 40, 233, 127),
                  ),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bitte geben Sie Ihren Benutzername ein';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value?.trim(),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Passwort',
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 40, 233, 127),
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    focusColor: Color.fromARGB(255, 40, 233, 127),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bitte geben Sie ihr Passwort ein';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value?.trim(),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 255, 255, 255),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Abbrechen',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _handleLogin(context),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 255, 255, 255),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 40, 233, 127),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
