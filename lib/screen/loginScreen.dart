import 'package:flutter/material.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'dashboardScreen.dart';
import 'package:forestapp/widget/bottomNavBar.dart';
import 'package:forestapp/widget/topNavBarBasic.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.onLoginSuccess}) : super(key: key);

  final VoidCallback onLoginSuccess;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBarBasic(
        title: 'Login',
      ),
      body: Center(
        child: Container(
          height: 290,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Color.fromARGB(255, 165, 245, 198),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16.0, // Set the font size to 16
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value?.trim(),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value?.trim(),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      // Replace this with authentication logic
                      // just validating the email and password rn
                      if (_email == 'user@example.com' &&
                          _password == 'password') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomTabBar()),
                        ).then((value) => onLoginSuccess(context));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Invalid email or password')),
                        );
                      }
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 243, 243, 243),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 95, 230, 151),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  onLoginSuccess(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }
}
