import 'package:flutter/material.dart';
import 'package:forestapp/widget/topNavBarBasic.dart';
import 'package:forestapp/Model/helpListItem.dart';
import 'dart:math';

class InstructionsScreen extends StatefulWidget {
  @override
  _InstructionsScreenState createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  final List<String> instructionsList = [
    'Dashboard',
    'Statistik',
    'Karte',
    'QR Scanner',
    'Sensoren Liste',
    'Menu',
    'Profil',
    'Website',
    'Hilfe',
    'Ausloggen',
    'Neu Laden',
  ];

  final Map<String, String> instructionDescriptions = {
    'Dashboard': 'This is the description for Dashboard',
    'Statistik': 'This is the description for Statistik',
    'Karte': 'This is the description for Karte',
    'QR Scanner': 'This is the description for QR Code Scanner',
    'Sensoren Liste': 'This is the description for QR Code Scanner',
    'Menu': 'This is the description for QR Code Scanner',
    'Profil': 'This is the description for QR Code Scanner',
    'Website': 'This is the description for QR Code Scanner',
    'Hilfe': 'This is the description for QR Code Scanner',
    'Ausloggen': 'This is the description for QR Code Scanner',
    'Neu Laden': 'This is the description for QR Code Scanner',
  };

  final Map<String, IconData> instructionIcons = {
    'Dashboard': Icons.dashboard,
    'Statistik': Icons.bar_chart_outlined,
    'Karte': Icons.pin_drop,
    'QR Scanner': Icons.qr_code_scanner,
    'Sensoren Liste': Icons.sensors,
    'Menu': Icons.menu,
    'Profil': Icons.person,
    'Website': Icons.public,
    'Hilfe': Icons.help_outline_outlined,
    'Ausloggen': Icons.logout,
    'Neu Laden': Icons.refresh,
  };

  late List<bool> expansionStates;
  late List<Color> colors;

  @override
  void initState() {
    super.initState();
    expansionStates = List<bool>.filled(instructionsList.length, false);
  }

  final List<Color> colorsList = [
    Colors.green,
    Colors.black,
    Colors.red,
    Colors.black,
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.blue,
    const Color.fromARGB(255, 127, 127, 128),
    Color.fromARGB(255, 255, 2, 2),
    const Color.fromARGB(255, 58, 243, 33),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBarBasic(
        title: 'Hilfe',
        returnStatus: true,
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Willkommen zur Anleitung',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: instructionsList.length,
              itemBuilder: (context, index) {
                final instruction = instructionsList[index];
                if (instruction == 'Dashboard' ||
                    instruction == 'Statistik' ||
                    instruction == 'Karte' ||
                    instruction == 'QR Scanner' ||
                    instruction == 'Sensoren Liste' ||
                    instruction == 'Menu' ||
                    instruction == 'Profil' ||
                    instruction == 'Website' ||
                    instruction == 'Hilfe' ||
                    instruction == 'Ausloggen' ||
                    instruction == 'Neu Laden') {
                  final IconData icon =
                      instructionIcons[instruction] ?? Icons.help;
                  final Color iconColor = colorsList[index % colorsList.length];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        expansionStates[index] = !expansionStates[index];
                      });
                    },
                    child: HelpListItemWidget(
                      title: instruction,
                      expanded: expansionStates[index],
                      onTap: () {
                        setState(() {
                          expansionStates[index] = !expansionStates[index];
                        });
                      },
                      alignLeft:
                          index % 2 == 0, // Align left for even index items
                      description: instructionDescriptions[instruction] ?? '',
                      icon: icon,
                      iconColor: iconColor, // Pass the random color
                    ),
                  );
                } else {
                  return ListTile(
                    title: Text(
                      instruction,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
