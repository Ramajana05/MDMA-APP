import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../widget/sidePanelWidget.dart';
import '../widget/topNavBar.dart';

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
  late List<_ChartData> visitorChartWeekly;
  late List<_ChartData> tempChartDaily;
  late List<_ChartData> tempChartWeekly;
  late List<_ChartData> airChartDaily;
  late List<_ChartData> airChartWeekly;

  late List<_ChartData> visitorChartMonthly;
  late List<_ChartData> tempChartMonthly;
  late List<_ChartData> airChartMonthly;

  bool visitorVisible = true;
  bool tempVisible = false;
  bool airVisible = false;
  TabController? _tabController;

  String getWeekOfPreviousMonth(int weekNumber) {
    final now = DateTime.now();
    final firstDayOfPreviousMonth = DateTime(now.year, now.month - 1, 1);

    final weekStartDate = firstDayOfPreviousMonth
        .subtract(Duration(days: firstDayOfPreviousMonth.weekday - 1))
        .add(Duration(days: (weekNumber - 1) * 7));
    final weekEndDate = weekStartDate.add(const Duration(days: 6));

    final weekStartDay = weekStartDate.day;
    final weekEndDay = weekEndDate.day;
    final monthName = _getGermanMonthName(firstDayOfPreviousMonth.month);

    return '$weekStartDay. $monthName - $weekEndDay. $monthName';
  }

  String _getGermanMonthName(int month) {
    final germanMonthNames = [
      '',
      'Januar',
      'Februar',
      'März',
      'April',
      'Mai',
      'Juni',
      'Juli',
      'August',
      'September',
      'Oktober',
      'November',
      'Dezember',
    ];

    if (month >= 1 && month <= 12) {
      return germanMonthNames[month];
    } else {
      throw ArgumentError('Invalid month number: $month');
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    visitorChartDaily = [
      _ChartData('Mo', 100),
      _ChartData('Di', 80),
      _ChartData('Mi', 120),
      _ChartData('Do', 90),
      _ChartData('Fr', 150),
      _ChartData('Sa', 200),
      _ChartData('So', 180),
    ];

    visitorChartWeekly = [
      _ChartData(getWeekOfPreviousMonth(1), 152),
      _ChartData(getWeekOfPreviousMonth(2), 258),
      _ChartData(getWeekOfPreviousMonth(3), 120),
      _ChartData(getWeekOfPreviousMonth(4), 230),
    ];

    visitorChartMonthly = [
      _ChartData(_getGermanMonthName(1), 50),
      _ChartData(_getGermanMonthName(2), 70),
      _ChartData(_getGermanMonthName(3), 40),
      _ChartData(_getGermanMonthName(4), 60),
      _ChartData(_getGermanMonthName(5), 80),
      _ChartData(_getGermanMonthName(6), 65),
      _ChartData(_getGermanMonthName(7), 75),
      _ChartData(_getGermanMonthName(8), 55),
      _ChartData(_getGermanMonthName(9), 45),
      _ChartData(_getGermanMonthName(10), 70),
      _ChartData(_getGermanMonthName(11), 90),
      _ChartData(_getGermanMonthName(12), 60),
    ];

    tempChartDaily = [
      _ChartData('Mo', -8),
      _ChartData('Di', -2),
      _ChartData('Mi', 10),
      _ChartData('Do', 19),
      _ChartData('Fr', 0),
      _ChartData('Sa', 28),
      _ChartData('Fr', 2),
    ];

    tempChartWeekly = [
      _ChartData(getWeekOfPreviousMonth(1), 20),
      _ChartData(getWeekOfPreviousMonth(2), -8),
      _ChartData(getWeekOfPreviousMonth(3), 12),
      _ChartData(getWeekOfPreviousMonth(4), -6),
    ];

    tempChartMonthly = [
      _ChartData(_getGermanMonthName(1), 15),
      _ChartData(_getGermanMonthName(2), -5),
      _ChartData(_getGermanMonthName(3), -18),
      _ChartData(_getGermanMonthName(4), 22),
      _ChartData(_getGermanMonthName(5), 10),
      _ChartData(_getGermanMonthName(6), 28),
      _ChartData(_getGermanMonthName(7), 30),
      _ChartData(_getGermanMonthName(8), 25),
      _ChartData(_getGermanMonthName(9), 20),
      _ChartData(_getGermanMonthName(10), 8),
      _ChartData(_getGermanMonthName(11), -2),
      _ChartData(_getGermanMonthName(12), 12),
    ];

    airChartDaily = [
      _ChartData('Mo', 200),
      _ChartData('Di', 180),
      _ChartData('Mi', 210),
      _ChartData('Do', 160),
      _ChartData('Fr', 240),
      _ChartData('Sa', 270),
      _ChartData('So', 230),
    ];

    airChartWeekly = [
      _ChartData(getWeekOfPreviousMonth(1), 213),
      _ChartData(getWeekOfPreviousMonth(2), 123),
      _ChartData(getWeekOfPreviousMonth(3), 150),
      _ChartData(getWeekOfPreviousMonth(4), 85),
    ];

    airChartMonthly = [
      _ChartData(_getGermanMonthName(1), 630),
      _ChartData(_getGermanMonthName(2), 615),
      _ChartData(_getGermanMonthName(3), 170),
      _ChartData(_getGermanMonthName(4), 55),
      _ChartData(_getGermanMonthName(5), 240),
      _ChartData(_getGermanMonthName(6), 320),
      _ChartData(_getGermanMonthName(7), 410),
      _ChartData(_getGermanMonthName(8), 380),
      _ChartData(_getGermanMonthName(9), 290),
      _ChartData(_getGermanMonthName(10), 180),
      _ChartData(_getGermanMonthName(11), 80),
      _ChartData(_getGermanMonthName(12), 620),
    ];
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
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: Column(
        children: [
          DefaultTabController(
            length: 3,
            child: Expanded(
              child: Column(
                children: [
                  const TabBar(
                    isScrollable: true,
                    labelColor: Colors.green,
                    indicatorColor: Colors.green,
                    unselectedLabelColor: Colors.black,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    tabs: [
                      Tab(
                        text: "Täglich",
                        iconMargin: EdgeInsets.only(left: 50),
                      ),
                      Tab(
                        text: "Wöchentlich",
                      ),
                      Tab(
                        text: "Monatlich",
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
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

  Widget buildDailyTab() {
    final double chartWidth = MediaQuery.of(context).size.width / 1.2;
    final double chartHeight = MediaQuery.of(context).size.height / 2;

    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        GestureDetector(
          onTap: () {
            setState(() {
              visitorVisible = !visitorVisible;
            });
          },
          child: Container(
            height: 40,
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
              width: chartWidth,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(),
                series: <ColumnSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: visitorChartDaily,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    borderRadius: BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.purpleAccent,
                        Colors.blue,
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
        GestureDetector(
          onTap: () {
            setState(() {
              tempVisible = !tempVisible;
            });
          },
          child: Container(
            height: 40,
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
              width: chartWidth,
              child: SfCartesianChart(
                primaryXAxis:
                    CategoryAxis(crossesAt: 0, placeLabelsNearAxisLine: false),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}°C',
                ),
                series: <ColumnSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: tempChartDaily,
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
        GestureDetector(
          onTap: () {
            setState(() {
              airVisible = !airVisible;
            });
          },
          child: Container(
            height: 40,
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
              width: chartWidth,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}%',
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

  Widget buildWeeklyTab() {
    final double chartWidth = MediaQuery.of(context).size.width / 1.2;
    final double chartHeight = MediaQuery.of(context).size.height / 2;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                visitorVisible = !visitorVisible;
              });
            },
            child: Container(
              height: 40,
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
                width: chartWidth,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                      labelIntersectAction:
                          AxisLabelIntersectAction.multipleRows),
                  primaryYAxis: NumericAxis(),
                  series: <ColumnSeries<_ChartData, String>>[
                    ColumnSeries<_ChartData, String>(
                      dataSource: visitorChartWeekly,
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                      borderRadius: BorderRadius.only(
                        topLeft: radius,
                        topRight: radius,
                      ),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.purpleAccent,
                          Colors.blue,
                        ],
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
          GestureDetector(
            onTap: () {
              setState(() {
                tempVisible = !tempVisible;
              });
            },
            child: Container(
              height: 40,
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
                width: chartWidth,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                      crossesAt: 0,
                      placeLabelsNearAxisLine: false,
                      labelIntersectAction:
                          AxisLabelIntersectAction.multipleRows,
                      labelRotation: 15),
                  primaryYAxis: NumericAxis(
                    labelFormat: '{value}°C',
                  ),
                  series: <ColumnSeries<_ChartData, String>>[
                    ColumnSeries<_ChartData, String>(
                      dataSource: tempChartWeekly,
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
          GestureDetector(
            onTap: () {
              setState(() {
                airVisible = !airVisible;
              });
            },
            child: Container(
              height: 40,
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
                width: chartWidth,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                  ),
                  primaryYAxis: NumericAxis(
                    labelFormat: '{value}%',
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
        ],
      ),
    );
  }

  Widget buildMonthlyTab() {
    final double chartWidth = MediaQuery.of(context).size.width / 1.2;
    final double chartHeight = MediaQuery.of(context).size.height / 2;

    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        GestureDetector(
          onTap: () {
            setState(() {
              visitorVisible = !visitorVisible;
            });
          },
          child: Container(
            height: 40,
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
              width: chartWidth,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                    labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                    labelRotation: 90),
                primaryYAxis: NumericAxis(
                  anchorRangeToVisiblePoints: true,
                ),
                series: <ColumnSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: visitorChartMonthly,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    borderRadius: BorderRadius.only(
                      topLeft: radius,
                      topRight: radius,
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.purpleAccent,
                        Colors.blue,
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
        GestureDetector(
          onTap: () {
            setState(() {
              tempVisible = !tempVisible;
            });
          },
          child: Container(
            height: 40,
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
              width: chartWidth,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                    labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                    crossesAt: 0,
                    placeLabelsNearAxisLine: false,
                    labelRotation: 90),
                primaryYAxis: NumericAxis(
                  anchorRangeToVisiblePoints: true,
                  labelFormat: '{value}°C',
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
        GestureDetector(
          onTap: () {
            setState(() {
              airVisible = !airVisible;
            });
          },
          child: Container(
            height: 40,
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
              width: chartWidth,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                    labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                    labelRotation: 90),
                primaryYAxis: NumericAxis(
                  anchorRangeToVisiblePoints: true,
                  labelFormat: '{value}%',
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
      ]),
    );
  }
}

class _ChartData {
  final String x;
  final double y;

  _ChartData(this.x, this.y);
}
