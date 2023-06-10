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
  late List<ChartData> airHumidityMonthly;
  late List<ChartData> airChartYearly;

  late List<ChartData> rainPercentChartDaily;
  late List<ChartData> rainPercentChartWeekly;
  late List<ChartData> weatherDataMonthly;
  late List<ChartData> rainPercentChartYearly;

  bool visitorVisible = true;
  bool tempVisible = true;
  bool airVisible = true;
  bool rainLineChart = true;

  void handleToggle(bool value) {
    setState(() {
      rainLineChart = value;
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

  var labelStyle = const TextStyle(fontSize: 15, color: Colors.black);
  var axisLine = const AxisLine(color: Colors.black, width: 1.5);
  var majorTickLines =
      const MajorTickLines(size: 6, width: 2, color: Colors.black);
  var axisTitleStyle = const TextStyle(fontWeight: FontWeight.w700);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    visitorChartDaily = [
      ChartData(getHours(5), 120),
      ChartData(getHours(6), 135),
      ChartData(getHours(7), 150),
      ChartData(getHours(8), 165),
      ChartData(getHours(9), 180),
      ChartData(getHours(10), 195),
      ChartData(getHours(11), 210),
      ChartData(getHours(12), 225),
      ChartData(getHours(13), 240),
      ChartData(getHours(14), 225),
      ChartData(getHours(15), 210),
      ChartData(getHours(16), 195),
      ChartData(getHours(17), 180),
      ChartData(getHours(18), 165),
      ChartData(getHours(19), 150),
      ChartData(getHours(20), 135),
      ChartData(getHours(21), 120),
      ChartData(getHours(22), 105),
      ChartData(getHours(23), 90),
      ChartData(getHours(0), 75),
      ChartData(getHours(1), 60),
      ChartData(getHours(2), 45),
      ChartData(getHours(3), 30),
      ChartData(getHours(4), 15),
    ];

    visitorChartWeekly = [
      ChartData(getWeekday(1), 1000),
      ChartData(getWeekday(2), 950),
      ChartData(getWeekday(3), 900),
      ChartData(getWeekday(4), 850),
      ChartData(getWeekday(5), 800),
      ChartData(getWeekday(6), 750),
      ChartData(getWeekday(7), 700),
    ];

    visitorChartMonthly = [
      ChartData(getWeekOfPreviousMonth(1), 4000),
      ChartData(getWeekOfPreviousMonth(2), 4100),
      ChartData(getWeekOfPreviousMonth(3), 4200),
      ChartData(getWeekOfPreviousMonth(4), 4300),
    ];

    visitorChartYearly = [
      ChartData(getMonthName(1), 4500),
      ChartData(getMonthName(2), 4600),
      ChartData(getMonthName(3), 4700),
      ChartData(getMonthName(4), 4800),
      ChartData(getMonthName(5), 4900),
      ChartData(getMonthName(6), 5000),
      ChartData(getMonthName(7), 5100),
      ChartData(getMonthName(8), 5200),
      ChartData(getMonthName(9), 5300),
      ChartData(getMonthName(10), 5400),
      ChartData(getMonthName(11), 5500),
      ChartData(getMonthName(12), 5600),
    ];

    tempChartDaily = [
      ChartData(getHours(5), 10),
      ChartData(getHours(6), 12),
      ChartData(getHours(7), 15),
      ChartData(getHours(8), 18),
      ChartData(getHours(9), 20),
      ChartData(getHours(10), 22),
      ChartData(getHours(11), 24),
      ChartData(getHours(12), 26),
      ChartData(getHours(13), 24),
      ChartData(getHours(14), 22),
      ChartData(getHours(15), 20),
      ChartData(getHours(16), 18),
      ChartData(getHours(17), 15),
      ChartData(getHours(18), 12),
      ChartData(getHours(19), 10),
      ChartData(getHours(20), 8),
      ChartData(getHours(21), 6),
      ChartData(getHours(22), 4),
      ChartData(getHours(23), 2),
      ChartData(getHours(0), 5),
      ChartData(getHours(1), 2),
      ChartData(getHours(2), 4),
      ChartData(getHours(3), 6),
      ChartData(getHours(4), 8),
    ];

    tempChartWeekly = [
      ChartData(getWeekday(1), 15),
      ChartData(getWeekday(2), 16),
      ChartData(getWeekday(3), 18),
      ChartData(getWeekday(4), 20),
      ChartData(getWeekday(5), 22),
      ChartData(getWeekday(6), 24),
      ChartData(getWeekday(7), 16),
    ];

    tempChartMonthly = [
      ChartData(getWeekOfPreviousMonth(1), 15),
      ChartData(getWeekOfPreviousMonth(2), 13),
      ChartData(getWeekOfPreviousMonth(3), 11),
      ChartData(getWeekOfPreviousMonth(4), 12),
    ];

    tempChartYearly = [
      ChartData(getMonthName(1), -3),
      ChartData(getMonthName(2), -2),
      ChartData(getMonthName(3), 8),
      ChartData(getMonthName(4), 10),
      ChartData(getMonthName(5), 14),
      ChartData(getMonthName(6), 18),
      ChartData(getMonthName(7), 22),
      ChartData(getMonthName(8), 30),
      ChartData(getMonthName(9), 22),
      ChartData(getMonthName(10), 14),
      ChartData(getMonthName(11), 10),
      ChartData(getMonthName(12), 12),
    ];

    airHumidityChartDaily = [
      ChartData(getHours(5), 60),
      ChartData(getHours(6), 65),
      ChartData(getHours(7), 70),
      ChartData(getHours(8), 75),
      ChartData(getHours(9), 80),
      ChartData(getHours(10), 85),
      ChartData(getHours(11), 90),
      ChartData(getHours(12), 95),
      ChartData(getHours(13), 100),
      ChartData(getHours(14), 95),
      ChartData(getHours(15), 90),
      ChartData(getHours(16), 85),
      ChartData(getHours(17), 80),
      ChartData(getHours(18), 75),
      ChartData(getHours(19), 70),
      ChartData(getHours(20), 65),
      ChartData(getHours(21), 60),
      ChartData(getHours(22), 55),
      ChartData(getHours(23), 50),
      ChartData(getHours(0), 45),
      ChartData(getHours(1), 40),
      ChartData(getHours(2), 35),
      ChartData(getHours(3), 30),
      ChartData(getHours(4), 25),
    ];

    airHumidityChartWeekly = [
      ChartData(getWeekday(1), 30),
      ChartData(getWeekday(2), 28),
      ChartData(getWeekday(3), 26),
      ChartData(getWeekday(4), 24),
      ChartData(getWeekday(5), 22),
      ChartData(getWeekday(6), 20),
      ChartData(getWeekday(7), 18),
    ];

    airHumidityMonthly = [
      ChartData(getWeekOfPreviousMonth(1), 25),
      ChartData(getWeekOfPreviousMonth(2), 30),
      ChartData(getWeekOfPreviousMonth(3), 21),
      ChartData(getWeekOfPreviousMonth(4), 50),
    ];

    airChartYearly = [
      ChartData(getMonthName(1), 55),
      ChartData(getMonthName(2), 50),
      ChartData(getMonthName(3), 45),
      ChartData(getMonthName(4), 60),
      ChartData(getMonthName(5), 65),
      ChartData(getMonthName(6), 70),
      ChartData(getMonthName(7), 75),
      ChartData(getMonthName(8), 70),
      ChartData(getMonthName(9), 65),
      ChartData(getMonthName(10), 60),
      ChartData(getMonthName(11), 50),
      ChartData(getMonthName(12), 45),
    ];

    rainPercentChartDaily = [
      ChartData(getHours(5), 15),
      ChartData(getHours(6), 16),
      ChartData(getHours(7), 17),
      ChartData(getHours(8), 20),
      ChartData(getHours(9), 22),
      ChartData(getHours(10), 24),
      ChartData(getHours(11), 26),
      ChartData(getHours(12), 28),
      ChartData(getHours(13), 30),
      ChartData(getHours(14), 31),
      ChartData(getHours(15), 30),
      ChartData(getHours(16), 28),
      ChartData(getHours(17), 26),
      ChartData(getHours(18), 24),
      ChartData(getHours(19), 22),
      ChartData(getHours(20), 20),
      ChartData(getHours(21), 19),
      ChartData(getHours(22), 18),
      ChartData(getHours(23), 16),
      ChartData(getHours(0), 14),
      ChartData(getHours(1), 13),
      ChartData(getHours(2), 12),
      ChartData(getHours(3), 11),
      ChartData(getHours(4), 10),
    ];

    rainPercentChartWeekly = [
      ChartData(getWeekday(1), 22),
      ChartData(getWeekday(2), 23),
      ChartData(getWeekday(3), 25),
      ChartData(getWeekday(4), 26),
      ChartData(getWeekday(5), 27),
      ChartData(getWeekday(6), 26),
      ChartData(getWeekday(7), 25),
    ];

    weatherDataMonthly = [
      ChartData(getWeekOfPreviousMonth(1), 10),
      ChartData(getWeekOfPreviousMonth(2), 15),
      ChartData(getWeekOfPreviousMonth(3), 20),
      ChartData(getWeekOfPreviousMonth(4), 18),
    ];

    rainPercentChartYearly = [
      ChartData(getMonthName(1), 10),
      ChartData(getMonthName(2), 15),
      ChartData(getMonthName(3), 20),
      ChartData(getMonthName(4), 18),
      ChartData(getMonthName(5), 25),
      ChartData(getMonthName(6), 28),
      ChartData(getMonthName(7), 30),
      ChartData(getMonthName(8), 32),
      ChartData(getMonthName(9), 27),
      ChartData(getMonthName(10), 22),
      ChartData(getMonthName(11), 16),
      ChartData(getMonthName(12), 12),
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
        //Button
        Visibility(
          visible: visitorVisible,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SwitchListTile(
              activeColor:
                  const Color.fromRGBO(38, 158, 38, 0.2), // Lighter green tone
              activeTrackColor: const Color.fromARGB(255, 40, 160, 40),
              title: Text(
                rainLineChart
                    ? 'Temperatur ausblenden'
                    : 'Temperatur einblenden',
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
            padding: const EdgeInsets.only(left: 10),
            child: SwitchListTile(
              activeColor:
                  const Color.fromRGBO(38, 158, 38, 0.2), // Lighter green tone
              activeTrackColor: const Color.fromARGB(255, 40, 160, 40),
              title: Text(
                rainLineChart
                    ? 'Temperatur ausblenden'
                    : 'Temperatur einblenden',
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
                  if (rainLineChart)
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
              padding: const EdgeInsets.only(left: 10),
              child: SwitchListTile(
                activeColor: const Color.fromRGBO(
                    38, 158, 38, 0.2), // Lighter green tone
                activeTrackColor: const Color.fromARGB(255, 40, 160, 40),
                title: Text(
                  rainLineChart
                      ? 'Temperatur ausblenden'
                      : 'Temperatur einblenden',
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
                    if (rainLineChart)
                      LineSeries<ChartData, String>(
                        dataSource: weatherDataMonthly,
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
                      dataSource: airHumidityMonthly,
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
            padding: const EdgeInsets.only(left: 10),
            child: SwitchListTile(
              activeColor:
                  const Color.fromRGBO(38, 158, 38, 0.2), // Lighter green tone
              activeTrackColor: const Color.fromARGB(255, 40, 160, 40),
              title: Text(
                rainLineChart
                    ? 'Temperatur ausblenden'
                    : 'Temperatur einblenden',
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
                  if (rainLineChart)
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
                    dataSource: airChartYearly,
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
  final double y;

  ChartData(this.x, this.y);
}
