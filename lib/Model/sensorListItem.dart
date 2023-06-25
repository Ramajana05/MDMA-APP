import 'package:flutter/material.dart';
import 'package:forestapp/colors/getBatteryColors.dart';

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

  Widget _buildBatteryIcon(String chargerInfo, double size) {
    int batteryLevel = int.tryParse(chargerInfo) ?? 0;
    Color batteryColor;

    if (batteryLevel >= 90) {
      return Icon(
        Icons.battery_full,
        size: size,
        color: getBatteryColor(batteryLevel),
      );
    } else if (batteryLevel >= 75) {
      return Icon(
        Icons.battery_5_bar,
        size: size,
        color: getBatteryColor(batteryLevel),
      );
    } else if (batteryLevel >= 60) {
      return Icon(
        Icons.battery_4_bar,
        size: size,
        color: getBatteryColor(batteryLevel),
      );
    } else if (batteryLevel >= 45) {
      return Icon(
        Icons.battery_3_bar,
        size: size,
        color: getBatteryColor(batteryLevel),
      );
    } else if (batteryLevel >= 30) {
      return Icon(
        Icons.battery_3_bar,
        size: size,
        color: getBatteryColor(batteryLevel),
      );
    } else if (batteryLevel >= 15) {
      return Icon(
        Icons.battery_2_bar,
        size: size,
        color: getBatteryColor(batteryLevel),
      );
    } else if (batteryLevel >= 5) {
      return Icon(
        Icons.battery_1_bar,
        size: size,
        color: getBatteryColor(batteryLevel),
      );
    } else {
      return Icon(
        Icons.battery_0_bar,
        size: size,
        color: getBatteryColor(batteryLevel),
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
      color: background,
      color: background,
      elevation: 6,
      shadowColor: buttonTextColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12.0), // Adjust the border radius as needed
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11),
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
                                    ? primaryAppLightGreen
                                    : grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.sensorTitle,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: textColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                'Standort: $formattedLatitude, $formattedLongitude',
                                style:
                                    TextStyle(fontSize: 17, color: textColor),
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
                          color: textColor,
                        ),
                        const SizedBox(height: 6),
                        _buildBatteryIcon(widget.chargerInfo, 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (expanded)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Aktuelle Werte:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.thermostat_outlined,
                          color: red, // Adjust the color as needed
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Temperatur: ${widget.temperature}°C',
                          style: TextStyle(fontSize: 17, color: textColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.water_drop_outlined,
                          color: blue, // Adjust the color as needed
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Luftfeuchtigkeit: ${widget.airPressure}%',
                          style: TextStyle(fontSize: 17, color: textColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.signal_cellular_alt_outlined,
                          color: textColor, // Adjust the color as needed
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Signalstärke: ${widget.signalStrength}',
                          style: TextStyle(fontSize: 17, color: textColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _buildBatteryIcon(widget.chargerInfo, 20),
                        const SizedBox(width: 6),
                        Text(
                          'Akkustand: ${widget.chargerInfo}%',
                          style: TextStyle(fontSize: 17, color: textColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
