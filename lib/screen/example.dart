import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartExample extends StatefulWidget {
  const ChartExample({Key? key}) : super(key: key);

  @override
  State<ChartExample> createState() => _ChartExampleState();
}

class _ChartExampleState extends State<ChartExample> {
  final double maxValue = 10; // Maximum value
  final double currentValue = 9; // Current value
  final Color chartColor = Colors.teal; // Chart color
  final Color trackColor = Colors.tealAccent; // Transparent track color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                SfCircularChart(
                  series: <CircularSeries<_ChartData, String>>[
                    RadialBarSeries<_ChartData, String>(
                      maximumValue: maxValue,
                      radius: '100%',
                      gap: '60%',
                      dataSource: [
                        _ChartData('Value', currentValue, Colors.teal),
                      ],
                      cornerStyle: CornerStyle.bothCurve,
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                      pointColorMapper: (_ChartData data, _) => data.color,
                      trackColor: Colors.tealAccent,
                    ),
                  ],
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              currentValue.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.sensors,
                                  size: 26,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  final String x;
  final double y;
  final Color color;

  _ChartData(this.x, this.y, this.color);
}
