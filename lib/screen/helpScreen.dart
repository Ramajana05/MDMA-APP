import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:forestapp/colors/appColors.dart';
import 'package:forestapp/widget/topNavBarBasic.dart';
import 'package:forestapp/Model/helpListItem.dart';

class InstructionsScreen extends StatefulWidget {
  @override
  _InstructionsScreenState createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
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
                'Hauptfunktionen',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
              ),
            ),
            BuildDashboard(),
            BuildStatistik(),
            BuildKarte(),
            BuildScanner(),
            BuildSensorListe(),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Nebenfunktionen',
                style: TextStyle(
                    fontSize: 26.0, fontWeight: FontWeight.bold, color: black),
              ),
            ),
            BuildProfile(),
            BuildWebsite(),
            BuildHelp(),
            BuildNightMode(),
            BuildRefresh(), // Add more individual build methods for other sections
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
      iconColor: blue, // Adjust the icon color
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
      iconColor: grey, // Adjust the icon color
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