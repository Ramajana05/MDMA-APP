import 'package:flutter/material.dart';
import 'package:forestapp/widget/sidePanelWidget.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'package:forestapp/widget/overviewWidget.dart';
import 'package:forestapp/widget/tabBarWidget.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:forestapp/widget/mapObjects.dart';

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
    DamagesListItemWidget(
        "Sensor 1", "Long und Lat", "Luftdruck", "Stand 09-05-2023"),
    DamagesListItemWidget(
        "Sensor 2", "Long und Lat", "Temperatur", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Sensor 3", "Long und Lat", "Temperatur", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Sensor 4", "Beim Grillplatz", "Luftdruck", "Stand 01-10-2023"),
    DamagesListItemWidget(
        "Standort 1", "Beim Grillplatz", "", "Stand 01-10-2023")
  ];

  //method to navigate to damagereport
  get onPressed => null;

  //final Completer<GoogleMapController> _controller = Completer(); // Added

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: SidePanel(),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: TopNavBar(
        title: 'ÜBERSICHT',
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            OverviewContainer(text: "Sensoren und Standorte"),
            TabBar(
              labelColor: const Color.fromARGB(
                  255, 40, 233, 127), // Selected tab font color
              unselectedLabelColor: Colors.grey, // Unselected tab font color
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color.fromARGB(
                        255, 40, 233, 127), // Underline color
                    width: 2.0, // Underline thickness
                  ),
                ),
              ),
              labelStyle: TextStyle(
                fontSize: 16, // Font size of selected tab
                fontWeight: FontWeight.bold, // Font weight of selected tab
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16, // Font size of unselected tab
              ),
              tabs: [
                Tab(text: 'Alle'),
                Tab(text: 'Standorte'),
                Tab(text: 'Sensoren'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Tab Views
                  ListView.builder(
                    itemCount: damagesList.length,
                    itemBuilder: (context, index) {
                      return damagesList[index];
                    },
                  ),
                  ListView.builder(
                    itemCount: damagesList.length,
                    itemBuilder: (context, index) {
                      return damagesList[index];
                    },
                  ),
                  ListView.builder(
                    itemCount: damagesList.length,
                    itemBuilder: (context, index) {
                      return damagesList[index];
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
