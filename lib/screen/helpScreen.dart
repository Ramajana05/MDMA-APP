import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:forestapp/colors/appColors.dart';
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

class BuildDashboard extends StatefulWidget {
  @override
  _BuildDashboardState createState() => _BuildDashboardState();
}

class _BuildDashboardState extends State<BuildDashboard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return HelpListItemWidget(
      title: 'Dashboard',
      expanded: expanded,
      onTap: () {
        setState(() {
          expanded = !expanded; // Ändere den Zustand von expanded beim Antippen
        });
      },
      alignLeft: true,
      description:
          'Das Dashboard bietet eine Übersicht über die wichtigsten Bestandteile dieser App.',
      section: 'Vier Kreis Statistiken',
      icon: Icons.dashboard_outlined,
      iconColor: primaryAppLightGreen,
    );
  }
}

class BuildStatistik extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HelpListItemWidget(
      title: 'Statistik',
      expanded: false,
      onTap: () {
        // Handle onTap event
      },
      alignLeft: false,
      description:
          'Die Statistik präsentiert detaillierte Daten zu Besucherzahlen, Temperatur und Luftfeuchtigkeit. Hier finden Sie separate Statistiken für den aktuellen Tag mit stündlichen Werten, den laufenden Monat mit täglichen Werten und den aktuellen Monat mit wöchentlichen Werten. Diese Informationen helfen Ihnen dabei, wichtige Trends und Muster zu erkennen.',
      section: '',
      icon: Icons.line_axis_outlined,
      iconColor: primaryAppLightGreen,
    );
  }
}

class BuildKarte extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HelpListItemWidget(
      title: 'Karte',
      expanded: false, // Adjust the initial expanded state
      onTap: () {
        // Handle onTap event
      },
      alignLeft: true, // Adjust alignment as needed
      description:
          'Die interaktive Karte stellt Ihnen übersichtlich die eingetragenen Standorte und Sensoren dar. Die Standorte werden entsprechend ihrer Bevölkerungsdichte farblich markiert, während die Sensoren je nach Akkustand unterschiedliche Farben aufweisen. Diese visuelle Darstellung ermöglicht Ihnen eine schnelle und intuitive Einschätzung des Gesamtsystems.',
      section: 'Kreis Statistiken',
      icon: Icons.pin_drop_outlined,
      iconColor: primaryAppLightGreen, // Adjust the icon color
    );
  }
}

class BuildScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HelpListItemWidget(
      title: 'QR Scanner',
      expanded: false, // Adjust the initial expanded state
      onTap: () {
        // Handle onTap event
      },
      alignLeft: true, // Adjust alignment as needed
      description:
          'Der Scanner-Bildschirm ermöglicht das Scannen von QR-Codes, um Sensoren anzulegen. Man kann dem Sensor einen Namen geben. Der Standort wird automatisch erfasst. In der Sensorliste kannst du die aktuellen Sensordaten überwachen und auf der Karte den Standort sehen.',
      section: '',
      icon: Icons.qr_code,
      iconColor: primaryAppLightGreen, // Adjust the icon color
    );
  }
}

class BuildSensorListe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HelpListItemWidget(
      title: 'Sensor Liste',
      expanded: false, // Adjust the initial expanded state
      onTap: () {
        // Handle onTap event
      },
      alignLeft: true, // Adjust alignment as needed
      description:
          'Die Sensorliste bietet einen Überblick über wichtige aktuelle Sensordaten und ermöglicht es, nach dem Namen zu filtern. Dabei werden relevante Informationen zu den Sensoren angezeigt, wie z.B. Name, Standort, Status, Signalstärke, Akku Informationen, Temperatur und Luftdruck. Durch den Filter nach Namen kann gezielt nach bestimmten Sensoren gesucht werden, um schnell die gewünschten Informationen zu finden.',
      section: 'Kreis Statistiken',
      icon: Icons.sensors,
      iconColor: primaryAppLightGreen, // Adjust the icon color
    );
  }
}

class BuildProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HelpListItemWidget(
      title: 'Profil',
      expanded: false, // Adjust the initial expanded state
      onTap: () {
        // Handle onTap event
      },
      alignLeft: true, // Adjust alignment as needed
      description:
          'Das Profil enthält einen Einblick auf den Benutzernamen, die Rolle die man besitzt und den aktuellen Standort. Zudem kann man das Passwort ändern. Es dient dazu, persönliche Informationen und Einstellungen des Benutzers zu verwalten und anzupassen.',
      section: 'Kreis Statistiken',
      icon: Icons.person,
      iconColor: primaryAppLightGreen, // Adjust the icon color
    );
  }
}

class BuildWebsite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HelpListItemWidget(
      title: 'Startseite',
      expanded: false, // Adjust the initial expanded state
      onTap: () {
        // Handle onTap event
      },
      alignLeft: true, // Adjust alignment as needed
      description: 'Hier ist die Website verlinkt.',
      section: 'Kreis Statistiken',
      icon: Icons.public,
      iconColor: primaryHumidityColor, // Adjust the icon color
    );
  }
}

class BuildHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HelpListItemWidget(
      title: 'Hilfe',
      expanded: false, // Adjust the initial expanded state
      onTap: () {
        // Handle onTap event
      },
      alignLeft: true, // Adjust alignment as needed
      description:
          'Auf der Hilfeseite findet man eine Liste aller Funktionen dieser App. Jeder Hilfebeitrag enthält eine kurze Beschreibung der Features.',
      section: 'Kreis Statistiken',
      icon: Icons.help_outline_outlined,
      iconColor: primarygrey, // Adjust the icon color
    );
  }
}

class BuildLogOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HelpListItemWidget(
      title: 'Profil',
      expanded: false, // Adjust the initial expanded state
      onTap: () {
        // Handle onTap event
      },
      alignLeft: true, // Adjust alignment as needed
      description:
          'Die interaktive Karte stellt Ihnen übersichtlich die eingetragenen Standorte und Sensoren dar. Die Standorte werden entsprechend ihrer Bevölkerungsdichte farblich markiert, während die Sensoren je nach Akkustand unterschiedliche Farben aufweisen. Diese visuelle Darstellung ermöglicht Ihnen eine schnelle und intuitive Einschätzung des Gesamtsystems.',
      section: 'Kreis Statistiken',
      icon: Icons.person,
      iconColor: primaryAppLightGreen, // Adjust the icon color
    );
  }
}

class BuildNightMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HelpListItemWidget(
      title: 'Nacht Modus',
      expanded: false, // Adjust the initial expanded state
      onTap: () {
        // Handle onTap event
      },
      alignLeft: true, // Adjust alignment as needed
      description:
          'Im Nachtmodus wird das Farbschema des Bildschirms angepasst, um das Lesen und die Sichtbarkeit zu verbessern.',
      section: 'Kreis Statistiken',
      icon: Icons.dark_mode_outlined,
      iconColor: Colors.black, // Adjust the icon color
    );
  }
}

class BuildRefresh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HelpListItemWidget(
      title: 'Neu Laden',
      expanded: false, // Adjust the initial expanded state
      onTap: () {
        // Handle onTap event
      },
      alignLeft: true, // Adjust alignment as needed
      description:
          'Die interaktive Karte stellt Ihnen übersichtlich die eingetragenen Standorte und Sensoren dar. Die Standorte werden entsprechend ihrer Bevölkerungsdichte farblich markiert, während die Sensoren je nach Akkustand unterschiedliche Farben aufweisen. Diese visuelle Darstellung ermöglicht Ihnen eine schnelle und intuitive Einschätzung des Gesamtsystems.',
      section: 'Kreis Statistiken',
      icon: Icons.refresh,
      iconColor: primaryAppLightGreen, // Adjust the icon color
    );
  }
}

// Add more individual build methods for other sections