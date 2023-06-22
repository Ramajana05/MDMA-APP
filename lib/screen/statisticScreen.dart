import 'dart:math';

import 'package:flutter/material.dart';
import 'package:forestapp/colors/appColors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Model/ChartData.dart';
import '../widget/sidePanelWidget.dart';
import '../widget/topNavBar.dart';
import '../widget/tabBarWidget.dart';

class StatisticsScreen extends StatefulWidget {
  StatisticsScreen({Key? key}) : super(key: key);

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
  var visitorColor = primaryVisitorColor;
  var temperatureColor = red;
  var airHumidityColor = blue;

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
      weekEndDate = weekStartDate.add(Duration(days: 6));
    }

    final weekStartDay = weekStartDate.day.toString().padLeft(2, '0');
    final weekEndDay = weekEndDate.day.toString().padLeft(2, '0');
    final month = firstDayOfPreviousMonth.month.toString().padLeft(2, '0');

    return '$weekStartDay.$month. - $weekEndDay.$month.';
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
      double temperature = Random().nextInt(41) - 5;
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
      color: background,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: boxShadowColor,
          spreadRadius: 3,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidePanel(),
      backgroundColor: background,
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
                    tabTexts: ['Tag', 'Woche', 'Monat'],
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
      padding: EdgeInsets.all(10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(
            labelIntersectAction: AxisLabelIntersectAction.multipleRows,
            axisLine: AxisLine(color: textColor, width: 1.5),
            labelStyle: TextStyle(fontSize: 15, color: textColor),
            visibleMaximum: visibleMaximum,
            placeLabelsNearAxisLine: false,
            desiredIntervals: 12,
            title: AxisTitle(
              text: xAxisTitle,
              textStyle:
                  TextStyle(fontWeight: FontWeight.w700, color: textColor),
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
              textStyle:
                  TextStyle(fontWeight: FontWeight.w700, color: textColor),
            ),
            majorTickLines: MajorTickLines(size: 6, width: 2, color: textColor),
            axisLine: AxisLine(color: textColor, width: 1.5),
            labelStyle: TextStyle(fontSize: 15, color: textColor),
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
              markerSettings: MarkerSettings(
                borderColor: deepPurple,
                isVisible: true,
                color: grey,
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
              markerSettings: MarkerSettings(
                borderColor: Color(0xFF800080),
                isVisible: true,
                color: deepOrange,
                shape: DataMarkerType.circle,
              ),
              color: statBlue,
            ),
          ],
          tooltipBehavior: TooltipBehavior(
            enable: true,
            builder: (dynamic data, dynamic point, dynamic series,
                int pointIndex, int seriesIndex) {
              if (seriesIndex == 0) {
                String formattedY = data.y.toString();
                String formattedYWithUnit = formattedY;

                if (formattedY.endsWith('.0')) {
                  formattedY = formattedY.substring(0, formattedY.length - 2);
                }

                if (chartData == tempChartDaily ||
                    chartData == tempChartMonthly ||
                    chartData == tempChartWeekly) {
                  formattedYWithUnit = '$formattedY°C';
                } else if (chartData == airHumidityChartDaily ||
                    chartData == airHumidityChartMonthly ||
                    chartData == airHumidityChartWeekly) {
                  formattedYWithUnit = '$formattedY%';
                } else {
                  formattedYWithUnit = formattedY;
                }

                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: textColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       chartName,
                      //       style:  TextStyle(
                      //         color: white,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     )
                      //   ],
                      // ),
                      //  Text(
                      //   '────────────────',
                      //   style: TextStyle(color: white),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: chartColor,
                            ),
                          ),
                          Text(
                            '  ${data.x} : '
                            '$formattedYWithUnit',
                            style: TextStyle(color: textInverted),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (seriesIndex == 1) {
                String formattedY = data.y.toString();

                if (formattedY.endsWith('.0')) {
                  formattedY = formattedY.substring(0, formattedY.length - 2);
                }
                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: textColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Regenwahrscheinlichkeit',
                            style: TextStyle(
                              color: textInverted,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Text(
                        '────────────────',
                        style: TextStyle(color: textInverted),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: chartColor,
                            ),
                          ),
                          Text(
                            '  ${data.x} : '
                            '$formattedY%',
                            style: TextStyle(color: textInverted),
                          ),
                        ],
                      ),
                    ],
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
            padding: EdgeInsets.all(8.0),
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
                            padding: EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              visitor,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: textColor,
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
                      padding: EdgeInsets.only(left: 8),
                      child: SwitchListTile(
                        activeColor: statGreen,
                        // Lighter green tone
                        activeTrackColor: primaryAppLightGreen,
                        title: Text(
                          rainLineChart ? rainTextVisible : rainTextHidden,
                          style: TextStyle(
                            color: textColor,
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
                        visitorColor,
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
            padding: EdgeInsets.all(8.0),
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
                            padding: EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              temperature,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: textColor,
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
            padding: EdgeInsets.all(8.0),
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
                            padding: EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              airHumidity,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: textColor,
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
            padding: EdgeInsets.all(8.0),
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
                            padding: EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              visitor,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: textColor,
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
                    child: buildChartWidget(visitorChartWeekly, visitorColor,
                        weeklyMax, '$weekly $visitor'),
                  ),
                ],
              ),
            ),
          ),

          /// Button
          Padding(
            padding: EdgeInsets.all(8.0),
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
                            padding: EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              temperature,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: textColor,
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
            padding: EdgeInsets.all(8.0),
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
                            padding: EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              airHumidity,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: textColor,
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
            padding: EdgeInsets.all(8.0),
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
                            padding: EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              visitor,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: textColor,
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
                      child: buildChartWidget(visitorChartMonthly, visitorColor,
                          monthlyMax, '$monthly $visitor')),
                ],
              ),
            ),
          ),

          // Button
          Padding(
            padding: EdgeInsets.all(8.0),
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
                            padding: EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              temperature,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: textColor,
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
            padding: EdgeInsets.all(8.0),
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
                            padding: EdgeInsets.only(left: 20, top: 5),
                            child: Text(
                              airHumidity,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: textColor,
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
