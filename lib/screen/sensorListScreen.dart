import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:forestapp/widget/sidePanelWidget.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'package:forestapp/widget/overviewWidget.dart';
import 'package:forestapp/Model/sensorListItem.dart';

import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:forestapp/widget/mapObjects.dart';

import 'package:flutter/material.dart';
import 'package:forestapp/widget/damage.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'DamageReport.dart';

//import 'your_database_connection.dart'; // Import your database connection file

class SensorListScreen extends StatefulWidget {
  const SensorListScreen({Key? key}) : super(key: key);

  @override
  State<SensorListScreen> createState() => _SensorListScreenState();
}

class _SensorListScreenState extends State<SensorListScreen> {
  List<Damage> damagesList = [
    Damage(
      sensorName: "Sensor 1",
      latitude: 49.11,
      longitude: 9.27,
      status: "Offline",
      createDate: "13-05-2023",
      signalStrength: "Schwach",
      chargerInfo: "77",
      temperatur: 18.5,
      airPressure: 1020,
    ),
    Damage(
      sensorName: "Sensor 2",
      latitude: 49.12,
      longitude: 9.33,
      status: "Online",
      createDate: "11-01-2022",
      signalStrength: "Hoch",
      chargerInfo: "20",
      temperatur: 16.7,
      airPressure: 1000,
    ),
    Damage(
      sensorName: "Sensor 3",
      latitude: 49.09,
      longitude: 9.22,
      status: "Online",
      createDate: "21-02-2022",
      signalStrength: "Mittel",
      chargerInfo: "4",
      temperatur: 15,
      airPressure: 988,
    ),
    Damage(
      sensorName: "Sensor 4",
      latitude: 49.09,
      longitude: 9.21,
      status: "Offline",
      createDate: "04-04-2022",
      signalStrength: "Niedrig",
      chargerInfo: "77",
      temperatur: 17,
      airPressure: 1026,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadDamagesData(); // Load damages data from the database
  }

  void _loadDamagesData() async {
    // Fetch damages data from the database
    //damagesList = await YourDatabaseConnection.fetchDamages();
    setState(() {}); // Update the UI with the loaded data
  }

  void _showDamageDetails(Damage damage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(damage.sensorName),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Location: ${damage.latitude} ${damage.longitude}'),
              SizedBox(height: 8),
              Text('Status: ${damage.status}'),
              SizedBox(height: 8),
              Text('Signal Strength: ${damage.signalStrength}'),
              SizedBox(height: 8),
              Text('Create Date: ${damage.createDate}'),
              SizedBox(height: 8),
              Text('Charger Information: ${damage.chargerInfo}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: SidePanel(),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: TopNavBar(
        title: 'SENSOREN',
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: DefaultTabController(
        length: 1,
        child: Column(
          children: [
            OverviewContainer(text: "Sensorliste Übersicht"),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: damagesList.length,
                    itemBuilder: (context, index) {
                      return SensorListItemWidget(
                        damageTitle: damagesList[index].sensorName,
                        latitude: damagesList[index].latitude,
                        longitude: damagesList[index].longitude,
                        status: damagesList[index].status,
                        createDate: damagesList[index].createDate,
                        signalStrength: damagesList[index].signalStrength,
                        chargerInfo: damagesList[index].chargerInfo,
                        alignLeft: true,
                        temperatur: damagesList[index].temperatur,
                        airPressure: damagesList[index].airPressure,
                      );
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

class Damage {
  final String sensorName;
  final double latitude;
  final double longitude;
  final String status;
  final String createDate;
  final String signalStrength;
  final String chargerInfo;
  final double temperatur;
  final int airPressure;

  Damage({
    required this.sensorName,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.createDate,
    required this.signalStrength,
    required this.chargerInfo,
    required this.temperatur,
    required this.airPressure,
  });
}
