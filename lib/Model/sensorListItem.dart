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

  const SensorListItemWidget({
    super.key,
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

  Color getTileBorderColor(int batteryLevel) {
    if (batteryLevel >= 90) {
      return const Color.fromARGB(255, 46, 202, 51); // Green
    } else if (batteryLevel >= 60) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  BoxDecoration buildChartBoxDecoration(Color boxShadowColor) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: boxShadowColor.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _buildBatteryIcon(String chargerInfo) {
    int batteryLevel = int.tryParse(chargerInfo) ?? 0;

    if (batteryLevel >= 90) {
      return const Icon(
        Icons.battery_full,
        size: 30,
        color: Color.fromARGB(255, 46, 202, 51),
      );
    } else if (batteryLevel >= 75) {
      return const Icon(
        Icons.battery_5_bar,
        size: 30,
        color: Color.fromARGB(255, 46, 202, 51),
      );
    } else if (batteryLevel >= 60) {
      return const Icon(
        Icons.battery_4_bar,
        size: 30,
        color: Colors.orange,
      );
    } else if (batteryLevel >= 45) {
      return const Icon(
        Icons.battery_3_bar,
        size: 30,
        color: Colors.orange,
      );
    } else if (batteryLevel >= 30) {
      return const Icon(
        Icons.battery_3_bar,
        size: 30,
        color: Colors.red,
      );
    } else if (batteryLevel >= 15) {
      return const Icon(
        Icons.battery_2_bar,
        size: 30,
        color: Colors.red,
      );
    } else if (batteryLevel >= 5) {
      return const Icon(
        Icons.battery_1_bar,
        size: 30,
        color: Colors.red,
      );
    } else {
      return const Icon(
        Icons.battery_0_bar,
        size: 30,
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int batteryLevel = int.tryParse(widget.chargerInfo) ?? 0;
    Color boxShadowColor = getTileBorderColor(batteryLevel);

    return Card(
      elevation: 6,
      shadowColor: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        decoration: buildChartBoxDecoration(boxShadowColor),
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
                                      ? const Color.fromARGB(255, 64, 236, 73)
                                      : Colors.black,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.damageTitle,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
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
                                const SizedBox(width: 4),
                                Text(
                                  'Standort: ${widget.latitude}, ${widget.longitude}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
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
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 30,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 6),
                          _buildBatteryIcon(widget.chargerInfo),
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
                      const Text(
                        'Sensor Werte:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Aktuelle Temperatur: ${widget.temperatur}°C',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Aktueller Luftdruck: ${widget.airPressure}hPa',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Aktuelle Signal Stärke: ${widget.signalStrength}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Aktueller Akku Stand: ${widget.chargerInfo}%',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
