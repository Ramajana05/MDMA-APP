import 'dart:math';

import 'package:flutter/material.dart';
import 'package:forestapp/colors/appColors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../widget/sidePanelWidget.dart';
import '../widget/topNavBar.dart';
import '../widget/tabBarWidget.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreen();
}

class _StatisticsScreen extends State<StatisticsScreen>
    with SingleTickerProviderStateMixin {
  var visitor = "Besucher";

  var temperature = "Temperatur";
  var airHumidity = "Luftfeuchtigkeit";

  var monthly = "Monatliche";
  var daily = "Tägliche";
  var weekly = "Wöchentliche";

  var rainTextVisible = 'Regenwahrscheinlichkeit einblenden';
  var rainTextHidden = 'Regenwahrscheinlichkeit ausblenden';

  double dailyMax = 5;
  double weeklyMax = 6;
  double monthlyMax = 3;

  late List<ChartData> visitorChartDaily;
  late List<ChartData> visitorChartWeekly;
  late List<ChartData> visitorChartMonthly;

  late List<ChartData> tempChartDaily;
  late List<ChartData> tempChartWeekly;
  late List<ChartData> tempChartMonthly;

  late List<ChartData> airHumidityChartDaily;
  late List<ChartData> airHumidityChartWeekly;
  late List<ChartData> airHumidityChartMonthly;

  late List<ChartData> rainPercentChartDaily;

  bool visitorVisible = true;
  bool tempVisible = true;
  bool airVisible = true;
  bool rainLineChart = true;

  void handleToggle(bool value) {
    setState(() {
      rainLineChart = value;
    });
  }

  ///linechart color
  var visitorGradient = primaryVisitorColor;
  var temperatureColor = primaryTempColor;
  var airHumidityColor = primaryHumidityColor;

  ///box shadow color
  final visitorChartShadow = buildChartBoxDecoration(primaryVisitorShadowColor);
  final temperatureChartShadow =
      buildChartBoxDecoration(primaryTempShadowColor);
  final airHumidityChartShadow =
      buildChartBoxDecoration(primaryHumidityShadowColor);

  TabController? _tabController;
  int _selectedTabIndex = 0;

  String getWeekOfPreviousMonth(int weekNumber) {
    final now = DateTime.now();
    final firstDayOfPreviousMonth = DateTime(now.year, now.month - 1, 1);
    final lastDayOfPreviousMonth = DateTime(now.year, now.month, 0);

    final weekStartDate = firstDayOfPreviousMonth
        .subtract(Duration(days: firstDayOfPreviousMonth.weekday - 1))
        .add(Duration(days: (weekNumber - 1) * 7));

    DateTime weekEndDate;
    if (weekNumber == 4) {
      weekEndDate = lastDayOfPreviousMonth;
    } else {
      weekEndDate = weekStartDate.add(const Duration(days: 6));
    }

    final weekStartDay = weekStartDate.day.toString().padLeft(2, '0');
    final weekEndDay = weekEndDate.day.toString().padLeft(2, '0');
    final month = firstDayOfPreviousMonth.month.toString().padLeft(2, '0');

    return '$weekStartDay.$month - $weekEndDay.$month';
  }

  String getMonthName(int month) {
    final germanMonthNames = [
      '',
      'Jan',
      'Feb',
      'März',
      'Apr',
      'Mai',
      'Juni',
      'Juli',
      'Aug',
      'Sept',
      'Okt',
      'Nov',
      'Dez',
    ];

    return germanMonthNames[month];
  }

  String getHours(int hour) {
    String hourString = hour.toString().padLeft(2, '0');
    return '$hourString:00';
  }

  String getWeekday(int day) {
    switch (day) {
      case 1:
        return 'Mo';
      case 2:
        return 'Di';
      case 3:
        return 'Mi';
      case 4:
        return 'Do';
      case 5:
        return 'Fr';
      case 6:
        return 'Sa';
      case 7:
        return 'So';
      default:
        throw Exception('Invalid day: $day');
    }
  }

  @override
  void initState() {
    super.initState();
    generateData();
    _tabController = TabController(length: 3, vsync: this);
  }

  void generateData() {
    visitorChartDaily = generateChartData(24, (hour) {
      String hourString = getHours(hour);
      double visitors = Random().nextInt(100) + 100;
      return ChartData(hourString, visitors);
    });

    visitorChartWeekly = generateChartData(7, (index) {
      String weekday = getWeekday(index + 1);
      double visitors = Random().nextInt(1000) + 700;
      return ChartData(weekday, visitors);
    });

    visitorChartMonthly = generateChartData(4, (index) {
      String weekOfPreviousMonth = getWeekOfPreviousMonth(index + 1);
      double visitors = Random().nextInt(1000) + 4000;
      return ChartData(weekOfPreviousMonth, visitors);
    });

    tempChartDaily = generateChartData(24, (hour) {
      double temperature = Random().nextInt(21) - 5;
      return ChartData(getHours(hour), temperature);
    });

    tempChartWeekly = generateChartData(7, (day) {
      double temperature = Random().nextInt(11) + 15;
      return ChartData(getWeekday(day + 1), temperature);
    });

    tempChartMonthly = generateChartData(4, (week) {
      double temperature = Random().nextInt(26) + 10;
      return ChartData(getWeekOfPreviousMonth(week + 1), temperature);
    });

    airHumidityChartDaily = generateChartData(24, (hour) {
      double humidity = Random().nextInt(51) + 50;
      return ChartData(getHours(hour), humidity);
    });

    airHumidityChartWeekly = generateChartData(7, (index) {
      double humidity = Random().nextInt(11) + 18;
      return ChartData(getWeekday(index + 1), humidity);
    });

    airHumidityChartMonthly = generateChartData(4, (index) {
      double humidity = Random().nextInt(31) + 20;
      return ChartData(getWeekOfPreviousMonth(index + 1), humidity);
    });

    rainPercentChartDaily = generateChartData(24, (hour) {
      double rainPercentage = Random().nextInt(91) + 10;
      return ChartData(getHours(hour), rainPercentage);
    });
  }

  List<ChartData> generateChartData(
      int count, ChartData Function(int) generator) {
    return List.generate(count, generator);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  static buildChartBoxDecoration(Color boxShadowColor) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: boxShadowColor,
          spreadRadius: 3,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidePanel(),
      backgroundColor: Colors.white,
      appBar: TopNavBar(
        title: 'STATISTIK',
        onMenuPressed: () {},
      ),
      body: Column(
        children: [
          DefaultTabController(
            length: 3,
            child: Expanded(
              child: Column(
                children: [
                  TabBarWidget(
                    tabTexts: const ['Tag', 'Woche', 'Monat'],
                    onTabSelected: (int index) {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    },
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: _selectedTabIndex,
                      children: [
                        buildDailyTab(),
                        buildWeeklyTab(),
                        buildMonthlyTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChartWidget(
    List<ChartData> chartData,
    Color chartColor,
    double visibleMaximum,
    String chartName,
  ) {
    String xAxisTitle = '';
    if (chartData == visitorChartDaily ||
        chartData == tempChartDaily ||
        chartData == airHumidityChartDaily) {
      xAxisTitle = 'Uhrzeit';
    }

    String yAxisTitle = '';
    if (chartData == visitorChartDaily ||
        chartData == visitorChartMonthly ||
        chartData == visitorChartWeekly) {
      yAxisTitle = 'Anzahl';
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(
            labelIntersectAction: AxisLabelIntersectAction.multipleRows,
            axisLine: const AxisLine(color: Colors.black, width: 1.5),
            labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
            visibleMaximum: visibleMaximum,
            desiredIntervals: 12,
            title: AxisTitle(
              text: xAxisTitle,
              textStyle: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          primaryYAxis: NumericAxis(
            labelFormat: (chartData == airHumidityChartDaily ||
                    chartData == airHumidityChartWeekly ||
                    chartData == airHumidityChartMonthly)
                ? '{value}%'
                : (chartData == tempChartDaily ||
                        chartData == tempChartWeekly ||
                        chartData == tempChartMonthly)
                    ? '{value}°C'
                    : '',
            title: AxisTitle(
              text: yAxisTitle,
              textStyle: const TextStyle(fontWeight: FontWeight.w700),
            ),
            majorTickLines:
                const MajorTickLines(size: 6, width: 2, color: Colors.black),
            axisLine: const AxisLine(color: Colors.black, width: 1.5),
            labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
          ),
          //Scroll enabling
          zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
          ),
          series: <ChartSeries>[
            LineSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              markerSettings: const MarkerSettings(
                borderColor: Color(0xFFE08055),
                isVisible: true,
                color: Color(0xFFCC6699),
                shape: DataMarkerType.circle,
              ),
              color: chartColor,
              dataLabelMapper: (ChartData data, _) => '${data.y}',
            ),
            LineSeries<ChartData, String>(
              dataSource: rainPercentChartDaily,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              isVisible: rainLineChart == true && chartData == visitorChartDaily
                  ? true
                  : false,
              markerSettings: const MarkerSettings(
                borderColor: Color(0xFF800080),
                isVisible: true,
                color: Colors.deepOrange,
                shape: DataMarkerType.circle,
              ),
              color: const Color.fromARGB(255, 56, 162, 197),
            ),
          ],
          tooltipBehavior: TooltipBehavior(
            enable: true,
            builder: (dynamic data, dynamic point, dynamic series,
                int pointIndex, int seriesIndex) {
              if (seriesIndex == 0) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '${data.y}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              } else if (seriesIndex == 1) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Regenwahrscheinlichkeit: ${data.y}%',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget buildDailyTab() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Visitor
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: visitorChartShadow,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        visitorVisible = !visitorVisible;
                      });
                    },
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              visitor,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              visitorVisible
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                            onPressed: () {
                              setState(() {
                                visitorVisible = !visitorVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Button
                  Visibility(
                    visible: visitorVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SwitchListTile(
                        activeColor: const Color.fromRGBO(38, 158, 38, 0.2),
                        // Lighter green tone
                        activeTrackColor: primaryAppLightGreen,
                        title: Text(
                          rainLineChart ? rainTextVisible : rainTextHidden,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                        value: rainLineChart,
                        onChanged: handleToggle,
                      ),
                    ),
                  ),

                  /// Chart - Visitor
                  Visibility(
                    visible: visitorVisible,
                    child: Container(
                      child: buildChartWidget(
                        visitorChartDaily,
                        visitorGradient,
                        dailyMax,
                        '$daily $visitor',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: temperatureChartShadow,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        tempVisible = !tempVisible;
                      });
                    },
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              temperature,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              tempVisible
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                            onPressed: () {
                              setState(() {
                                tempVisible = !tempVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Chart - Temperature
                  Visibility(
                    visible: tempVisible,
                    child: buildChartWidget(
                      tempChartDaily,
                      temperatureColor,
                      dailyMax,
                      '$daily $temperature',
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: airHumidityChartShadow,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        airVisible = !airVisible;
                      });
                    },
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              airHumidity,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              airVisible
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                            onPressed: () {
                              setState(() {
                                airVisible = !airVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Chart - Air Humidity
                  Visibility(
                    visible: airVisible,
                    child: buildChartWidget(
                      airHumidityChartDaily,
                      airHumidityColor,
                      dailyMax,
                      '$daily $airHumidity',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWeeklyTab() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Visitor
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: visitorChartShadow,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        visitorVisible = !visitorVisible;
                      });
                    },
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              visitor,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              visitorVisible
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                            onPressed: () {
                              setState(() {
                                visitorVisible = !visitorVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Chart - Visitor
                  Visibility(
                    visible: visitorVisible,
                    child: buildChartWidget(visitorChartWeekly, visitorGradient,
                        weeklyMax, '$weekly $visitor'),
                  ),
                ],
              ),
            ),
          ),

          /// Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: temperatureChartShadow,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        tempVisible = !tempVisible;
                      });
                    },
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              temperature,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              tempVisible
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                            onPressed: () {
                              setState(() {
                                tempVisible = !tempVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Chart - Temperature
                  Visibility(
                    visible: tempVisible,
                    child: buildChartWidget(tempChartWeekly, temperatureColor,
                        weeklyMax, '$weekly $temperature'),
                  ),
                ],
              ),
            ),
          ),

          // Air Humidity
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: airHumidityChartShadow,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        airVisible = !airVisible;
                      });
                    },
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              airHumidity,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              airVisible
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                            onPressed: () {
                              setState(() {
                                airVisible = !airVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Chart - Air Humidity
                  Visibility(
                    visible: airVisible,
                    child: buildChartWidget(airHumidityChartWeekly,
                        airHumidityColor, weeklyMax, '$weekly $airHumidity'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMonthlyTab() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Visitor
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: visitorChartShadow,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        visitorVisible = !visitorVisible;
                      });
                    },
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              visitor,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              visitorVisible
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                            onPressed: () {
                              setState(() {
                                visitorVisible = !visitorVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Chart - Visitor
                  Visibility(
                      visible: visitorVisible,
                      child: buildChartWidget(visitorChartMonthly,
                          visitorGradient, monthlyMax, '$monthly $visitor')),
                ],
              ),
            ),
          ),

          // Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: temperatureChartShadow,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        tempVisible = !tempVisible;
                      });
                    },
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              temperature,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              tempVisible
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                            onPressed: () {
                              setState(() {
                                tempVisible = !tempVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Chart - Temperature
                  Visibility(
                    visible: tempVisible,
                    child: buildChartWidget(tempChartMonthly, temperatureColor,
                        monthlyMax, '$monthly $temperature'),
                  ),
                ],
              ),
            ),
          ),

          /// Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: airHumidityChartShadow,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        airVisible = !airVisible;
                      });
                    },
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              airHumidity,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              airVisible
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                            onPressed: () {
                              setState(() {
                                airVisible = !airVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Chart - Air Humidity
                  Visibility(
                    visible: airVisible,
                    child: buildChartWidget(airHumidityChartMonthly,
                        airHumidityColor, monthlyMax, '$monthly $airHumidity'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String x;
  double y;

  ChartData(this.x, this.y);
}
