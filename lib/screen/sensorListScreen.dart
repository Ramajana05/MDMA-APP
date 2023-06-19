import 'package:flutter/material.dart';
import 'package:forestapp/widget/sidePanelWidget.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'package:forestapp/Model/sensorListItem.dart';

import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:forestapp/widget/mapObjects.dart';

import 'package:flutter/material.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'package:forestapp/service/loginService.dart';

class SensorListScreen extends StatefulWidget {
  const SensorListScreen({Key? key}) : super(key: key);

  @override
  State<SensorListScreen> createState() => _SensorListScreenState();
}

class _SensorListScreenState extends State<SensorListScreen> {
  List<Sensor> damagesList = [];
  List<Sensor> filteredDamagesList = []; // Store the filtered list
  TextEditingController searchController = TextEditingController();

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
      filteredDamagesList = damagesList;
    });
  }

  void _filterDamages(String query) {
    List<Sensor> filteredList = [];
    if (query.isNotEmpty) {
      filteredList = damagesList.where((sensor) {
        final String sensorName = sensor.sensorName.toLowerCase();
        final String queryLower = query.toLowerCase();
        return sensorName.contains(queryLower);
      }).toList();
    } else {
      filteredList = damagesList; // Show all sensors if query is empty
    }

    setState(() {
      filteredDamagesList = filteredList;
    });
  }

  void _showDamageDetails(Sensor damage) {
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

  @override
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterDamages,
              decoration: InputDecoration(
                labelText: 'Suche',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                filled: true,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDamagesList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 7.0),
                  child: SensorListItemWidget(
                    sensorTitle: filteredDamagesList[index].sensorName,
                    latitude: filteredDamagesList[index].latitude,
                    longitude: filteredDamagesList[index].longitude,
                    status: filteredDamagesList[index].status,
                    createDate: filteredDamagesList[index].createDate,
                    signalStrength: filteredDamagesList[index].signalStrength,
                    chargerInfo: filteredDamagesList[index].chargerInfo,
                    alignLeft: true,
                    temperature: filteredDamagesList[index].temperatur,
                    airPressure: filteredDamagesList[index].airPressure,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Sensor {
  final String sensorName;
  final double latitude;
  final double longitude;
  final String status;
  final String createDate;
  final String signalStrength;
  final String chargerInfo;
  final double temperatur;
  final int airPressure;

  Sensor({
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
