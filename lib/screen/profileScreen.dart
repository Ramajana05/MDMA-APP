import 'package:flutter/material.dart';
import 'package:forestapp/widget/TopNavBarBasic.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = 'MDMA';
  String _tempUsername = '';

  Color greenColor = const Color.fromARGB(255, 71, 209, 89);
  Color black = Colors.black;
  Color white = Colors.white;

  final List<String> _imageURLs = [
    'https://cdn-icons-png.flaticon.com/512/1158/1158504.png',
    'https://cdn-icons-png.flaticon.com/512/7411/7411997.png',
    'https://cdn-icons-png.flaticon.com/512/1604/1604458.png',
    'https://cdn-icons-png.flaticon.com/512/189/189494.png',
    'https://cdn-icons-png.flaticon.com/512/1464/1464856.png',
    'https://cdn-icons-png.flaticon.com/512/2108/2108337.png',
    'https://cdn-icons-png.flaticon.com/512/141/141793.png',
    'https://cdn-icons-png.flaticon.com/512/5904/5904002.png',
    'https://cdn-icons-png.flaticon.com/512/3940/3940403.png',
    'https://cdn-icons-png.flaticon.com/512/424/424782.png'
  ];
  int _selectedIndex = 0;

  final List<String> _imageNames = [
    'Igel',
    'Tiger',
    'Koala',
    'Eichhörnchen',
    'Hirsch',
    'Fuchs',
    'Hase',
    'Frosch',
    'Bär',
    'Wolf',
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: white,
      appBar: const TopNavBarBasic(
        title: 'PROFIL',
        returnStatus: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: white,
              backgroundImage: NetworkImage(_imageURLs[_selectedIndex]),
            ),
            const SizedBox(height: 20),
            Text(
              _username,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: greenColor,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Profilbild auswählen',
                      style: TextStyle(fontSize: 18),
                    ),
                    content: SizedBox(
                      height: screenHeight * 0.3,
                      child: SingleChildScrollView(
                        child: Column(
                          children: _imageURLs
                              .asMap()
                              .entries
                              .map(
                                (entry) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: white,
                                    backgroundImage: NetworkImage(entry.value),
                                  ),
                                  title: Text(_imageNames[entry.key]),
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = entry.key;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Abbrechen',
                              style: TextStyle(color: greenColor),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Speichern',
                              style: TextStyle(color: greenColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                'Profilbild ändern',
                style: TextStyle(color: black),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: greenColor,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'Benutzername ändern',
                      style: TextStyle(color: black, fontSize: 18),
                    ),
                    content: TextField(
                      onChanged: (value) {
                        setState(() {
                          _tempUsername = value; // Update temporary username
                        });
                      },
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: greenColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: greenColor, width: 2.0),
                          ),
                          labelText: 'Neuer Benutzername',
                          labelStyle:
                              TextStyle(color: greenColor, fontSize: 14),
                          helperStyle: TextStyle(color: greenColor)),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _tempUsername = _username;
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Abbrechen',
                              style: TextStyle(color: greenColor),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              String errorMessage = '';

                              if (_tempUsername.trim().isEmpty) {
                                errorMessage =
                                    'Benutzername darf nicht leer sein.';
                              } else if (_tempUsername.length < 3) {
                                errorMessage =
                                    'Benutzername muss mindestens 3 Zeichen lang sein.';
                              } else if (_tempUsername.length > 20) {
                                errorMessage =
                                    'Benutzername darf maximal 20 Zeichen lang sein.';
                              } else if (RegExp(r'[!@#$%^&*(),.?":/\{`=+}|<>]')
                                  .hasMatch(_tempUsername)) {
                                errorMessage =
                                    'Benutzername darf nur Buchstaben und Zahlen enthalten.';
                              }

                              if (errorMessage.isNotEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title:
                                        const Text('Ungültiger Benutzername'),
                                    content: Text(errorMessage),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'OK',
                                          style: TextStyle(color: greenColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // Username is valid, update the actual username
                                setState(() {
                                  _username = _tempUsername;
                                });
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(
                              'Speichern',
                              style: TextStyle(color: greenColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                'Benutzername ändern',
                style: TextStyle(color: black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
