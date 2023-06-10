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

  var rainTextVisible = 'Regenwahrscheinlichkeit einblenden';
  var rainTextHidden = 'Regenwahrscheinlichkeit ausblenden';

  var radius = const Radius.circular(20);

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
    Color(0xFF7EA15D), // Medium Green
    Color(0xFF5D8243), // Dark Green
    Color(0xFFA67E49), // Light Brown
    Color(0xFF8B632F), // Medium Brown
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

  var labelStyle = const TextStyle(fontSize: 15, color: Colors.black);
  var axisLine = const AxisLine(color: Colors.black, width: 1.5);
  var majorTickLines =
      const MajorTickLines(size: 6, width: 2, color: Colors.black);
  var axisTitleStyle = const TextStyle(fontWeight: FontWeight.w700);

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
      weekEndDate = weekStartDate.add(Duration(days: 6));
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
    return hour.toString().padLeft(2, '0');
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
    _tabController = TabController(length: 3, vsync: this);

    visitorChartDaily = List.generate(24, (hour) {
      String hourString = getHours(hour);
      double visitors = Random().nextInt(100) +
          100; // Generate a random value between 100 and 199
      return ChartData(hourString, visitors);
    });

    visitorChartWeekly = List.generate(7, (index) {
      String weekday = getWeekday(index + 1);
      double visitors = Random().nextInt(1000) +
          700; // Generate a random value between 700 and 1699
      return ChartData(weekday, visitors);
    });

    visitorChartMonthly = List.generate(4, (index) {
      String weekOfPreviousMonth = getWeekOfPreviousMonth(index + 1);
      double visitors = Random().nextInt(1000) +
          4000; // Generate a random value between 4000 and 4999
      return ChartData(weekOfPreviousMonth, visitors);
    });

    visitorChartYearly = List.generate(12, (index) {
      String monthName = getMonthName(index + 1);
      double visitors = Random().nextInt(1000) +
          5000; // Generate a random value between 5000 and 5999
      return ChartData(monthName, visitors);
    });

    tempChartDaily = List.generate(24, (hour) {
      double temperature = Random().nextDouble() * 15 -
          5; // Generate a random value between -10 and 5 degrees Celsius
      return ChartData(getHours(hour), temperature);
    });

    tempChartWeekly = List.generate(7, (day) {
      double temperature = Random().nextDouble() * 10 +
          15; // Generate a random value between 15 and 25 degrees Celsius
      return ChartData(getWeekday(day + 1), temperature);
    });

    tempChartMonthly = List.generate(4, (week) {
      double temperature = Random().nextDouble() * 10 +
          10; // Generate a random value between 10 and 20 degrees Celsius
      return ChartData(getWeekOfPreviousMonth(week + 1), temperature);
    });

    tempChartYearly = List.generate(12, (month) {
      double temperature = Random().nextDouble() * 20 -
          5; // Generate a random value between -5 and 15 degrees Celsius
      return ChartData(getMonthName(month + 1), temperature);
    });

    airHumidityChartDaily = List.generate(24, (hour) {
      double humidity = Random().nextInt(51) +
          50; // Generate a random value between 50 and 100 percent
      return ChartData(getHours(hour), humidity);
    });

    airHumidityChartWeekly = List.generate(7, (index) {
      double humidity = Random().nextInt(11) +
          18; // Generate a random value between 18 and 28 percent
      return ChartData(getWeekday(index + 1), humidity);
    });

    airHumidityChartMonthly = List.generate(4, (index) {
      double humidity = Random().nextInt(31) +
          20; // Generate a random value between 20 and 50 percent
      return ChartData(getWeekOfPreviousMonth(index + 1), humidity);
    });

    airHumidityChartYearly = List.generate(12, (index) {
      double humidity = Random().nextInt(16) +
          45; // Generate a random value between 45 and 60 percent
      return ChartData(getMonthName(index + 1), humidity);
    });

    rainPercentChartDaily = List.generate(24, (hour) {
      double rainPercentage = Random().nextInt(16) +
          10; // Generate a random value between 10 and 25 percent
      return ChartData(getHours(hour), rainPercentage);
    });

    rainPercentChartWeekly = List.generate(7, (index) {
      double rainPercentage = Random().nextInt(6) +
          22; // Generate a random value between 22 and 27 percent
      return ChartData(getWeekday(index + 1), rainPercentage);
    });

    rainPercentChartMonthly = List.generate(4, (index) {
      double rainPercentage = Random().nextInt(11) +
          10; // Generate a random value between 10 and 20 percent
      return ChartData(getWeekOfPreviousMonth(index + 1), rainPercentage);
    });

    rainPercentChartYearly = List.generate(12, (index) {
      double rainPercentage = Random().nextInt(21) +
          10; // Generate a random value between 10 and 30 percent
      return ChartData(getMonthName(index + 1), rainPercentage);
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
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

  Widget buildDailyTab() {
    final double chartHeight = MediaQuery.of(context).size.height / 2;

    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //Visitor
        GestureDetector(
          onTap: () {
            setState(() {
              visitorVisible = !visitorVisible;
            });
          },
          child: Container(
            height: 70,
            alignment: Alignment.centerLeft,
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
        //Button
        Visibility(
          visible: visitorVisible,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SwitchListTile(
              activeColor:
                  const Color.fromRGBO(38, 158, 38, 0.2), // Lighter green tone
              activeTrackColor: const Color.fromARGB(255, 40, 160, 40),
              title: Text(
                rainLineChart ? rainTextVisible : rainTextHidden,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              value: rainLineChart,
              onChanged: handleToggle,
            ),
          ),
        ),
        //Chart
        Visibility(
          visible: visitorVisible,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: chartHeight,
              child: SfCartesianChart(
                enableAxisAnimation: true,
                primaryXAxis: CategoryAxis(
                  desiredIntervals: 12,
                  axisLine: axisLine,
                  title: AxisTitle(text: 'Uhrzeit', textStyle: axisTitleStyle),
                  labelStyle: labelStyle,
                  visibleMaximum: 6,
                  isVisible: true,
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'Anzahl', textStyle: axisTitleStyle),
                  anchorRangeToVisiblePoints: false,
                  majorTickLines: majorTickLines,
                  axisLine: axisLine,
                  labelStyle: labelStyle,
                ),
                //Scroll enabling
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                series: <ChartSeries>[
                  ColumnSeries<ChartData, String>(
                    dataSource: visitorChartDaily,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    borderRadius: BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                    ),
                    gradient: LinearGradient(
                      colors: visitorGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (ChartData data, _) => '${data.y}',
                  ),
                  if (rainLineChart)
                    LineSeries<ChartData, String>(
                      dataSource: rainPercentChartDaily,
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
                ],
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    final ChartData chartData = data as ChartData;
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 90, 90, 90),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${chartData.y}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        //Temperature
        GestureDetector(
          onTap: () {
            setState(() {
              tempVisible = !tempVisible;
            });
          },
          child: Container(
            height: 70,
            alignment: Alignment.centerLeft,
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
                    tempVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
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
        Visibility(
          visible: tempVisible,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: chartHeight,
              child: SfCartesianChart(
                enableAxisAnimation: true,
                primaryXAxis: CategoryAxis(
                  title: AxisTitle(text: 'Uhrzeit', textStyle: axisTitleStyle),
                  desiredIntervals: 12,
                  crossesAt: 0,
                  placeLabelsNearAxisLine: false,
                  axisLine: axisLine,
                  labelStyle: labelStyle,
                  visibleMaximum: 8,
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}°C',
                  anchorRangeToVisiblePoints: false,
                  majorTickLines: majorTickLines,
                  axisLine: axisLine,
                  labelStyle: labelStyle,
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                series: <ColumnSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    dataSource: tempChartDaily,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    borderRadius: BorderRadius.circular(radius.x),
                    gradient: LinearGradient(
                      colors: temperatureGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (ChartData data, _) => '${data.y}',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    final ChartData chartData = data as ChartData;
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 90, 90, 90),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${chartData.y}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        //Air Humidity
        GestureDetector(
          onTap: () {
            setState(() {
              airVisible = !airVisible;
            });
          },
          child: Container(
            height: 70,
            alignment: Alignment.centerLeft,
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
                    airVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
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
        Visibility(
          visible: airVisible,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: chartHeight,
              child: SfCartesianChart(
                enableAxisAnimation: true,
                primaryXAxis: CategoryAxis(
                  desiredIntervals: 12,
                  axisLine: axisLine,
                  title: AxisTitle(text: 'Uhrzeit', textStyle: axisTitleStyle),
                  labelStyle: labelStyle,
                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                  visibleMaximum: 8,
                  isVisible: true,
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}%',
                  anchorRangeToVisiblePoints: false,
                  majorTickLines: majorTickLines,
                  axisLine: axisLine,
                  labelStyle: labelStyle,
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                series: <ColumnSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    dataSource: airHumidityChartDaily,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    borderRadius: BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                    ),
                    gradient: LinearGradient(
                      colors: airHumidityGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (ChartData data, _) => '${data.y}',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                    enable: true,
                    builder: (dynamic data, dynamic point, dynamic series,
                        int pointIndex, int seriesIndex) {
                      final ChartData chartData = data as ChartData;
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 90, 90, 90),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${chartData.y}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildWeeklyTab() {
    final double chartHeight = MediaQuery.of(context).size.height / 2;

    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //Visitor
        GestureDetector(
          onTap: () {
            setState(() {
              visitorVisible = !visitorVisible;
            });
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              height: 70,
              alignment: Alignment.centerLeft,
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
        ),
        //Button
        Visibility(
          visible: visitorVisible,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SwitchListTile(
              activeColor:
                  const Color.fromRGBO(38, 158, 38, 0.2), // Lighter green tone
              activeTrackColor: const Color.fromARGB(255, 40, 160, 40),
              title: Text(
                rainLineChart ? rainTextVisible : rainTextHidden,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              value: rainLineChart2,
              onChanged: handleToggle2,
            ),
          ),
        ),
        //Visitor
        Visibility(
          visible: visitorVisible,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: chartHeight,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                  axisLine: axisLine,
                  labelStyle: labelStyle,
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'Anzahl', textStyle: axisTitleStyle),
                  majorTickLines: majorTickLines,
                  axisLine: axisLine,
                  labelStyle: labelStyle,
                ),
                series: <ChartSeries>[
                  ColumnSeries<ChartData, String>(
                    dataSource: visitorChartWeekly,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    borderRadius: BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                    ),
                    gradient: LinearGradient(
                      colors: visitorGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (ChartData data, _) => '${data.y}',
                  ),
                  if (rainLineChart2)
                    LineSeries<ChartData, String>(
                      dataSource: rainPercentChartWeekly,
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
                ],
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    final ChartData chartData = data as ChartData;
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 90, 90, 90),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${chartData.y}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        //Temperature
        GestureDetector(
          onTap: () {
            setState(() {
              tempVisible = !tempVisible;
            });
          },
          child: Container(
            height: 70,
            alignment: Alignment.centerLeft,
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
                    tempVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
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
        Visibility(
          visible: tempVisible,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: chartHeight,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  crossesAt: 0,
                  placeLabelsNearAxisLine: false,
                  axisLine: axisLine,
                  labelStyle: labelStyle,
                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}°C',
                  majorTickLines: majorTickLines,
                  axisLine: axisLine,
                  labelStyle: labelStyle,
                ),
                series: <ColumnSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    dataSource: tempChartWeekly,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    borderRadius: BorderRadius.circular(radius.x),
                    gradient: LinearGradient(
                      colors: temperatureGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (ChartData data, _) => '${data.y}',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    final ChartData chartData = data as ChartData;
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 90, 90, 90),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${chartData.y}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        //Air Humidity
        GestureDetector(
          onTap: () {
            setState(() {
              airVisible = !airVisible;
            });
          },
          child: Container(
            height: 70,
            alignment: Alignment.centerLeft,
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
                    airVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
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
        Visibility(
          visible: airVisible,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: chartHeight,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  axisLine: axisLine,
                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                  labelStyle: labelStyle,
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}%',
                  majorTickLines: majorTickLines,
                  axisLine: axisLine,
                  labelStyle: labelStyle,
                ),
                series: <ColumnSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    dataSource: airHumidityChartWeekly,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    borderRadius: BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                    ),
                    gradient: LinearGradient(
                      colors: airHumidityGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (ChartData data, _) => '${data.y}',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                    enable: true,
                    builder: (dynamic data, dynamic point, dynamic series,
                        int pointIndex, int seriesIndex) {
                      final ChartData chartData = data as ChartData;
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 90, 90, 90),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${chartData.y}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildMonthlyTab() {
    final double chartHeight = MediaQuery.of(context).size.height / 2;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Visitor
          GestureDetector(
            onTap: () {
              setState(() {
                visitorVisible = !visitorVisible;
              });
            },
            child: Container(
              height: 70,
              alignment: Alignment.centerLeft,
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
          //Button
          Visibility(
            visible: visitorVisible,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: SwitchListTile(
                activeColor: const Color.fromRGBO(
                    38, 158, 38, 0.2), // Lighter green tone
                activeTrackColor: const Color.fromARGB(255, 40, 160, 40),
                title: Text(
                  rainLineChart ? rainTextVisible : rainTextHidden,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                value: rainLineChart2,
                onChanged: handleToggle2,
              ),
            ),
          ),
          //Chart
          Visibility(
            visible: visitorVisible,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: chartHeight,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                    axisLine: axisLine,
                    labelStyle: labelStyle,
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(
                        text: 'Anzahl',
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.w700)),
                    majorTickLines: const MajorTickLines(
                        size: 6, width: 1.5, color: Colors.black),
                    axisLine: const AxisLine(color: Colors.black, width: 1),
                    labelStyle:
                        const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  series: <ChartSeries>[
                    ColumnSeries<ChartData, String>(
                      dataSource: visitorChartMonthly,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      borderRadius: BorderRadius.only(
                        topLeft: radius,
                        topRight: radius,
                      ),
                      gradient: LinearGradient(
                        colors: visitorGradient,
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      dataLabelMapper: (ChartData data, _) => '${data.y}',
                    ),
                    if (rainLineChart2)
                      LineSeries<ChartData, String>(
                        dataSource: rainPercentChartMonthly,
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
                  ],
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    builder: (dynamic data, dynamic point, dynamic series,
                        int pointIndex, int seriesIndex) {
                      final ChartData chartData = data as ChartData;
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 90, 90, 90),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${chartData.y}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          //Temperature
          GestureDetector(
            onTap: () {
              setState(() {
                tempVisible = !tempVisible;
              });
            },
            child: Container(
              height: 70,
              alignment: Alignment.centerLeft,
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
                      tempVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
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
          Visibility(
            visible: tempVisible,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                height: chartHeight,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    axisLine: axisLine,
                    labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                    labelStyle: labelStyle,
                    labelRotation: -10,
                    crossesAt: 0,
                    placeLabelsNearAxisLine: false,
                  ),
                  primaryYAxis: NumericAxis(
                    labelFormat: '{value}°C',
                    majorTickLines: majorTickLines,
                    axisLine: axisLine,
                    labelStyle: labelStyle,
                  ),
                  series: <ColumnSeries<ChartData, String>>[
                    ColumnSeries<ChartData, String>(
                      dataSource: tempChartMonthly,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      borderRadius: BorderRadius.circular(radius.x),
                      gradient: LinearGradient(
                        colors: temperatureGradient,
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      dataLabelMapper: (ChartData data, _) => '${data.y}',
                    ),
                  ],
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    builder: (dynamic data, dynamic point, dynamic series,
                        int pointIndex, int seriesIndex) {
                      final ChartData chartData = data as ChartData;
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 90, 90, 90),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${chartData.y}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          //Air Humidity
          GestureDetector(
            onTap: () {
              setState(() {
                airVisible = !airVisible;
              });
            },
            child: Container(
              height: 70,
              alignment: Alignment.centerLeft,
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
                      airVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
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
          Visibility(
            visible: airVisible,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: chartHeight,
                width: MediaQuery.of(context).size.width / 1.15,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    axisLine: axisLine,
                    labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                    labelStyle: labelStyle,
                  ),
                  primaryYAxis: NumericAxis(
                    labelFormat: '{value}%',
                    majorTickLines: majorTickLines,
                    axisLine: axisLine,
                    labelRotation: -90,
                    labelStyle: labelStyle,
                  ),
                  series: <ColumnSeries<ChartData, String>>[
                    ColumnSeries<ChartData, String>(
                      dataSource: airHumidityChartMonthly,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      borderRadius: BorderRadius.only(
                        topLeft: radius,
                        topRight: radius,
                      ),
                      gradient: LinearGradient(
                        colors: airHumidityGradient,
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      dataLabelMapper: (ChartData data, _) => '${data.y}',
                    ),
                  ],
                  tooltipBehavior: TooltipBehavior(
                      enable: true,
                      builder: (dynamic data, dynamic point, dynamic series,
                          int pointIndex, int seriesIndex) {
                        final ChartData chartData = data as ChartData;
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 90, 90, 90),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${chartData.y}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildYearlyTab() {
    final double chartHeight = MediaQuery.of(context).size.height / 2;

    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //Visitor
        GestureDetector(
          onTap: () {
            setState(() {
              visitorVisible = !visitorVisible;
            });
          },
          child: Container(
            height: 70,
            alignment: Alignment.centerLeft,
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
        //Button
        Visibility(
          visible: visitorVisible,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SwitchListTile(
              activeColor:
                  const Color.fromRGBO(38, 158, 38, 0.2), // Lighter green tone
              activeTrackColor: const Color.fromARGB(255, 40, 160, 40),
              title: Text(
                rainLineChart ? rainTextVisible : rainTextHidden,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              value: rainLineChart2,
              onChanged: handleToggle2,
            ),
          ),
        ),
        //Chart
        Visibility(
          visible: visitorVisible,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: chartHeight,
              child: SfCartesianChart(
                enableAxisAnimation: true,
                primaryXAxis: CategoryAxis(
                  desiredIntervals: 12,
                  axisLine: axisLine,
                  labelStyle: labelStyle,
                  labelIntersectAction: AxisLabelIntersectAction.wrap,
                  visibleMaximum: 6,
                  isVisible: true,
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'Anzahl', textStyle: axisTitleStyle),
                  anchorRangeToVisiblePoints: false,
                  majorTickLines: majorTickLines,
                  axisLine: axisLine,
                  labelStyle: labelStyle,
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                series: <ChartSeries>[
                  ColumnSeries<ChartData, String>(
                    dataSource: visitorChartYearly,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    borderRadius: BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                    ),
                    gradient: LinearGradient(
                      colors: visitorGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (ChartData data, _) => '${data.y}',
                  ),
                  if (rainLineChart2)
                    LineSeries<ChartData, String>(
                      dataSource: rainPercentChartYearly,
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
                ],
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    final ChartData chartData = data as ChartData;
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 90, 90, 90),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${chartData.y}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        //Temperature
        GestureDetector(
          onTap: () {
            setState(() {
              tempVisible = !tempVisible;
            });
          },
          child: Container(
            height: 70,
            alignment: Alignment.centerLeft,
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
                    tempVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
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
        Visibility(
          visible: tempVisible,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: chartHeight,
              child: SfCartesianChart(
                enableAxisAnimation: true,
                primaryXAxis: CategoryAxis(
                  desiredIntervals: 12,
                  crossesAt: 0,
                  placeLabelsNearAxisLine: false,
                  axisLine: axisLine,
                  labelStyle: labelStyle,
                  visibleMaximum: 6,
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}°C',
                  anchorRangeToVisiblePoints: false,
                  majorTickLines: majorTickLines,
                  axisLine: axisLine,
                  labelStyle: labelStyle,
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                series: <ColumnSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    dataSource: tempChartYearly,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    borderRadius: BorderRadius.circular(radius.x),
                    gradient: LinearGradient(
                      colors: temperatureGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (ChartData data, _) => '${data.y}',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    final ChartData chartData = data as ChartData;
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 90, 90, 90),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${chartData.y}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        //Air Humidity
        GestureDetector(
          onTap: () {
            setState(() {
              airVisible = !airVisible;
            });
          },
          child: Container(
            height: 70,
            alignment: Alignment.centerLeft,
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
                    airVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
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
        Visibility(
          visible: airVisible,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: chartHeight,
              child: SfCartesianChart(
                enableAxisAnimation: true,
                primaryXAxis: CategoryAxis(
                  desiredIntervals: 12,
                  axisLine: axisLine,
                  labelStyle: labelStyle,
                  labelIntersectAction: AxisLabelIntersectAction.wrap,
                  visibleMaximum: 6,
                  isVisible: true,
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}%',
                  anchorRangeToVisiblePoints: false,
                  majorTickLines: majorTickLines,
                  axisLine: axisLine,
                  labelStyle: labelStyle,
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                series: <ColumnSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    dataSource: airHumidityChartYearly,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    borderRadius: BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                    ),
                    gradient: LinearGradient(
                      colors: airHumidityGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (ChartData data, _) => '${data.y}',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                    enable: true,
                    builder: (dynamic data, dynamic point, dynamic series,
                        int pointIndex, int seriesIndex) {
                      final ChartData chartData = data as ChartData;
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 90, 90, 90),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${chartData.y}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class ChartData {
  final String x;
  double y;

  ChartData(this.x, this.y);
}
