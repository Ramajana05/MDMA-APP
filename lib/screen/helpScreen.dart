import 'package:flutter/material.dart';
import 'package:forestapp/colors/appColors.dart';
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
    'Dashboard':
        'Das Dashboard bietet eine umfassende Übersicht über aktuelle Besucherzahlen, online verfügbare Sensoren sowie die genaue Temperatur und Luftfeuchtigkeit. Darüber hinaus werden auf dem Dashboard eine interaktive Karte mit den eingetragenen Standorten und Sensoren sowie aktuelle Neuigkeiten angezeigt, die auch wichtige Warnungen und eine präzise Wettervorhersage enthalten.',
    'Statistik':
        'Die Statistik präsentiert detaillierte Daten zu Besucherzahlen, Temperatur und Luftfeuchtigkeit. Hier finden Sie separate Statistiken für den aktuellen Tag mit stündlichen Werten, den laufenden Monat mit täglichen Werten und den aktuellen Monat mit wöchentlichen Werten. Diese Informationen helfen Ihnen dabei, wichtige Trends und Muster zu erkennen.',
    'Karte':
        'Die interaktive Karte stellt Ihnen übersichtlich die eingetragenen Standorte und Sensoren dar. Die Standorte werden entsprechend ihrer Bevölkerungsdichte farblich markiert, während die Sensoren je nach Akkustand unterschiedliche Farben aufweisen. Diese visuelle Darstellung ermöglicht Ihnen eine schnelle und intuitive Einschätzung des Gesamtsystems.',
    'QR Scanner':
        'Mit dem praktischen QR-Code-Scanner können Sie ganz einfach neue Sensoren hinzufügen. Scannen Sie den QR-Code des Sensors und integrieren Sie ihn nahtlos in Ihr System. Dies vereinfacht die Einrichtung und ermöglicht eine effiziente Verwaltung.',
    'Sensoren Liste':
        'Die Sensorenliste liefert Ihnen eine umfassende Übersicht über alle registrierten Sensoren. Hier können Sie detaillierte Informationen zu jedem Sensor abrufen, einschließlich Standort, Akkustand und anderen relevanten Daten. Diese Liste erleichtert Ihnen das Monitoring und die Verwaltung Ihrer gesamten Sensorinfrastruktur.',
    'Menu':
        'Im Menü finden Sie eine breite Auswahl an Optionen und Einstellungen, um die Anwendung optimal anzupassen. Sie haben die Möglichkeit, Benutzerpräferenzen festzulegen, Benachrichtigungseinstellungen anzupassen und weitere individuelle Anpassungen vorzunehmen. Das Menü ist Ihr zentraler Ausgangspunkt für eine personalisierte Nutzung der Anwendung.',
    'Profil':
        'Im Profilbereich haben Sie Zugriff auf Ihre persönlichen Daten und können diese bequem anzeigen und bearbeiten. Verwalten Sie Ihr Profilbild, ändern Sie Ihren Benutzernamen oder aktualisieren Sie Ihre Kontaktdaten, um sicherzustellen, dass Ihr Profil immer auf dem neuesten Stand ist.',
    'Website':
        'Die Website bietet Ihnen zusätzliche Informationen und wertvolle Ressourcen, um Ihr Verständnis und Ihre Nutzung der Anwendung zu erweitern. Hier finden Sie hilfreiche Anleitungen, FAQs, technische Dokumentationen und vieles mehr, um das Beste aus der Anwendung herauszuholen.',
    'Hilfe':
        'Wenn Sie Unterstützung oder Hilfestellung bei der Nutzung der Anwendung benötigen, sind Sie hier genau richtig. Finden Sie Antworten auf häufig gestellte Fragen, kontaktieren Sie unseren Support oder durchsuchen Sie unsere umfangreiche Wissensdatenbank, um schnell Lösungen für Ihre Anliegen zu finden.',
    'Ausloggen':
        'Mit dieser Option können Sie sich sicher und bequem aus Ihrem Account abmelden. Ihre Daten bleiben geschützt, und Sie können sich jederzeit wieder anmelden, um auf Ihre personalisierten Einstellungen und Daten zuzugreifen.',
    'Neu Laden':
        'Durch Auswahl dieser Option haben Sie die Möglichkeit, die aktuelle Ansicht und die damit verbundenen Daten schnell und einfach zu aktualisieren. Dadurch erhalten Sie stets die aktuellsten Informationen und gewährleisten eine präzise und zeitnahe Analyse Ihrer Daten.',
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
    grey,
    red,
    green
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
                'Anleitung',
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
