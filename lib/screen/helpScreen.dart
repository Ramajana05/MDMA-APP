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
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Hauptfunktionen',
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: textColor),
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
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
              ),
              BuildProfile(),
              BuildWebsite(),
              BuildHelp(),
              BuildNightMode(),
              BuildDayMode(),
              BuildRefresh(), // Add more individual build methods for other sections
            ],
          ),
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
          'Das Dashboard bietet eine Übersicht über wichtige App-Funktionen und Informationen.',
      section: 'Vier Kreis Statistiken',
      icon: Icons.dashboard_outlined,
      iconColor: darkGreen,
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
          'Unsere Statistik bietet detaillierte Daten zu Besucherzahlen, Temperatur und Luftfeuchtigkeit. Sie können stündliche Werte für den aktuellen Tag, tägliche Werte für den laufenden Monat und wöchentliche Werte für den vorherigen Monat einsehen. Diese Informationen ermöglichen Ihnen fundierte Analysen und helfen Ihnen, Trends und Muster zu erkennen.',
      section: '',
      icon: Icons.line_axis_outlined,
      iconColor: blue,
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
          'Unsere interaktive Karte zeigt Ihnen übersichtlich Standorte und Sensoren. Standorte werden nach ihrer Bevölkerungsdichte farblich gekennzeichnet, während Sensoren je nach Akkustand unterschiedliche Farben haben. Diese visuelle Darstellung ermöglicht Ihnen eine schnelle und intuitive Bewertung des Gesamtsystems.',
      section: 'Kreis Statistiken',
      icon: Icons.pin_drop_outlined,
      iconColor: red, // Adjust the icon color
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
          'Der Scanner-Bildschirm ermöglicht das einfache Anlegen von Sensoren durch das Scannen von QR-Codes. Geben Sie einen Namen für den Sensor ein, und der Standort wird automatisch erfasst. Die neu erstellten Sensoren werden auf der Karte und in der Sensorenliste angezeigt.',
      section: '',
      icon: Icons.qr_code,
      iconColor: blue, // Adjust the icon color
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
          'Die Sensorliste bietet einen übersichtlichen Überblick über wichtige Sensordaten und ermöglicht Ihnen die Suche nach spezifischen Sensoren. Sie können relevante Informationen wie den Namen, Standort, Status, Signalstärke, Akkuinformationen, Temperatur und Luftfeuchtigkeit einsehen. Durch gezieltes Suchen finden Sie schnell die gewünschten Informationen zu den Sensoren.',
      section: 'Kreis Statistiken',
      icon: Icons.sensors,
      iconColor: darkGreen, // Adjust the icon color
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
          'Das Profil bietet einen Überblick über den Benutzernamen, die zugewiesene Rolle und den aktuellen Standort. Sie haben auch die Möglichkeit, Ihr Passwort zu ändern. Das Profil dient der Verwaltung und Anpassung persönlicher Informationen und Einstellungen.',
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
      description:
          'Unsere App ist nicht nur als mobile Anwendung verfügbar, sondern auch als Website mit erweiterten Funktionen. Diese Website ist auch für die Besucher des Waldes zugänglich.',
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
          'Auf unserer Hilfeseite finden Sie eine umfassende Liste aller Funktionen, die unsere App bietet. Jeder Hilfebeitrag enthält eine kurze Beschreibung der jeweiligen Funktionen.',
      section: 'Kreis Statistiken',
      icon: Icons.help_outline_outlined,
      iconColor: buttonTextColor, // Adjust the icon color
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
          'Unsere interaktive Karte bietet Ihnen eine übersichtliche Darstellung der registrierten Standorte und Sensoren. Dabei werden die Standorte basierend auf ihrer Bevölkerungsdichte farblich gekennzeichnet, während die Sensoren verschiedene Farben entsprechend ihres Akkustands anzeigen. Diese visuelle Darstellung ermöglicht Ihnen eine schnelle und intuitive Einschätzung des Gesamtsystems.',
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
          'Im Nachtmodus passt sich das Farbschema des Bildschirms an, um das Lesen und die Sichtbarkeit zu verbessern. Durch die Anpassung der Farben wird eine angenehmere und augenschonendere Darstellung während der Nachtzeit erreicht.',
      section: 'Kreis Statistiken',
      icon: Icons.dark_mode_outlined,
      iconColor: moonColor, // Adjust the icon color
    );
  }
}

class BuildDayMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HelpListItemWidget(
      title: 'Heller Modus',
      expanded: false, // Adjust the initial expanded state
      onTap: () {
        // Handle onTap event
      },
      alignLeft: true, // Adjust alignment as needed
      description:
          'Im hellen Modus bleibt das Farbschema des Bildschirms in einer standardmäßigen hellen Darstellung. Dieser Modus eignet sich gut für den Gebrauch tagsüber und sorgt für eine klare und gut sichtbare Benutzeroberfläche.',
      section: 'Kreis Statistiken',
      icon: Icons.wb_sunny_outlined,
      iconColor: yellow, // Adjust the icon color
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
          'Holen Sie sich aktuelle Informationen mit einem Klick. Die Funktion "Neu Laden" ermöglicht es Ihnen, den Seiteninhalt schnell und einfach zu aktualisieren, ohne die Seite zu verlassen. Bleiben Sie immer auf dem neuesten Stand und erhalten Sie aktuelle Informationen mit Leichtigkeit.',
      section: 'Kreis Statistiken',
      icon: Icons.refresh,
      iconColor: primaryAppLightGreen, // Adjust the icon color
    );
  }
}

// Add more individual build methods for other sections