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
        title: 'STATISTIKS',
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
