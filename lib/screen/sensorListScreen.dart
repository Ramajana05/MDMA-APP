import 'package:flutter/material.dart';
import 'package:forestapp/widget/sidePanelWidget.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'package:forestapp/Model/sensorListItem.dart';

import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:forestapp/widget/mapObjects.dart';

import 'package:flutter/material.dart';
import 'package:forestapp/widget/damage.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'package:forestapp/service/loginService.dart';

class SensorListScreen extends StatefulWidget {
  const SensorListScreen({Key? key}) : super(key: key);

  @override
  State<SensorListScreen> createState() => _SensorListScreenState();
}

class _SensorListScreenState extends State<SensorListScreen> {
  List<Damage> damagesList = [];

  @override
  void initState() {
    super.initState();
    _loadDamagesData(); // Load damages data from the database
  }

  void _loadDamagesData() async {
    LoginService loginService = LoginService();
    final fetchedSensors = await loginService.fetchSensorsFromDatabase();

    setState(() {
      damagesList = fetchedSensors;
    });
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
            Expanded(
              child: ListView.builder(
                itemCount: damagesList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 7.0),
                    child: SensorListItemWidget(
                      sensorTitle: damagesList[index].sensorName,
                      latitude: damagesList[index].latitude,
                      longitude: damagesList[index].longitude,
                      status: damagesList[index].status,
                      createDate: damagesList[index].createDate,
                      signalStrength: damagesList[index].signalStrength,
                      chargerInfo: damagesList[index].chargerInfo,
                      alignLeft: true,
                      temperature: damagesList[index].temperatur,
                      airPressure: damagesList[index].airPressure,
                    ),
                  );
                },
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
