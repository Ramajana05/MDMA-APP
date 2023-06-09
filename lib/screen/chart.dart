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

  late List<_ChartData> visitorChartHourly;
  late List<_ChartData> visitorChartDaily;
  late List<_ChartData> visitorChartWeekly;
  late List<_ChartData> tempChartHourly;
  late List<_ChartData> tempChartDaily;
  late List<_ChartData> tempChartWeekly;
  late List<_ChartData> airChartHourly;
  late List<_ChartData> airChartDaily;
  late List<_ChartData> airChartWeekly;

  late List<_ChartData> visitorChartMonthly;
  late List<_ChartData> tempChartMonthly;
  late List<_ChartData> airChartMonthly;

  bool visitorVisible = true;
  bool tempVisible = true;
  bool airVisible = true;
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

    visitorChartHourly = [
      _ChartData('00:00', 1),
      _ChartData('02:00', 2),
      _ChartData('04:00', 3),
      _ChartData('06:00', 4),
      _ChartData('08:00', 7),
      _ChartData('10:00', 12),
      _ChartData('12:00', 17),
      _ChartData('14:00', 21),
      _ChartData('16:00', 19),
      _ChartData('18:00', 14),
      _ChartData('20:00', 10),
      _ChartData('22:00', 8),
    ];

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

    tempChartHourly = [
      _ChartData('00:00', 5),
      _ChartData('02:00', 8),
      _ChartData('04:00', 9),
      _ChartData('06:00', 10),
      _ChartData('08:00', 12),
      _ChartData('10:00', 15),
      _ChartData('12:00', 21),
      _ChartData('14:00', 26),
      _ChartData('16:00', 25),
      _ChartData('18:00', 15),
      _ChartData('20:00', 11),
      _ChartData('22:00', 7),
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

    airChartHourly = [
      _ChartData('00:00', 34),
      _ChartData('02:00', 34),
      _ChartData('04:00', 35),
      _ChartData('06:00', 38),
      _ChartData('08:00', 38),
      _ChartData('10:00', 42),
      _ChartData('12:00', 50),
      _ChartData('14:00', 49),
      _ChartData('16:00', 45),
      _ChartData('18:00', 44),
      _ChartData('20:00', 40),
      _ChartData('22:00', 34),
    ];

    airChartDaily = [
      _ChartData('Mo', 40),
      _ChartData('Di', 42),
      _ChartData('Mi', 60),
      _ChartData('Do', 40),
      _ChartData('Fr', 70),
      _ChartData('Sa', 42),
      _ChartData('So', 71),
    ];

    airChartWeekly = [
      _ChartData(getWeekOfPreviousMonth(1), 70),
      _ChartData(getWeekOfPreviousMonth(2), 42),
      _ChartData(getWeekOfPreviousMonth(3), 40),
      _ChartData(getWeekOfPreviousMonth(4), 85),
    ];

    airChartMonthly = [
      _ChartData(_getGermanMonthName(1), 40),
      _ChartData(_getGermanMonthName(2), 60),
      _ChartData(_getGermanMonthName(3), 42),
      _ChartData(_getGermanMonthName(4), 55),
      _ChartData(_getGermanMonthName(5), 60),
      _ChartData(_getGermanMonthName(6), 70),
      _ChartData(_getGermanMonthName(7), 70),
      _ChartData(_getGermanMonthName(8), 42),
      _ChartData(_getGermanMonthName(9), 40),
      _ChartData(_getGermanMonthName(10), 70),
      _ChartData(_getGermanMonthName(11), 42),
      _ChartData(_getGermanMonthName(12), 60),
    ];
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  int _selectedTabIndex = 0;

  void _updateSelectedTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
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
                  TabBarWidget(
                    tabTexts: ['Tag', 'Woche', 'Monat', 'Jahr'],
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
                        buildHourlyTab(),
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
            decoration: BoxDecoration(
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

  Widget buildHourlyTab() {
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
                    dataSource: visitorChartHourly,
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
                    dataSource: tempChartHourly,
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
                    dataSource: airChartHourly,
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
