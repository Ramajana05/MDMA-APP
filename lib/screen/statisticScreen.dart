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

  var radius = const Radius.circular(20);

  late List<_ChartData> visitorChartDaily;
  late List<_ChartData> tempChartDaily;
  late List<_ChartData> airChartDaily;

  late List<_ChartData> visitorChartWeekly;
  late List<_ChartData> tempChartWeekly;
  late List<_ChartData> airChartWeekly;

  late List<_ChartData> visitorChartMonthly;
  late List<_ChartData> tempChartMonthly;
  late List<_ChartData> airChartMonthly;

  late List<_ChartData> visitorChartYearly;
  late List<_ChartData> tempChartYearly;
  late List<_ChartData> airChartYearly;

  bool visitorVisible = true;
  bool tempVisible = true;
  bool airVisible = true;

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

  TabController? _tabController;

  String getWeekOfPreviousMonth(int weekNumber) {
    final now = DateTime.now();
    final firstDayOfPreviousMonth = DateTime(now.year, now.month - 1, 1);

    final weekStartDate = firstDayOfPreviousMonth
        .subtract(Duration(days: firstDayOfPreviousMonth.weekday - 1))
        .add(Duration(days: (weekNumber - 1) * 7));
    final weekEndDate = weekStartDate.add(const Duration(days: 6));

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
    final getHour = [
      '',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '00',
      '01',
      '02',
      '03',
      '04',
    ];

    return getHour[hour];
  }

  String getWeekday(int day) {
    final getWeekday = [
      '',
      'Mo',
      'Di',
      'Mi',
      'Do',
      'Fr',
      'Sa',
      'So',
    ];

    return getWeekday[day];
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    visitorChartDaily = [
      _ChartData(getHours(5), 5),
      _ChartData(getHours(6), 4),
      _ChartData(getHours(7), 6),
      _ChartData(getHours(8), 7),
      _ChartData(getHours(9), 9),
      _ChartData(getHours(10), 12),
      _ChartData(getHours(11), 10),
      _ChartData(getHours(12), 17),
      _ChartData(getHours(13), 14),
      _ChartData(getHours(14), 21),
      _ChartData(getHours(15), 19),
      _ChartData(getHours(16), 19),
      _ChartData(getHours(17), 11),
      _ChartData(getHours(18), 14),
      _ChartData(getHours(19), 10),
      _ChartData(getHours(20), 10),
      _ChartData(getHours(21), 1),
      _ChartData(getHours(22), 8),
      _ChartData(getHours(23), 10),
      _ChartData(getHours(0), 1),
      _ChartData(getHours(1), 2),
      _ChartData(getHours(2), 2),
      _ChartData(getHours(3), 5),
      _ChartData(getHours(4), 3),
    ];

    visitorChartWeekly = [
      _ChartData(getWeekday(1), 100),
      _ChartData(getWeekday(2), 80),
      _ChartData(getWeekday(3), 120),
      _ChartData(getWeekday(4), 90),
      _ChartData(getWeekday(5), 150),
      _ChartData(getWeekday(6), 200),
      _ChartData(getWeekday(7), 180),
    ];

    visitorChartMonthly = [
      _ChartData(getWeekOfPreviousMonth(1), 152),
      _ChartData(getWeekOfPreviousMonth(2), 258),
      _ChartData(getWeekOfPreviousMonth(3), 120),
      _ChartData(getWeekOfPreviousMonth(4), 230),
    ];

    visitorChartYearly = [
      _ChartData(getMonthName(1), 50),
      _ChartData(getMonthName(2), 70),
      _ChartData(getMonthName(3), 40),
      _ChartData(getMonthName(4), 60),
      _ChartData(getMonthName(5), 80),
      _ChartData(getMonthName(6), 65),
      _ChartData(getMonthName(7), 75),
      _ChartData(getMonthName(8), 55),
      _ChartData(getMonthName(9), 45),
      _ChartData(getMonthName(10), 70),
      _ChartData(getMonthName(11), 90),
      _ChartData(getMonthName(12), 60),
    ];

    tempChartDaily = [
      _ChartData(getHours(5), -5),
      _ChartData(getHours(6), 4),
      _ChartData(getHours(7), -6),
      _ChartData(getHours(8), 7),
      _ChartData(getHours(9), -9),
      _ChartData(getHours(10), 12),
      _ChartData(getHours(11), 10),
      _ChartData(getHours(12), 17),
      _ChartData(getHours(13), 14),
      _ChartData(getHours(14), 21),
      _ChartData(getHours(15), 19),
      _ChartData(getHours(16), 19),
      _ChartData(getHours(17), 11),
      _ChartData(getHours(18), 14),
      _ChartData(getHours(19), 10),
      _ChartData(getHours(20), -10),
      _ChartData(getHours(21), 1),
      _ChartData(getHours(22), 8),
      _ChartData(getHours(23), 10),
      _ChartData(getHours(0), 1),
      _ChartData(getHours(1), -2),
      _ChartData(getHours(2), 2),
      _ChartData(getHours(3), -5),
      _ChartData(getHours(4), 3),
    ];

    tempChartWeekly = [
      _ChartData(getWeekday(1), -8),
      _ChartData(getWeekday(2), -2),
      _ChartData(getWeekday(3), 10),
      _ChartData(getWeekday(4), 19),
      _ChartData(getWeekday(5), 5),
      _ChartData(getWeekday(6), 28),
      _ChartData(getWeekday(7), 2),
    ];

    tempChartMonthly = [
      _ChartData(getWeekOfPreviousMonth(1), 20),
      _ChartData(getWeekOfPreviousMonth(2), -8),
      _ChartData(getWeekOfPreviousMonth(3), 12),
      _ChartData(getWeekOfPreviousMonth(4), -6),
    ];

    tempChartYearly = [
      _ChartData(getMonthName(1), 15),
      _ChartData(getMonthName(2), -5),
      _ChartData(getMonthName(3), -18),
      _ChartData(getMonthName(4), 22),
      _ChartData(getMonthName(5), 10),
      _ChartData(getMonthName(6), 28),
      _ChartData(getMonthName(7), 30),
      _ChartData(getMonthName(8), 25),
      _ChartData(getMonthName(9), 20),
      _ChartData(getMonthName(10), 8),
      _ChartData(getMonthName(11), -2),
      _ChartData(getMonthName(12), 12),
    ];

    airChartDaily = [
      _ChartData(getHours(5), 20),
      _ChartData(getHours(6), 31),
      _ChartData(getHours(7), 35),
      _ChartData(getHours(8), 19),
      _ChartData(getHours(9), 28),
      _ChartData(getHours(10), 34),
      _ChartData(getHours(11), 10),
      _ChartData(getHours(12), 17),
      _ChartData(getHours(13), 14),
      _ChartData(getHours(14), 21),
      _ChartData(getHours(15), 19),
      _ChartData(getHours(16), 19),
      _ChartData(getHours(17), 11),
      _ChartData(getHours(18), 14),
      _ChartData(getHours(19), 10),
      _ChartData(getHours(20), 10),
      _ChartData(getHours(21), 25),
      _ChartData(getHours(22), 26),
      _ChartData(getHours(23), 10),
      _ChartData(getHours(0), 26),
      _ChartData(getHours(1), 17),
      _ChartData(getHours(2), 15),
      _ChartData(getHours(3), 30),
      _ChartData(getHours(4), 24),
    ];

    airChartWeekly = [
      _ChartData(getWeekday(1), 40),
      _ChartData(getWeekday(2), 42),
      _ChartData(getWeekday(3), 60),
      _ChartData(getWeekday(4), 40),
      _ChartData(getWeekday(5), 70),
      _ChartData(getWeekday(6), 42),
      _ChartData(getWeekday(7), 71),
    ];

    airChartMonthly = [
      _ChartData(getWeekOfPreviousMonth(1), 70),
      _ChartData(getWeekOfPreviousMonth(2), 40),
      _ChartData(getWeekOfPreviousMonth(3), 42),
      _ChartData(getWeekOfPreviousMonth(4), 85),
    ];

    airChartYearly = [
      _ChartData(getMonthName(1), 40),
      _ChartData(getMonthName(2), 60),
      _ChartData(getMonthName(3), 42),
      _ChartData(getMonthName(4), 55),
      _ChartData(getMonthName(5), 60),
      _ChartData(getMonthName(6), 70),
      _ChartData(getMonthName(7), 70),
      _ChartData(getMonthName(8), 42),
      _ChartData(getMonthName(9), 40),
      _ChartData(getMonthName(10), 70),
      _ChartData(getMonthName(11), 42),
      _ChartData(getMonthName(12), 60),
    ];
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  int _selectedTabIndex = 0;

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
                  axisLine: const AxisLine(
                    color: Colors.black,
                    width: 1.5,
                  ),
                  title: AxisTitle(
                      text: 'Uhrzeit',
                      textStyle: const TextStyle(fontWeight: FontWeight.w700)),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                  labelIntersectAction: AxisLabelIntersectAction.wrap,
                  visibleMaximum: 8,
                  isVisible: true,
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(
                      text: 'Anzahl',
                      textStyle: const TextStyle(fontWeight: FontWeight.w700)),
                  anchorRangeToVisiblePoints: false,
                  majorTickLines: const MajorTickLines(
                      size: 6, width: 2, color: Colors.black),
                  axisLine: const AxisLine(color: Colors.black, width: 1),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                series: <ColumnSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: visitorChartDaily,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    borderRadius: BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                    ),
                    gradient: LinearGradient(
                      colors: visitorGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (_ChartData data, _) => '${data.y}',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    final _ChartData chartData = data as _ChartData;
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
                  title: AxisTitle(
                      text: 'Uhrzeit',
                      textStyle: const TextStyle(fontWeight: FontWeight.w700)),
                  desiredIntervals: 12,
                  crossesAt: 0,
                  placeLabelsNearAxisLine: false,
                  axisLine: const AxisLine(
                    color: Colors.black,
                    width: 1.5,
                  ),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                  visibleMaximum: 8,
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}°C',
                  anchorRangeToVisiblePoints: false,
                  majorTickLines: const MajorTickLines(
                      size: 6, width: 2, color: Colors.black),
                  axisLine: const AxisLine(color: Colors.black, width: 1),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                series: <ColumnSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: tempChartDaily,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    borderRadius: BorderRadius.circular(radius.x),
                    gradient: LinearGradient(
                      colors: temperatureGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (_ChartData data, _) => '${data.y}',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    final _ChartData chartData = data as _ChartData;
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
                  axisLine: const AxisLine(
                    color: Colors.black,
                    width: 1.5,
                  ),
                  title: AxisTitle(
                      text: 'Uhrzeit',
                      textStyle: const TextStyle(fontWeight: FontWeight.w700)),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                  labelIntersectAction: AxisLabelIntersectAction.wrap,
                  visibleMaximum: 8,
                  isVisible: true,
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}%',
                  anchorRangeToVisiblePoints: false,
                  majorTickLines: const MajorTickLines(
                      size: 6, width: 2, color: Colors.black),
                  axisLine: const AxisLine(color: Colors.black, width: 1),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                series: <ColumnSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: airChartDaily,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    borderRadius: BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                    ),
                    gradient: LinearGradient(
                      colors: airHumidityGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (_ChartData data, _) => '${data.y}',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                    enable: true,
                    builder: (dynamic data, dynamic point, dynamic series,
                        int pointIndex, int seriesIndex) {
                      final _ChartData chartData = data as _ChartData;
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
        Visibility(
          visible: visitorVisible,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: chartHeight,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  axisLine: const AxisLine(
                    color: Colors.black,
                    width: 1.5,
                  ),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(
                      text: 'Anzahl',
                      textStyle: const TextStyle(fontWeight: FontWeight.w700)),
                  majorTickLines: const MajorTickLines(
                      size: 6, width: 1.5, color: Colors.black),
                  axisLine: const AxisLine(color: Colors.black, width: 1),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                ),
                series: <ColumnSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: visitorChartWeekly,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    borderRadius: BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                    ),
                    gradient: LinearGradient(
                      colors: visitorGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (_ChartData data, _) => '${data.y}',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    final _ChartData chartData = data as _ChartData;
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
                  axisLine: const AxisLine(
                    color: Colors.black,
                    width: 1.5,
                  ),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}°C',
                  majorTickLines: const MajorTickLines(
                      size: 6, width: 2, color: Colors.black),
                  axisLine: const AxisLine(color: Colors.black, width: 1),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                ),
                series: <ColumnSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: tempChartWeekly,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    borderRadius: BorderRadius.circular(radius.x),
                    gradient: LinearGradient(
                      colors: temperatureGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (_ChartData data, _) => '${data.y}',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    final _ChartData chartData = data as _ChartData;
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
                  axisLine: const AxisLine(
                    color: Colors.black,
                    width: 1.5,
                  ),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}%',
                  majorTickLines: const MajorTickLines(
                      size: 6, width: 2, color: Colors.black),
                  axisLine: const AxisLine(color: Colors.black, width: 1),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                ),
                series: <ColumnSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: airChartWeekly,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    borderRadius: BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(72, 132, 238, 1),
                        Color.fromRGBO(6, 188, 251, 1),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (_ChartData data, _) => '${data.y}',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                    enable: true,
                    builder: (dynamic data, dynamic point, dynamic series,
                        int pointIndex, int seriesIndex) {
                      final _ChartData chartData = data as _ChartData;
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
          Visibility(
            visible: visitorVisible,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: chartHeight,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                    axisLine: const AxisLine(
                      color: Colors.black,
                      width: 1.5,
                    ),
                    labelStyle:
                        const TextStyle(fontSize: 14, color: Colors.black),
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
                  series: <ColumnSeries<_ChartData, String>>[
                    ColumnSeries<_ChartData, String>(
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      dataSource: visitorChartMonthly,
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                      borderRadius: BorderRadius.only(
                        topLeft: radius,
                        topRight: radius,
                      ),
                      gradient: LinearGradient(
                        colors: visitorGradient,
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ],
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    builder: (dynamic data, dynamic point, dynamic series,
                        int pointIndex, int seriesIndex) {
                      final _ChartData chartData = data as _ChartData;
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
                    axisLine: const AxisLine(
                      color: Colors.black,
                      width: 1.5,
                    ),
                    labelStyle:
                        const TextStyle(fontSize: 14, color: Colors.black),
                    labelRotation: -10,
                    crossesAt: 0,
                    placeLabelsNearAxisLine: false,
                  ),
                  primaryYAxis: NumericAxis(
                    labelFormat: '{value}°C',
                    majorTickLines: const MajorTickLines(
                        size: 6, width: 2, color: Colors.black),
                    axisLine: const AxisLine(color: Colors.black, width: 1),
                    labelStyle:
                        const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  series: <ColumnSeries<_ChartData, String>>[
                    ColumnSeries<_ChartData, String>(
                      dataSource: tempChartMonthly,
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                      borderRadius: BorderRadius.circular(radius.x),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.red,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      dataLabelMapper: (_ChartData data, _) => '${data.y}',
                    ),
                  ],
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    builder: (dynamic data, dynamic point, dynamic series,
                        int pointIndex, int seriesIndex) {
                      final _ChartData chartData = data as _ChartData;
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
                    axisLine: const AxisLine(
                      color: Colors.black,
                      width: 1.5,
                    ),
                    labelRotation: -10,
                    labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                    labelStyle:
                        const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  primaryYAxis: NumericAxis(
                    labelFormat: '{value}%',
                    majorTickLines: const MajorTickLines(
                        size: 6, width: 2, color: Colors.black),
                    axisLine: const AxisLine(color: Colors.black, width: 1),
                    labelRotation: -90,
                    labelStyle:
                        const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  series: <ColumnSeries<_ChartData, String>>[
                    ColumnSeries<_ChartData, String>(
                      dataSource: airChartMonthly,
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                      borderRadius: BorderRadius.only(
                        topLeft: radius,
                        topRight: radius,
                      ),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(72, 132, 238, 1),
                          Color.fromRGBO(6, 188, 251, 1),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      dataLabelMapper: (_ChartData data, _) => '${data.y}',
                    ),
                  ],
                  tooltipBehavior: TooltipBehavior(
                      enable: true,
                      builder: (dynamic data, dynamic point, dynamic series,
                          int pointIndex, int seriesIndex) {
                        final _ChartData chartData = data as _ChartData;
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
                  axisLine: const AxisLine(
                    color: Colors.black,
                    width: 1.5,
                  ),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                  labelIntersectAction: AxisLabelIntersectAction.wrap,
                  visibleMaximum: 8,
                  isVisible: true,
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(
                      text: 'Anzahl',
                      textStyle: const TextStyle(fontWeight: FontWeight.w700)),
                  anchorRangeToVisiblePoints: false,
                  majorTickLines: const MajorTickLines(
                      size: 6, width: 2, color: Colors.black),
                  axisLine: const AxisLine(color: Colors.black, width: 1),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                series: <ColumnSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: visitorChartYearly,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    borderRadius: BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                    ),
                    gradient: LinearGradient(
                      colors: visitorGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (_ChartData data, _) => '${data.y}',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    final _ChartData chartData = data as _ChartData;
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
                  axisLine: const AxisLine(
                    color: Colors.black,
                    width: 1.5,
                  ),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                  visibleMaximum: 8,
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}°C',
                  anchorRangeToVisiblePoints: false,
                  majorTickLines: const MajorTickLines(
                      size: 6, width: 2, color: Colors.black),
                  axisLine: const AxisLine(color: Colors.black, width: 1),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                series: <ColumnSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: tempChartYearly,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    borderRadius: BorderRadius.circular(radius.x),
                    gradient: LinearGradient(
                      colors: temperatureGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (_ChartData data, _) => '${data.y}',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    final _ChartData chartData = data as _ChartData;
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
                  axisLine: const AxisLine(
                    color: Colors.black,
                    width: 1.5,
                  ),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                  labelIntersectAction: AxisLabelIntersectAction.wrap,
                  visibleMaximum: 8,
                  isVisible: true,
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}%',
                  anchorRangeToVisiblePoints: false,
                  majorTickLines: const MajorTickLines(
                      size: 6, width: 2, color: Colors.black),
                  axisLine: const AxisLine(color: Colors.black, width: 1),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                series: <ColumnSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: airChartYearly,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    borderRadius: BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                    ),
                    gradient: LinearGradient(
                      colors: airHumidityGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    dataLabelMapper: (_ChartData data, _) => '${data.y}',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                    enable: true,
                    builder: (dynamic data, dynamic point, dynamic series,
                        int pointIndex, int seriesIndex) {
                      final _ChartData chartData = data as _ChartData;
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

class _ChartData {
  final String x;
  final double y;

  _ChartData(this.x, this.y);
}
