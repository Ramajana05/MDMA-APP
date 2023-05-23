import 'dart:ffi';

import 'package:flutter/material.dart';

class SensorListItemWidget extends StatefulWidget {
  final String damageTitle;
  final double latitude;
  final double longitude;
  final String status;
  final String createDate;
  final String signalStrength;
  final String chargerInfo;
  final bool alignLeft;
  final double temperatur;
  final int airPressure;

  SensorListItemWidget({
    required this.damageTitle,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.createDate,
    required this.signalStrength,
    required this.chargerInfo,
    required this.temperatur,
    required this.airPressure,
    this.alignLeft = false, // Default value for alignLeft is false
  });

  @override
  _SensorListItemWidgetState createState() => _SensorListItemWidgetState();
}

class _SensorListItemWidgetState extends State<SensorListItemWidget> {
  bool expanded = false;

  @override
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(249, 255, 255, 255),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            title: Row(
              children: [
                Expanded(
                  flex: widget.alignLeft ? 5 : 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Icon(
                              Icons.sensors,
                              color: widget.status == 'Online'
                                  ? Color.fromARGB(255, 3, 165, 9)
                                  : Colors.black,
                            ),
                            SizedBox(width: 4),
                            Text(
                              widget.damageTitle,
                              style: TextStyle(
                                fontSize: 18, // Adjust the font size here
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            SizedBox(height: 4),
                            SizedBox(width: 4),
                            Text(
                              'Standort: ${widget.latitude}  ${widget.longitude}',
                              style: TextStyle(
                                fontSize: 15, // Adjust the font size here
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: widget.alignLeft ? 3 : 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.createDate,
                        style: TextStyle(
                          fontSize: 15, // Adjust the font size here
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (expanded)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Sensor Werte:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Aktuelle Temperatur: ${widget.temperatur}°C',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Aktueller Luftdruck: ${widget.airPressure}hPa',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Aktuelle Signal Stärke: ${widget.signalStrength}',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Aktueller Akku Stand: ${widget.chargerInfo}%',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
