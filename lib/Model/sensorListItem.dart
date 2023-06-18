import 'package:flutter/material.dart';

import '../colors/appColors.dart';

class SensorListItemWidget extends StatefulWidget {
  final String sensorTitle;
  final double latitude;
  final double longitude;
  final String status;
  final String createDate;
  final String signalStrength;
  final String chargerInfo;
  final bool alignLeft;
  final double temperature;
  final int airPressure;

  const SensorListItemWidget({
    super.key,
    required this.sensorTitle,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.createDate,
    required this.signalStrength,
    required this.chargerInfo,
    required this.temperature,
    required this.airPressure,
    this.alignLeft = false,
  });

  @override
  _SensorListItemWidgetState createState() => _SensorListItemWidgetState();
}

class _SensorListItemWidgetState extends State<SensorListItemWidget> {
  bool expanded = false;

  Widget _buildBatteryIcon(String chargerInfo) {
    int batteryLevel = int.tryParse(chargerInfo) ?? 0;

    if (batteryLevel >= 90) {
      return const Icon(
        Icons.battery_full,
        size: 30,
        color: primaryGreen,
      );
    } else if (batteryLevel >= 75) {
      return const Icon(
        Icons.battery_5_bar,
        size: 30,
        color: primaryGreen,
      );
    } else if (batteryLevel >= 60) {
      return const Icon(
        Icons.battery_4_bar,
        size: 30,
        color: primaryOrange,
      );
    } else if (batteryLevel >= 45) {
      return const Icon(
        Icons.battery_3_bar,
        size: 30,
        color: primaryOrange,
      );
    } else if (batteryLevel >= 30) {
      return const Icon(
        Icons.battery_3_bar,
        size: 30,
        color: primaryOrange,
      );
    } else if (batteryLevel >= 15) {
      return const Icon(
        Icons.battery_2_bar,
        size: 30,
        color: primaryTempColor,
      );
    } else if (batteryLevel >= 5) {
      return const Icon(
        Icons.battery_1_bar,
        size: 30,
        color: primaryTempColor,
      );
    } else {
      return const Icon(
        Icons.battery_0_bar,
        size: 30,
        color: primaryTempColor,
      );
    }
  }

  String _formatCoordinate(double coordinate) {
    return coordinate.toStringAsFixed(3);
  }

  @override
  Widget build(BuildContext context) {
    final formattedLatitude = _formatCoordinate(widget.latitude);
    final formattedLongitude = _formatCoordinate(widget.longitude);

    return Card(
      color: Color.fromARGB(249, 255, 255, 255),
      elevation: 6,
      shadowColor: Colors.black54,
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

                                    ? primaryGreen
                                    : primarygrey,

                              ),
                              SizedBox(width: 4),
                              Text(
                                widget.sensorTitle,
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
                                'Standort: $formattedLatitude, $formattedLongitude',
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
                      'Aktuelle Temperatur: ${widget.temperature}°C',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Aktueller Luftfeuchtigkeit: ${widget.airPressure}%',
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
