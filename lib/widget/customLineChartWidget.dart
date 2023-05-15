import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../Model/DataCategoryEnum.dart';
import '../Model/IntervalTypeEnum.dart';
import 'checkBoxValuesForCharts.dart';
import '../Model/DataModel.dart';

/// custom LinChart that shows the data represented in hourly or daily interval
class customLineChart extends StatelessWidget {
  final IntervalType intervalType;

  ///lists include the data for the charts
  List<DataModel> chartDataDaily = [
    DataModel(date: 0, value: 2, category: DataCategory.persons),
    DataModel(date: 1, value: 15, category: DataCategory.persons),
    DataModel(date: 2, value: 8, category: DataCategory.persons),
    DataModel(date: 3, value: 17, category: DataCategory.persons),
    DataModel(date: 4, value: 2, category: DataCategory.persons),
    DataModel(date: 5, value: 10, category: DataCategory.persons),
    DataModel(date: 6, value: 5, category: DataCategory.persons),
    DataModel(date: 0, value: 12.5, category: DataCategory.temperature),
    DataModel(date: 1, value: 14.8, category: DataCategory.temperature),
    DataModel(date: 2, value: 4.5, category: DataCategory.temperature),
    DataModel(date: 3, value: -18, category: DataCategory.temperature),
    DataModel(date: 4, value: 3, category: DataCategory.temperature),
    DataModel(date: 5, value: 6.8, category: DataCategory.temperature),
    DataModel(date: 6, value: 9, category: DataCategory.temperature),
    DataModel(date: 0, value: 1, category: DataCategory.humidity),
    DataModel(date: 1, value: 89, category: DataCategory.humidity),
    DataModel(date: 2, value: 64, category: DataCategory.humidity),
    DataModel(date: 3, value: 150, category: DataCategory.humidity),
    DataModel(date: 4, value: 92, category: DataCategory.humidity),
    DataModel(date: 5, value: 80, category: DataCategory.humidity),
    DataModel(date: 6, value: 66, category: DataCategory.humidity),
  ];
  List<DataModel> chartDataHourly = [
    DataModel(date: 0, value: 2, category: DataCategory.persons),
    DataModel(date: 1, value: 15, category: DataCategory.persons),
    DataModel(date: 2, value: 8, category: DataCategory.persons),
    DataModel(date: 3, value: 17, category: DataCategory.persons),
    DataModel(date: 4, value: 2, category: DataCategory.persons),
    DataModel(date: 5, value: 10, category: DataCategory.persons),
    DataModel(date: 6, value: 5, category: DataCategory.persons),
    DataModel(date: 7, value: 2, category: DataCategory.persons),
    DataModel(date: 8, value: 15, category: DataCategory.persons),
    DataModel(date: 9, value: 8, category: DataCategory.persons),
    DataModel(date: 10, value: 17, category: DataCategory.persons),
    DataModel(date: 11, value: 2, category: DataCategory.persons),
    DataModel(date: 12, value: 10, category: DataCategory.persons),
    DataModel(date: 0, value: 12.5, category: DataCategory.temperature),
    DataModel(date: 1, value: 14.8, category: DataCategory.temperature),
    DataModel(date: 2, value: 4.5, category: DataCategory.temperature),
    DataModel(date: 3, value: -18, category: DataCategory.temperature),
    DataModel(date: 4, value: 3, category: DataCategory.temperature),
    DataModel(date: 5, value: 6.8, category: DataCategory.temperature),
    DataModel(date: 6, value: 9, category: DataCategory.temperature),
    DataModel(date: 7, value: 14.8, category: DataCategory.temperature),
    DataModel(date: 8, value: 4.5, category: DataCategory.temperature),
    DataModel(date: 9, value: -18, category: DataCategory.temperature),
    DataModel(date: 10, value: 3, category: DataCategory.temperature),
    DataModel(date: 11, value: 6.8, category: DataCategory.temperature),
    DataModel(date: 12, value: 9, category: DataCategory.temperature),
    DataModel(date: 0, value: 1, category: DataCategory.humidity),
    DataModel(date: 1, value: 89, category: DataCategory.humidity),
    DataModel(date: 2, value: 64, category: DataCategory.humidity),
    DataModel(date: 3, value: 23, category: DataCategory.humidity),
    DataModel(date: 4, value: 92, category: DataCategory.humidity),
    DataModel(date: 5, value: 80, category: DataCategory.humidity),
    DataModel(date: 6, value: 66, category: DataCategory.humidity),
    DataModel(date: 7, value: 1, category: DataCategory.humidity),
    DataModel(date: 8, value: 89, category: DataCategory.humidity),
    DataModel(date: 9, value: 64, category: DataCategory.humidity),
    DataModel(date: 10, value: 23, category: DataCategory.humidity),
    DataModel(date: 11, value: 110, category: DataCategory.humidity),
    DataModel(date: 12, value: 80, category: DataCategory.humidity),
  ];

  ///sub-lists include only x or y values subtracted from the data-lists above
  late List<double> x_values = intervalType == IntervalType.daily
      ? chartDataDaily.map((data) => data.date).toList()
      : chartDataHourly.map((data) => data.date).toList();
  late List<double> y_values = intervalType == IntervalType.daily
      ? chartDataDaily.map((data) => data.value).toList()
      : chartDataHourly.map((data) => data.value).toList();

