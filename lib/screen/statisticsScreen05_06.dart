import 'package:flutter/material.dart';
import 'package:forestapp/widget/customStatisticContainerWidget.dart';
import 'package:forestapp/widget/topNavBar.dart';
import '../Model/IntervalTypeEnum.dart';
import '../widget/checkBoxValuesForCharts.dart';
import 'package:forestapp/widget/sidePanelWidget.dart';

class StatisticsScreen extends StatefulWidget {
  StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreen();
}

class _StatisticsScreen extends State<StatisticsScreen> {
  DateTime? _date;

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
      body: SafeArea(
        child: Column(
          children: [
            DefaultTabController(
              length: 2,
              child: Expanded(
                child: Column(
                  children: <Widget>[
                    const Flexible(
                      flex: 1,
                      child: TabBar(
                          isScrollable: true,
                          labelColor: Colors.green,
                          indicatorColor: Colors.green,
                          unselectedLabelColor: Colors.black,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          tabs: [
                            Tab(
                              text: "Stündlich",
                              iconMargin: EdgeInsets.only(left: 50),
                            ),
                            Tab(
                              text: "Täglich",
                            )
                          ]),
                    ),
                    Flexible(
                      flex: 8,
                      child: Container(
                        child: TabBarView(children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  flex: 6,
                                  child: customStatisticContainer(
                                      IntervalType.hourly)),
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Tooltip(
                                          message: "Personen",
                                          child: CheckboxListTile(
                                            contentPadding:
                                                EdgeInsets.only(right: 0),

                                            title: const Text("Personen",
                                                style: TextStyle(fontSize: 12)),
                                            value: CheckBoxValuesForCharts
                                                .isCheckedPersonsHourly,
                                            checkColor: Colors.white,
                                            activeColor: Colors.green,
                                            onChanged: (newValue) {
                                              setState(() {
                                                CheckBoxValuesForCharts
                                                        .isCheckedPersonsHourly =
                                                    newValue!;
                                              });
                                            },
                                            controlAffinity: ListTileControlAffinity
                                                .leading, //  <-- leading Checkbox
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Tooltip(
                                          message: "Temperaturen",
                                          child: CheckboxListTile(
                                            contentPadding:
                                                EdgeInsets.only(right: 0),
                                            title: const Text(
                                              "Temperatur",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            checkColor: Colors.white,
                                            activeColor: Colors.pink,
                                            value: CheckBoxValuesForCharts
                                                .isCheckedTemperatureHourly,
                                            onChanged: (newValue) {
                                              setState(() {
                                                CheckBoxValuesForCharts
                                                        .isCheckedTemperatureHourly =
                                                    newValue!;
                                                print(
                                                    "temperature hourly: $newValue");
                                              });
                                            },
                                            controlAffinity: ListTileControlAffinity
                                                .leading, //  <-- leading Checkbox
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Tooltip(
                                          message: "Luftfeuchtigkeit",
                                          child: CheckboxListTile(
                                            contentPadding:
                                                EdgeInsets.only(right: 0),
                                            title: const Text(
                                              "Luftfeuchtigkeit",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            value: CheckBoxValuesForCharts
                                                .isCheckedHumidityHourly,
                                            checkColor: Colors.white,
                                            activeColor: Colors.cyan,
                                            onChanged: (newValue) {
                                              setState(() {
                                                CheckBoxValuesForCharts
                                                        .isCheckedHumidityHourly =
                                                    newValue!;
                                                print(
                                                    "humidity hourly: $newValue");
                                              });
                                            },
                                            controlAffinity: ListTileControlAffinity
                                                .leading, //  <-- leading Checkbox
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  flex: 6,
                                  child: customStatisticContainer(
                                      IntervalType.daily)),
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    //mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Tooltip(
                                          message: "Personen",
                                          child: CheckboxListTile(
                                            contentPadding:
                                                const EdgeInsets.only(right: 0),

                                            title: const Text("Personen",
                                                style: TextStyle(fontSize: 12)),
                                            value: CheckBoxValuesForCharts
                                                .isCheckedPersonsDaily,
                                            checkColor: Colors.white,
                                            activeColor: Colors.green,
                                            onChanged: (newValue) {
                                              setState(() {
                                                CheckBoxValuesForCharts
                                                        .isCheckedPersonsDaily =
                                                    newValue!;
                                              });
                                            },
                                            controlAffinity: ListTileControlAffinity
                                                .leading, //  <-- leading Checkbox
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Tooltip(
                                          message: "Temperaturen",
                                          child: CheckboxListTile(
                                            contentPadding:
                                                EdgeInsets.only(right: 0),
                                            title: const Text(
                                              //"\u{1F321}",
                                              "Temperature",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            checkColor: Colors.white,
                                            activeColor: Colors.pink,
                                            value: CheckBoxValuesForCharts
                                                .isCheckedTemperatureDaily,
                                            onChanged: (newValue) {
                                              setState(() {
                                                CheckBoxValuesForCharts
                                                        .isCheckedTemperatureDaily =
                                                    newValue!;
                                              });
                                            },
                                            controlAffinity: ListTileControlAffinity
                                                .leading, //  <-- leading Checkbox
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Tooltip(
                                          message: "Luftfeuchtigkeit",
                                          child: CheckboxListTile(
                                            contentPadding:
                                                EdgeInsets.only(right: 0),
                                            title: const Text(
                                              "Luftfeuchtigkeit",
                                              style: TextStyle(fontSize: 12),
                                            ),

                                            value: CheckBoxValuesForCharts
                                                .isCheckedHumidityDaily,
                                            checkColor: Colors.white,
                                            activeColor: Colors.cyan,
                                            onChanged: (newValue) {
                                              setState(() {
                                                CheckBoxValuesForCharts
                                                        .isCheckedHumidityDaily =
                                                    newValue!;
                                              });
                                            },
                                            controlAffinity: ListTileControlAffinity
                                                .leading, //  <-- leading Checkbox
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
