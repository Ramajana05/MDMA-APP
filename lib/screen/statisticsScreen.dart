import 'package:fl_chart/src/chart/bar_chart/bar_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:forestapp/main.dart';
import 'package:forestapp/widget/customBarChartWidget.dart';
import 'package:forestapp/widget/customLineChartWidget.dart';
import 'package:forestapp/widget/customStatisticContainerWidget.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'package:forestapp/design/topNavBarDecoration.dart';
import 'package:d_chart/d_chart.dart';
import 'package:intl/intl.dart';
import '../Model/IntervalTypeEnum.dart';
import '../dialog/logoutDialog.dart';
import '../widget/checkBoxValuesForCharts.dart';
import 'dart:ui';

class StatisticsScreen extends StatefulWidget {
  StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreen();
}

class _StatisticsScreen extends State<StatisticsScreen> {
   DateTime? _date;

  String _dateText() {
    String dateText = '';
    _date == null
        ? dateText = 'Heute'
        : dateText = '${_date?.day}.${_date?.month}';
    return dateText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopNavBar(
        title: 'STATISTIK',
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            Flexible(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.blueGrey, width: 0.5))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Overview",

                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton.icon(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.white),
                            side: MaterialStatePropertyAll<BorderSide>(
                                BorderSide(color: Colors.black54, width: 0.5))),
                        onPressed: () async {
                          final currentDate = DateTime.now();
                          final oneMonthAgo =
                              currentDate.subtract(const Duration(days: 30));
                          final myTheme = ThemeData(
                            colorScheme: const ColorScheme.light(
                              primary: Colors.green, // Customize primary color
                              onPrimary: Colors.black87, // Customize text color
                            ),
                          );
                          final result = await showDatePicker(
                              builder: (BuildContext context, Widget? child) {
                                return Theme(data: myTheme, child: child!);
                              },
                              context: context,
                              initialDate: currentDate,
                              firstDate: oneMonthAgo,
                              lastDate: currentDate);
                          if (result != null) {
                            setState(() {
                              _date = result;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                        ),
                        label: Text(
                          _dateText(),
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 9,
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Statistiken der letzen 12 Stunden",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    children: [
                      customStatisticContainer(IntervalType.hourly),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: CheckboxListTile(
                                contentPadding: EdgeInsets.only(right: 0),

                                title: const Text('Personen',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.green)),
                                value: CheckBoxValuesForCharts
                                    .isCheckedPersonsHourly,
                                checkColor: Colors.white,
                                activeColor: Colors.green,
                                onChanged: (newValue) {
                                  setState(() {
                                    CheckBoxValuesForCharts
                                        .isCheckedPersonsHourly = newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: CheckboxListTile(
                                contentPadding: EdgeInsets.only(right: 0),
                                title: const Text(
                                  "Temparaturen",
            DefaultTabController(
                length: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: const TabBar(
                        isScrollable: true,
                        labelColor: Colors.green,
                        indicatorColor: Colors.green,
                        unselectedLabelColor: Colors.black,
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(
                            text: "Besucher",
                          ),
                          Tab(
                            text: "Sensoren",
                          ),
                          Tab(
                            text: "Temparatur",
                          ),
                          Tab(
                            text: "Luftfeuchtigkeit",
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 400,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey, width: 0.5))),
                      child: TabBarView(children: <Widget>[
                        Container(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Besucheranzahl der letzen Woche",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 30,
                                        bottom: 10),
                                    width: 300,
                                    height: 300,
                                    decoration: const BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 4,
                                            offset:
                                                Offset(4, 8), // Shadow position
                                          ),
                                        ],
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey, width: 0.5),
                                            top: BorderSide(
                                                color: Colors.grey, width: 0.5),
                                            right: BorderSide(
                                                color: Colors.grey, width: 0.5),
                                            left: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5))),
                                    child: DChartBar(
                                      data: const [
                                        {
                                          'id': 'Bar',
                                          'data': [
                                            {
                                              'domain': 'Donnerstag',
                                              'measure': 2
                                            },
                                            {
                                              'domain': 'Freitag',
                                              'measure': 18
                                            },
                                            {
                                              'domain': 'Samstag',
                                              'measure': 10
                                            },
                                            {
                                              'domain': 'Sonntag',
                                              'measure': 20
                                            },
                                            {'domain': 'Montag', 'measure': 3},
                                            {
                                              'domain': 'Dienstag',
                                              'measure': 12
                                            },
                                            {'domain': 'Heute', 'measure': 8},
                                          ],
                                        },
                                      ],
                                      domainLabelRotation: 270,
                                      xAxisTitle: "Woche 20",
                                      yAxisTitle: "Besucheranzahl",
                                      axisLineTick: 2,
                                      axisLinePointTick: 2,
                                      axisLinePointWidth: 10,
                                      axisLineColor: Colors.black38,
                                      domainLabelFontSize: 10,
                                      measureLabelPaddingToAxisLine: 16,
                                      domainLabelPaddingToAxisLine: 60,
                                      barColor: (barData, index, id) =>
                                          Colors.green,
                                      showBarValue: true,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Besucheranzahl an den Standorten",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 30,
                                        bottom: 10),
                                    width: 300,
                                    height: 300,
                                    decoration: const BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 4,
                                            offset:
                                                Offset(4, 8), // Shadow position
                                          ),
                                        ],
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey, width: 0.5),
                                            top: BorderSide(
                                                color: Colors.grey, width: 0.5),
                                            right: BorderSide(
                                                color: Colors.grey, width: 0.5),
                                            left: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5))),
                                    child: DChartBar(
                                      data: const [
                                        {
                                          'id': 'Bar',
                                          'data': [
                                            {
                                              'domain': 'Walderlebnispfad',
                                              'measure': 2
                                            },
                                            {
                                              'domain': 'Waldheide',
                                              'measure': 18
                                            },
                                            {
                                              'domain': 'Grillstelle',
                                              'measure': 10
                                            },
                                            {
                                              'domain': 'NSG Köpfertal',
                                              'measure': 20
                                            },
                                            {
                                              'domain': 'Sportpfad',
                                              'measure': 3
                                            },
                                            {
                                              'domain': 'MTB-Downhillstrecke',
                                              'measure': 6
                                            },
                                            {
                                              'domain': '(Hoch-)Schulwald',
                                              'measure': 14
                                            },
                                          ],
                                        },
                                      ],
                                      domainLabelRotation: 270,
                                      xAxisTitle: "Standort",
                                      yAxisTitle: "Besucheranzahl",
                                      axisLineTick: 2,
                                      axisLinePointTick: 2,
                                      axisLinePointWidth: 10,
                                      axisLineColor: Colors.black38,
                                      measureLabelPaddingToAxisLine: 16,
                                      domainLabelPaddingToAxisLine: 100,
                                      domainLabelFontSize: 10,
                                      barColor: (barData, index, id) =>
                                          Colors.green,
                                      showBarValue: true,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Sensoren Feldstärke am Standort",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30, bottom: 10),
                                width: 300,
                                height: 230,
                                decoration: const BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 4,
                                        offset: Offset(4, 8), // Shadow position
                                      ),
                                    ],
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey, width: 0.5),
                                        top: BorderSide(
                                            color: Colors.grey, width: 0.5),
                                        right: BorderSide(
                                            color: Colors.grey, width: 0.5),
                                        left: BorderSide(
                                            color: Colors.grey, width: 0.5))),
                                child: DChartBar(
                                  data: const [
                                    {
                                      'id': 'Bar',
                                      'data': [
                                        {'domain': 'TemSen 1', 'measure': 12},
                                        {'domain': 'TemSen 2', 'measure': 18},
                                        {'domain': 'TemSen 5', 'measure': 5},
                                        {'domain': 'HumiSen 4', 'measure': 30},
                                        {'domain': 'TemSen 9', 'measure': 5},
                                        {'domain': 'HumiSen 12', 'measure': 12},
                                      ],
                                    },
                                  ],
                                  domainLabelRotation: 270,
                                  domainLabelPaddingToAxisLine: 60,
                                  domainLabelFontSize: 10,
                                  xAxisTitle: "Sensor",
                                  yAxisTitle: "Feldstärke",
                                  axisLineTick: 2,
                                  axisLinePointTick: 2,
                                  axisLinePointWidth: 10,
                                  axisLineColor: Colors.green,
                                  measureLabelPaddingToAxisLine: 16,
                                  barColor: (barData, index, id) =>
                                      Colors.green,
                                  showBarValue: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Temperaturen der letzten Woche",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.pink),
                                ),
                                checkColor: Colors.white,
                                activeColor: Colors.pink,
                                value: CheckBoxValuesForCharts
                                    .isCheckedTemperatureHourly,
                                onChanged: (newValue) {
                                  setState(() {
                                    CheckBoxValuesForCharts
                                        .isCheckedTemperatureHourly = newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: CheckboxListTile(
                                contentPadding: EdgeInsets.only(right: 0),
                                title: const Text("Luftfeuchtigkeit",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.cyan)),
                                value: CheckBoxValuesForCharts
                                    .isCheckedHumidityHourly,
                                checkColor: Colors.white,
                                activeColor: Colors.cyan,
                                onChanged: (newValue) {
                                  setState(() {
                                    CheckBoxValuesForCharts
                                        .isCheckedHumidityHourly = newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30, bottom: 10),
                                width: 300,
                                height: 230,
                                decoration: const BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 4,
                                        offset: Offset(4, 8), // Shadow position
                                      ),
                                    ],
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey, width: 0.5),
                                        top: BorderSide(
                                            color: Colors.grey, width: 0.5),
                                        right: BorderSide(
                                            color: Colors.grey, width: 0.5),
                                        left: BorderSide(
                                            color: Colors.grey, width: 0.5))),
                                child: DChartBar(
                                  data: const [
                                    {
                                      'id': 'Bar',
                                      'data': [
                                        {'domain': 'Donnerstag', 'measure': 2},
                                        {'domain': 'Freitag', 'measure': 18},
                                        {'domain': 'Samstag', 'measure': 10},
                                        {'domain': 'Sonntag', 'measure': 20},
                                        {'domain': 'Montag', 'measure': 3},
                                        {'domain': 'Dienstag', 'measure': 12},
                                        {'domain': 'Heute', 'measure': 8},
                                      ],
                                    },
                                  ],
                                  domainLabelRotation: 270,
                                  domainLabelPaddingToAxisLine: 60,
                                  xAxisTitle: "Woche 20",
                                  yAxisTitle: "Temperatur",
                                  axisLineTick: 2,
                                  axisLinePointTick: 2,
                                  axisLinePointWidth: 10,
                                  axisLineColor: Colors.green,
                                  domainLabelFontSize: 10,
                                  measureLabelPaddingToAxisLine: 16,
                                  barColor: (barData, index, id) =>
                                      Colors.green,
                                  showBarValue: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Statistiken der letzten Woche",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    children: [
                      customStatisticContainer(IntervalType.daily),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: CheckboxListTile(
                                contentPadding: EdgeInsets.only(right: 0),

                                title: const Text('Personen',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.green)),
                                value: CheckBoxValuesForCharts
                                    .isCheckedPersonsDaily,
                                checkColor: Colors.white,
                                activeColor: Colors.green,
                                onChanged: (newValue) {
                                  setState(() {
                                    CheckBoxValuesForCharts
                                        .isCheckedPersonsDaily = newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: CheckboxListTile(
                                contentPadding: EdgeInsets.only(right: 0),
                                title: const Text(
                                  "Temparaturen",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.pink),
                                ),
                                checkColor: Colors.white,
                                activeColor: Colors.pink,
                                value: CheckBoxValuesForCharts
                                    .isCheckedTemperatureDaily,
                                onChanged: (newValue) {
                                  setState(() {
                                    CheckBoxValuesForCharts
                                        .isCheckedTemperatureDaily = newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: CheckboxListTile(
                                contentPadding: EdgeInsets.only(right: 0),
                                title: const Text("Luftfeuchtigkeit",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.cyan)),
                                value: CheckBoxValuesForCharts
                                    .isCheckedHumidityDaily,
                                checkColor: Colors.white,
                                activeColor: Colors.cyan,
                                onChanged: (newValue) {
                                  setState(() {
                                    CheckBoxValuesForCharts
                                        .isCheckedHumidityDaily = newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// DateTime now = DateTime.now();
// int weekday = now.weekday;
//
// int weekday = now.weekday - 1;
// if (weekday < 0) {
// weekday = 6;
// }
