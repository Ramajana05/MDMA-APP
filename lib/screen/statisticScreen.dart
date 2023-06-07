import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsScreen extends StatefulWidget {
  StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bar Chart'),
      ),
      body: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <BarSeries<WeekDayData, String>>[
          BarSeries<WeekDayData, String>(
            dataSource: getWeekDayData(),
            xValueMapper: (WeekDayData data, _) => data.day,
            yValueMapper: (WeekDayData data, _) => data.value,
            gradient: LinearGradient(
              colors: [
                Colors.lightGreen,
                Colors.green,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ],
      ),
    );
  }

  List<WeekDayData> getWeekDayData() {
    return [
      WeekDayData('Monday', 120),
      WeekDayData('Tuesday', 90),
      WeekDayData('Wednesday', 150),
      WeekDayData('Thursday', 70),
      WeekDayData('Friday', 180),
      WeekDayData('Saturday', 130),
      WeekDayData('Sunday', 200),
    ];
  }
}

class WeekDayData {
  final String day;
  final int value;

  WeekDayData(this.day, this.value);
}
