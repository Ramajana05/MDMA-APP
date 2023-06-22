import 'package:flutter/material.dart';
import 'package:forestapp/colors/appColors.dart';
import 'package:forestapp/widget/topNavBarBasic.dart';
import 'package:forestapp/Model/helpListItem.dart';

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
    'Sensorliste',
    'Menu',
    'Profil',
    'Website',
    'Hilfe',
    'Ausloggen',
    'Neu Laden',
  ];

  final Map<String, String> instructionDescriptions = {
    'Dashboard':
        'Das Dashboard bietet eine umfassende Übersicht über Besucherzahlen, verfügbare Sensoren, Temperatur und Luftfeuchtigkeit. Zeigt Statistiken, Sensoren, Neuigkeiten, Warnungen und präzise Wettervorhersagen.',
    'Statistik':
        'Präsentiert detaillierte Daten zu Besucherzahlen, Temperatur und Luftfeuchtigkeit. Enthält separate Statistiken für den aktuellen Tag (stündliche Werte), den laufenden Monat (tägliche Werte) und den aktuellen Monat (wöchentliche Werte).',
    'Karte':
        'Stellt Standorte und Sensoren übersichtlich dar. Standorte werden entsprechend ihrer Bevölkerungsdichte farblich markiert. Sensoren haben unterschiedliche Farben je nach Akkustand.',
    'QR Scanner':
        'Einfaches Hinzufügen neuer Sensoren durch Scannen des QR-Codes. Nahtlose Integration in das System. Vereinfacht die Einrichtung und ermöglicht effiziente Verwaltung.',
    'Sensorliste':
        'Umfassende Übersicht aller registrierten Sensoren. Abruf detaillierter Informationen zu Standort, Akkustand und relevanten Daten. Vereinfacht das Monitoring und die Verwaltung der Sensorinfrastruktur.',
    'Menü':
        'Breite Auswahl an Optionen und Einstellungen zur optimalen Anpassung der Anwendung. Festlegen von Benutzerpräferenzen, Anpassung der Benachrichtigungseinstellungen und weitere individuelle Anpassungen.',
    'Profil':
        'Zugriff auf persönliche Daten zur Anzeige und Bearbeitung. Verwalten des Profilbilds, Ändern des Benutzernamens und Aktualisieren der Kontaktdaten, um das Profil auf dem neuesten Stand zu halten.',
    'Website':
        'Bietet zusätzliche Informationen und wertvolle Ressourcen zur Erweiterung des Verständnisses und der Nutzung der Anwendung. Enthält hilfreiche Anleitungen, FAQs, technische Dokumentationen und mehr.',
    'Hilfe':
        'Unterstützung und Hilfestellung bei der Nutzung der Anwendung. Finden von Antworten auf häufig gestellte Fragen, Kontaktieren des Supports und Durchsuchen der Wissensdatenbank für schnelle Lösungen.',
    'Ausloggen':
        'Sicher und bequem vom Konto abmelden. Daten bleiben geschützt. Möglichkeit zur erneuten Anmeldung, um auf personalisierte Einstellungen und Daten zuzugreifen.',
    'Neu Laden':
        'Aktuelle Ansicht und damit verbundene Daten schnell und einfach aktualisieren. Erhalten von stets aktuellen Informationen für präzise und zeitnahe Datenanalyse.'
  };

  final Map<String, IconData> instructionIcons = {
    'Dashboard': Icons.dashboard,
    'Statistik': Icons.bar_chart_outlined,
    'Karte': Icons.pin_drop,
    'QR Scanner': Icons.qr_code_scanner,
    'Sensorliste': Icons.sensors,
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
        child: Container(
          color: background,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Anleitung',
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: textColor),
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
                      instruction == 'Sensorliste' ||
                      instruction == 'Menu' ||
                      instruction == 'Profil' ||
                      instruction == 'Website' ||
                      instruction == 'Hilfe' ||
                      instruction == 'Ausloggen' ||
                      instruction == 'Neu Laden') {
                    final IconData icon =
                        instructionIcons[instruction] ?? Icons.help;
                    final Color iconColor =
                        colorsList[index % colorsList.length];
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
                        style: TextStyle(fontSize: 16.0, color: textColor),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