  ///constructor
  customLineChart({required this.intervalType});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  ///Data to be showed bei the LineChart
  LineChartData get sampleData => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData,
        minX: 0,
      );

  ///Data to be showed bei touching the lines
  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.black87.withOpacity(0.9),
        ),
      );

  ///Titles to be showed on the axis
  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(axisNameSize: 2, sideTitles: sideTitles),
      );

  ///List contains the data of Persons
  List<DataModel> get categoryDataPersons {
    if (intervalType == IntervalType.daily) {
      return chartDataDaily
          .where((data) => data.category == DataCategory.persons)
          .toList();
    } else {
      return chartDataHourly
          .where((data) => data.category == DataCategory.persons)
          .toList();
    }
  }

  ///List contains the data of Temperatures
  List<DataModel> get categoryDataTemperature {
    if (intervalType == IntervalType.daily) {
      return chartDataDaily
          .where((data) => data.category == DataCategory.temperature)
          .toList();
    } else {
      return chartDataHourly
          .where((data) => data.category == DataCategory.temperature)
          .toList();
    }
  }

  ///List contains the data of Humidity
  List<DataModel> get categoryDataHumidity {
    if (intervalType == IntervalType.daily) {
      return chartDataDaily
          .where((data) => data.category == DataCategory.humidity)
          .toList();
    } else {
      return chartDataHourly
          .where((data) => data.category == DataCategory.humidity)
          .toList();
    }
  }

  List<LineChartBarData> get lineBarsData => [
        personsLineChartBarData,
        temperatureLineChartBarData,
        humidityLineChartBarData,
      ];

  ///returns the titles on the left Side
  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Colors.black, fontSize: 10, fontStyle: FontStyle.italic);
    String text;
    if (value == 0) {
      text = '0';
    } else {
      text = '${(value.toInt()).toInt()}';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  ///returns the titles on the bottom Side
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;

    switch (intervalType) {
      case IntervalType.hourly:
        if (value == 0) {
          text = const Text('0', style: style);
        } else if (value == 1) {
          text = const Text('1', style: style);
        } else if (value == 2) {
          text = const Text('2', style: style);
        } else if (value == 3) {
          text = const Text('3', style: style);
        } else if (value == 4) {
          text = const Text('4', style: style);
        } else if (value == 5) {
          text = const Text('5', style: style);
        } else if (value == 6) {
          text = const Text('6', style: style);
        } else if (value == 7) {
          text = const Text('7', style: style);
        } else if (value == 8) {
          text = const Text('8', style: style);
        } else if (value == 9) {
          text = const Text('9', style: style);
        } else if (value == 10) {
          text = const Text('10', style: style);
        } else if (value == 11) {
          text = const Text('11', style: style);
        } else if (value == 12) {
          text = const Text('12', style: style);
        } else {
          text = const Text('');
        }
        break;
      case IntervalType.daily:
      default:
        switch (value.toInt()) {
          case 0:
            text = const Text('Mo', style: style);
            break;
          case 1:
            text = const Text('Di', style: style);
            break;
          case 2:
            text = const Text('Mi', style: style);
            break;
          case 3:
            text = const Text('Do', style: style);
            break;
          case 4:
            text = const Text('Fr', style: style);
            break;
          case 5:
            text = const Text('Sa', style: style);
            break;
          case 6:
            text = const Text('So', style: style);
            break;
          default:
            text = const Text('');
            break;
        }
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get sideTitles => SideTitles(
      getTitlesWidget: leftTitles,
      reservedSize: 30,
      interval: 20,
      showTitles: true);

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.blue.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get personsLineChartBarData {
    List<FlSpot> spots = [];
    for (var data in categoryDataPersons) {
      spots.add(FlSpot(data.date, data.value));
    }
    return LineChartBarData(
      show: intervalType == IntervalType.hourly
          ? CheckBoxValuesForCharts.isCheckedPersonsHourly
          : CheckBoxValuesForCharts.isCheckedPersonsDaily,
      isCurved: true,
      color: Colors.green,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      spots: spots,
    );
  }

  LineChartBarData get temperatureLineChartBarData {
    List<FlSpot> spots = [];
    for (var data in categoryDataTemperature) {
      spots.add(FlSpot(data.date, data.value));
    }
    return LineChartBarData(
      show: intervalType == IntervalType.hourly
          ? CheckBoxValuesForCharts.isCheckedTemperatureHourly
          : CheckBoxValuesForCharts.isCheckedTemperatureDaily,
      isCurved: true,
      color: Colors.pink,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      spots: spots,
    );
  }

  LineChartBarData get humidityLineChartBarData {
    List<FlSpot> spots = [];
    for (var data in categoryDataHumidity) {
      spots.add(FlSpot(data.date, data.value));
    }
    return LineChartBarData(
      show: intervalType == IntervalType.hourly
          ? CheckBoxValuesForCharts.isCheckedHumidityHourly
          : CheckBoxValuesForCharts.isCheckedHumidityDaily,
      isCurved: true,
      color: Colors.cyan,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      spots: spots,
    );
  }
}
