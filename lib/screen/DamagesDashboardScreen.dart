import 'package:flutter/material.dart';
import 'package:forestapp/widget/damage.dart';
import 'package:forestapp/widget/topNavBar.dart';

import 'DamageReport.dart';

class DamagesDashboardScreen extends StatefulWidget {
  const DamagesDashboardScreen({Key? key}) : super(key: key);

  @override
  State<DamagesDashboardScreen> createState() => _DamagesDashboardScreen();
}

class _DamagesDashboardScreen extends State<DamagesDashboardScreen> {
  //Dummy Data
  List<Widget> damagesList = [
    DamagesListItemWidget("Baum umgefallen", "Beim Spielplatz", "abgeschlossen",
        "Stand 09-05-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "In Bearbeitung", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "In Bearbeitung", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "In Bearbeitung", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "Noch Offen", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "In Bearbeitung", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "Noch Offen", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "In Bearbeitung", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "In Bearbeitung", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "In Bearbeitung", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "Noch Offen", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "In Bearbeitung", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "In Bearbeitung", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "In Bearbeitung", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "In Bearbeitung", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "In Bearbeitung", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "In Bearbeitung", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "Noch Offen", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Vandalismus", "Beim Grillplatz", "In Bearbeitung", "Stand 01-10-2023")
  ];

  //method to navigate to damagereport
  get onPressed => null;

  //get onPressed =>Navigator.push(context,MaterialPageRoute(builder:(context)=> DamageReport())) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      appBar: TopNavBar(
        title: 'Schäden',
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: ListView(children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white60, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Schäden",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DamageReport()));
                      },
                      icon: const Icon(Icons.add),
                      color: Colors.black,
                      tooltip: "Neues Bericht")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Beschreibung",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text("Status",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: ListView.builder(
                  physics: const ScrollPhysics(parent: null),
                  shrinkWrap: true,
                  itemCount: damagesList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: damagesList[index],
                      //   onTap: () {
                      //   Navigator.push(
                      //       context, MaterialPageRoute(builder:(context)
                      //   =>
                      //       DamageReportOverview()
                      // }
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
