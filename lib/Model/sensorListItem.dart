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

  Widget _buildBatteryIcon(String chargerInfo) {
    int batteryLevel = int.tryParse(chargerInfo) ?? 0;

    if (batteryLevel >= 90) {
      return Icon(
        Icons.battery_full,
        size: 30,
        color: Color.fromARGB(255, 46, 202, 51),
      );
    } else if (batteryLevel >= 75) {
      return Icon(
        Icons.battery_5_bar,
        size: 30,
        color: Color.fromARGB(255, 46, 202, 51),
      );
    } else if (batteryLevel >= 60) {
      return Icon(
        Icons.battery_4_bar,
        size: 30,
        color: Colors.orange,
      );
    } else if (batteryLevel >= 45) {
      return Icon(
        Icons.battery_3_bar,
        size: 30,
        color: Colors.orange,
      );
    } else if (batteryLevel >= 30) {
      return Icon(
        Icons.battery_3_bar,
        size: 30,
        color: Colors.red,
      );
    } else if (batteryLevel >= 15) {
      return Icon(
        Icons.battery_2_bar,
        size: 30,
        color: Colors.red,
      );
    } else if (batteryLevel >= 5) {
      return Icon(
        Icons.battery_1_bar,
        size: 30,
        color: Colors.red,
      );
    } else {
      return Icon(
        Icons.battery_0_bar,
        size: 30,
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(249, 255, 255, 255),
      elevation: 6, // Increase the elevation for a stronger BoxShadow effect
      shadowColor: Colors.black54, // Adjust the shadow color if needed
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 11),
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
                                    ? Color.fromARGB(255, 64, 236, 73)
                                    : Colors.black,
                              ),
                              SizedBox(width: 4),
                              Text(
                                widget.damageTitle,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              SizedBox(height: 4),
                              SizedBox(width: 4),
                              Text(
                                'Standort: ${widget.latitude}, ${widget.longitude}',
                                style: TextStyle(
                                  fontSize: 16,
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
                          size: 30,
                          color: Colors.black,
                        ),
                        SizedBox(height: 6),
                        _buildBatteryIcon(widget.chargerInfo),
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
                    SizedBox(height: 10),
                    Text(
                      'Sensor Werte:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Aktuelle Temperatur: ${widget.temperatur}°C',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Aktueller Luftdruck: ${widget.airPressure}hPa',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Aktuelle Signal Stärke: ${widget.signalStrength}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Aktueller Akku Stand: ${widget.chargerInfo}%',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
