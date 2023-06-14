import 'dart:math';

import 'package:flutter/material.dart';
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
  var yearly = "Monatliche";

  var rainTextVisible = 'Regenwahrscheinlichkeit einblenden';
  var rainTextHidden = 'Regenwahrscheinlichkeit ausblenden';

  double dailyMax = 5;
  double weeklyMax = 6;
  double monthlyMax = 3;
  double yearlyMax = 5;
  Radius bottom20 = const Radius.circular(20);
  Radius bottomZero = Radius.zero;

  late List<ChartData> visitorChartDaily;
  late List<ChartData> visitorChartWeekly;
  late List<ChartData> visitorChartMonthly;
  late List<ChartData> visitorChartYearly;

  late List<ChartData> tempChartDaily;
  late List<ChartData> tempChartWeekly;
  late List<ChartData> tempChartMonthly;
  late List<ChartData> tempChartYearly;

  late List<ChartData> airHumidityChartDaily;
  late List<ChartData> airHumidityChartWeekly;
  late List<ChartData> airHumidityChartMonthly;
  late List<ChartData> airHumidityChartYearly;

  late List<ChartData> rainPercentChartDaily;
  late List<ChartData> rainPercentChartWeekly;
  late List<ChartData> rainPercentChartMonthly;
  late List<ChartData> rainPercentChartYearly;

  bool visitorVisible = true;
  bool tempVisible = true;
  bool airVisible = true;
  bool rainLineChart = true;
  bool rainLineChart2 = false;

  void handleToggle(bool value) {
    setState(() {
      rainLineChart = value;
    });
  }

  void handleToggle2(bool value2) {
    setState(() {
      rainLineChart2 = value2;
    });
  }

  var visitorGradient = const [
    Color.fromARGB(255, 46, 90, 4), // Medium Green
    Color.fromARGB(255, 59, 133, 6), // Dark Green
    Color.fromARGB(255, 68, 204, 75), // Light Brown
    Color.fromARGB(255, 45, 250, 63), // Medium Brown
  ];

  var temperatureGradient = const [
    Color(0xFF87CEEB), // Mid color (Sky Blue)
    Color(0xFF6495ED), // End color (Cornflower Blue)
    Color(0xFFFA8072), // Salmon
    Colors.red, // Red
  ];

  var airHumidityGradient = const [
    Color(0xFF87CEEB), // Baby Blue
    Color(0xFF79A8D3), // Light Blue
    Color(0xFF6495ED), // Cornflower Blue
    Color(0xFF5C6ACD), // Medium Blue
    Color(0xFF6A5ACD), // Slate Blue
  ];

  final visitorChartShadow = buildChartBoxDecoration(const Color(0xFF7EA15D));
  final temperatureChartShadow =
      buildChartBoxDecoration(const Color(0xFF6495ED));
  final airHumidityChartShadow =
      buildChartBoxDecoration(const Color(0xFF6A5ACD));

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

    visitorChartYearly = generateChartData(12, (index) {
      String monthName = getMonthName(index + 1);
      double visitors = Random().nextInt(1000) + 5000;
      return ChartData(monthName, visitors);
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

    tempChartYearly = generateChartData(12, (month) {
      double temperature = Random().nextInt(26) + 10;
      return ChartData(getMonthName(month + 1), temperature);
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

    airHumidityChartYearly = generateChartData(12, (index) {
      double humidity = Random().nextInt(16) + 45;
      return ChartData(getMonthName(index + 1), humidity);
    });

    rainPercentChartDaily = generateChartData(24, (hour) {
      double rainPercentage = Random().nextInt(16) + 10;
      return ChartData(getHours(hour), rainPercentage);
    });

    rainPercentChartWeekly = generateChartData(7, (index) {
      double rainPercentage = Random().nextInt(6) + 22;
      return ChartData(getWeekday(index + 1), rainPercentage);
    });

    rainPercentChartMonthly = generateChartData(4, (index) {
      double rainPercentage = Random().nextInt(11) + 10;
      return ChartData(getWeekOfPreviousMonth(index + 1), rainPercentage);
    });

    rainPercentChartYearly = generateChartData(12, (index) {
      double rainPercentage = Random().nextInt(21) + 10;
      return ChartData(getMonthName(index + 1), rainPercentage);
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
                    tabTexts: const ['Tag', 'Woche', 'Monat', 'Jahr'],
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
                        buildYearlyTab(),
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
    List<Color> gradientColors,
    bool showLineSeries,
    List<ChartData>? lineSeriesData,
    List<Color>? lineSeriesColors,
    double visibleMaximum,
    String chartName,
  ) {
    bool isDailyTemperatureChart = chartData == tempChartDaily;
    bool isWeeklyTemperatureChart = chartData == tempChartWeekly;

    String xAxisTitle = '';
    if (chartData == visitorChartDaily ||
        chartData == tempChartDaily ||
        chartData == airHumidityChartDaily) {
      xAxisTitle = 'Uhrzeit';
    }

    String yAxisTitle = '';
    if (chartData == visitorChartDaily ||
        chartData == visitorChartMonthly ||
        chartData == visitorChartYearly ||
        chartData == visitorChartWeekly) {
      yAxisTitle = 'Anzahl';
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(
            labelIntersectAction: AxisLabelIntersectAction.multipleRows,
            axisLine: const AxisLine(color: Colors.black, width: 1.5),
            labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
            crossesAt: (isDailyTemperatureChart || isWeeklyTemperatureChart)
                ? 0
                : null,
            placeLabelsNearAxisLine: false,
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
                    chartData == airHumidityChartMonthly ||
                    chartData == airHumidityChartYearly)
                ? '{value}%'
                : (chartData == tempChartDaily ||
                        chartData == tempChartWeekly ||
                        chartData == tempChartMonthly ||
                        chartData == tempChartYearly)
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
          ), //Scroll enabling
          zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
          ),
          series: <ChartSeries>[
            ColumnSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              borderRadius:
                  (chartData == tempChartDaily || chartData == tempChartWeekly)
                      ? BorderRadius.circular(20)
                      : const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              dataLabelMapper: (ChartData data, _) => '${data.y}',
            ),
            if (showLineSeries && lineSeriesData != null)
              LineSeries<ChartData, String>(
                dataSource: lineSeriesData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                markerSettings: const MarkerSettings(
                  height: 5,
                  width: 5,
                  isVisible: true,
                  borderColor: Colors.deepOrange,
                  color: Colors.deepOrange,
                  shape: DataMarkerType.circle,
                ),
                color: const Color.fromARGB(255, 42, 223, 123),
              ),
            if (showLineSeries && lineSeriesData != null)
              LineSeries<ChartData, String>(
                dataSource: lineSeriesData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  borderColor: Color(0xFF800080),
                  color: Colors.deepOrange,
                  shape: DataMarkerType.circle,
                ),
                color: const Color(0xFF00BFFF),
              ),
          ],
          tooltipBehavior: TooltipBehavior(enable: true, header: chartName),
        ),
      ),
    );
  }

  Widget buildDailyTab() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Visitor
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

                  // Button
                  Visibility(
                    visible: visitorVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SwitchListTile(
                        activeColor: const Color.fromRGBO(
                            38, 158, 38, 0.2), // Lighter green tone
                        activeTrackColor:
                            const Color.fromARGB(255, 40, 160, 40),
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

                  // Chart - Visitor
                  Visibility(
                    visible: visitorVisible,
                    child: Container(
                      child: buildChartWidget(
                        visitorChartDaily,
                        visitorGradient,
                        rainLineChart,
                        rainPercentChartDaily,
                        temperatureGradient,
                        dailyMax,
                        '$daily $visitor',
                      ),
                    ),
                  ),
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
                    child: buildChartWidget(
                      tempChartDaily,
                      temperatureGradient,
                      false,
                      null,
                      null,
                      dailyMax,
                      '$daily $temperature',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Button
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

                  // Chart - Air Humidity
                  Visibility(
                    visible: airVisible,
                    child: buildChartWidget(
                      airHumidityChartDaily,
                      airHumidityGradient,
                      false,
                      null,
                      null,
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
          // Visitor
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

                  // Button
                  Visibility(
                    visible: visitorVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SwitchListTile(
                        activeColor: const Color.fromRGBO(
                            38, 158, 38, 0.2), // Lighter green tone
                        activeTrackColor:
                            const Color.fromARGB(255, 40, 160, 40),
                        title: Text(
                          rainLineChart2 ? rainTextVisible : rainTextHidden,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                        value: rainLineChart2,
                        onChanged: handleToggle2,
                      ),
                    ),
                  ),

                  // Chart - Visitor
                  Visibility(
                    visible: visitorVisible,
                    child: buildChartWidget(
                        visitorChartWeekly,
                        visitorGradient,
                        rainLineChart2,
                        rainPercentChartWeekly,
                        temperatureGradient,
                        weeklyMax,
                        '$weekly $visitor'),
                  ),
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
                    child: buildChartWidget(
                        tempChartWeekly,
                        temperatureGradient,
                        false,
                        null,
                        null,
                        weeklyMax,
                        '$weekly $temperature'),
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

                  // Chart - Air Humidity
                  Visibility(
                    visible: airVisible,
                    child: buildChartWidget(
                        airHumidityChartWeekly,
                        airHumidityGradient,
                        false,
                        null,
                        null,
                        weeklyMax,
                        '$weekly $airHumidity'),
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
          // Visitor
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

                  // Button
                  Visibility(
                    visible: visitorVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SwitchListTile(
                        activeColor: const Color.fromRGBO(
                            38, 158, 38, 0.2), // Lighter green tone
                        activeTrackColor:
                            const Color.fromARGB(255, 40, 160, 40),
                        title: Text(
                          rainLineChart2 ? rainTextVisible : rainTextHidden,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                        value: rainLineChart2,
                        onChanged: handleToggle2,
                      ),
                    ),
                  ),

                  // Chart - Visitor
                  Visibility(
                      visible: visitorVisible,
                      child: buildChartWidget(
                          visitorChartMonthly,
                          visitorGradient,
                          rainLineChart2,
                          rainPercentChartMonthly,
                          temperatureGradient,
                          monthlyMax,
                          '$monthly $visitor')),
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
                    child: buildChartWidget(
                        tempChartMonthly,
                        temperatureGradient,
                        false,
                        null,
                        null,
                        monthlyMax,
                        '$monthly $temperature'),
                  ),
                ],
              ),
            ),
          ),

          // Button
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

                  // Chart - Air Humidity
                  Visibility(
                    visible: airVisible,
                    child: buildChartWidget(
                        airHumidityChartMonthly,
                        airHumidityGradient,
                        false,
                        null,
                        null,
                        monthlyMax,
                        '$monthly $airHumidity'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildYearlyTab() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Visitor Header
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

                  // Button Rain
                  Visibility(
                    visible: visitorVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SwitchListTile(
                        activeColor: const Color.fromRGBO(
                            38, 158, 38, 0.2), // Lighter green tone
                        activeTrackColor:
                            const Color.fromARGB(255, 40, 160, 40),
                        title: Text(
                          rainLineChart2 ? rainTextVisible : rainTextHidden,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                        value: rainLineChart2,
                        onChanged: handleToggle2,
                      ),
                    ),
                  ),

                  // Chart - Visitor
                  Visibility(
                    visible: visitorVisible,
                    child: buildChartWidget(
                        visitorChartYearly,
                        visitorGradient,
                        rainLineChart2,
                        rainPercentChartYearly,
                        temperatureGradient,
                        yearlyMax,
                        '$yearly $visitor'),
                  ),
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
                    child: buildChartWidget(
                        tempChartYearly,
                        temperatureGradient,
                        false,
                        null,
                        null,
                        yearlyMax,
                        '$yearly $temperature'),
                  ),
                ],
              ),
            ),
          ),

          // Button
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

                  // Chart - Air Humidity
                  Visibility(
                    visible: airVisible,
                    child: buildChartWidget(
                        airHumidityChartYearly,
                        airHumidityGradient,
                        false,
                        null,
                        null,
                        yearlyMax,
                        '$yearly $airHumidity'),
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
