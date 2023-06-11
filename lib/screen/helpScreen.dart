import 'package:flutter/material.dart';
import 'package:forestapp/widget/topNavBarBasic.dart';

class InstructionsScreen extends StatelessWidget {
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.graphic_eq),
                SizedBox(width: 8.0),
                Text(
                  'Statistik',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.dashboard_outlined),
                SizedBox(width: 8.0),
                Text(
                  'Karte',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Hier sehen Sie alle Daten ein.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 32.0),
            Text(
              'Willkommen zur Anleitung und den ersten Schritten!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Schritt 1: Registrierung',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Um die App vollständig nutzen zu können, registrieren Sie sich bitte mit Ihren persönlichen Informationen.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Schritt 2: Daten eingeben',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Geben Sie Ihre relevanten Daten ein, wie z.B. Name, Adresse und Kontaktinformationen. Diese Daten werden für die weitere Verwendung der App benötigt.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Schritt 3: Funktionen erkunden',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Entdecken Sie die vielfältigen Funktionen der App, wie z.B. das Abrufen von Informationen, das Hinzufügen von Einträgen und das Verwalten Ihres Profils.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Bei Fragen Hilfe suchen',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Wenn Sie Fragen haben oder Unterstützung benötigen, zögern Sie nicht, unseren Kundenservice zu kontaktieren. Wir helfen Ihnen gerne weiter!',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
