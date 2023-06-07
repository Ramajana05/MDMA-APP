import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../widget/sidePanelWidget.dart';
import '../widget/topNavBar.dart';
import 'package:forestapp/widget/warningWidget.dart';
import 'package:forestapp/screen/sensorListScreen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var temperature = 0.0;
  var currentVisitors = 4856;
  var airPressure = 0.0;
  bool showWarningWidget = true;

  final double maxVisitors = 5000; // Maximum value
  final Color chartColor = Color.fromARGB(255, 108, 127, 235); // Chart color
  final Color trackColor =
      Color.fromARGB(255, 126, 83, 161); // Transparent track color

  List<WeatherItem> weatherForecast = [];

  Future<List<WeatherItem>> fetchWeatherData() async {
    final response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/forecast.json?key=27582f8ca711490a986134852231605&q=Heilbronn&days=5&aqi=no&alerts=no'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final weatherData = data['current'];
      final forecastData = data['forecast']['forecastday'];

      if (weatherData != null && forecastData != null) {
        final airPressure =
            (weatherData['pressure_mb'] as num?)?.toDouble() ?? 0.0;
        final temperature = (weatherData['temp_c'] as num?)?.toDouble() ?? 0.0;

        List<WeatherItem> weatherItems =
            forecastData.skip(1).map<WeatherItem>((item) {
          final maxTemp = (item['day']['maxtemp_c']);
          final rainPercentage =
              (item['day']['daily_chance_of_rain"'] as num?)?.toDouble() ?? 0;
          final windSpeed =
              (item['day']['maxwind_kph'] as num?)?.toDouble() ?? 0;

          final dateTime = DateTime.parse(item['date']);
          final weekday = getGermanWeekday(dateTime.weekday);

          return WeatherItem(
            weekday: weekday,
            date: item['date'],
            weatherIcon: item['day']['condition']['icon'],
            temperature: maxTemp,
            rainPercentage: rainPercentage,
            windSpeed: windSpeed,
          );
        }).toList();

        setState(() {
          this.airPressure = airPressure;
          this.temperature = temperature;
          weatherForecast = weatherItems;
        });

        return weatherItems;
      }
    }

    return [];
  }

  String getGermanWeekday(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Montag';
      case DateTime.tuesday:
        return 'Dienstag';
      case DateTime.wednesday:
        return 'Mittwoch';
      case DateTime.thursday:
        return 'Donnerstag';
      case DateTime.friday:
        return 'Freitag';
      case DateTime.saturday:
        return 'Samstag';
      case DateTime.sunday:
        return 'Sonntag';
      default:
        return '';
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidePanel(),
      backgroundColor: Colors.white,
      appBar: const TopNavBar(
        title: 'DASHBOARD',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Visitors
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.indigoAccent,
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Expanded(
                      child: Stack(
                        children: [
                          SfCircularChart(
                            series: <CircularSeries<_ChartData, String>>[
                              RadialBarSeries<_ChartData, String>(
                                maximumValue: maxVisitors,
                                radius: '150%',
                                gap: '80%',
                                dataSource: [
                                  _ChartData(
                                    'Value',
                                    currentVisitors.toDouble(),
                                    Color.fromARGB(255, 108, 127, 235),
                                  ),
                                ],
                                cornerStyle: CornerStyle.bothCurve,
                                xValueMapper: (_ChartData data, _) => data.x,
                                yValueMapper: (_ChartData data, _) => data.y,
                                pointColorMapper: (_ChartData data, _) =>
                                    data.color,
                                trackColor: Color.fromARGB(255, 126, 83, 161),
                              ),
                            ],
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        currentVisitors.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.person,
                                            size: 26,
                                          ),
                                          Icon(
                                            Icons.person,
                                            size: 26,
                                          ),
                                          Icon(
                                            Icons.person,
                                            size: 26,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //Sensor
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.tealAccent,
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Expanded(
                      child: Stack(
                        children: [
                          SfCircularChart(
                            series: <CircularSeries<_ChartData, String>>[
                              RadialBarSeries<_ChartData, String>(
                                maximumValue: 10,
                                radius: '150%',
                                gap: '80%',
                                dataSource: [
                                  _ChartData('Value', 9, Colors.teal),
                                ],
                                cornerStyle: CornerStyle.bothCurve,
                                xValueMapper: (_ChartData data, _) => data.x,
                                yValueMapper: (_ChartData data, _) => data.y,
                                pointColorMapper: (_ChartData data, _) =>
                                    data.color,
                                trackColor: Colors.tealAccent,
                              ),
                            ],
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        9.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.sensors,
                                            size: 26,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //Temperature and Air
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Temperature
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.redAccent,
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Expanded(
                      child: Stack(
                        children: [
                          SfCircularChart(
                            series: <CircularSeries<_ChartData, String>>[
                              RadialBarSeries<_ChartData, String>(
                                  maximumValue: 100,
                                  radius: '150%',
                                  gap: '80%',
                                  dataSource: [
                                    _ChartData(
                                        'Value', temperature, Colors.red),
                                  ],
                                  cornerStyle: CornerStyle.bothCurve,
                                  xValueMapper: (_ChartData data, _) => data.x,
                                  yValueMapper: (_ChartData data, _) => data.y,
                                  pointColorMapper: (_ChartData data, _) =>
                                      data.color,
                                  trackColor:
                                      Color.fromARGB(255, 252, 131, 123)),
                            ],
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        '$temperature°C',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.thermostat,
                                            size: 26,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Air Pressure
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.lightBlue,
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Expanded(
                      child: Stack(
                        children: [
                          SfCircularChart(
                            series: <CircularSeries<_ChartData, String>>[
                              RadialBarSeries<_ChartData, String>(
                                maximumValue: 3000,
                                radius: '150%',
                                gap: '80%',
                                dataSource: [
                                  _ChartData('Value', airPressure, Colors.blue),
                                ],
                                cornerStyle: CornerStyle.bothCurve,
                                xValueMapper: (_ChartData data, _) => data.x,
                                yValueMapper: (_ChartData data, _) => data.y,
                                pointColorMapper: (_ChartData data, _) =>
                                    data.color,
                                trackColor: Colors.lightBlueAccent,
                              ),
                            ],
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        '$airPressure hPa',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/4352492.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Neuigkeiten",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        showWarningWidget = !showWarningWidget;
                      });
                    },
                    icon: Icon(
                      showWarningWidget
                          ? Icons.notifications_off_outlined
                          : Icons.notifications_active_outlined,
                      color: Colors.black,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: showWarningWidget,
              child: WarningWidget(
                message:
                    'Es wurde ein neuer Sensor am 06.06.2023 um 14:34Uhr hinzugefügt',
                isWarnung: false,
                iconColor: const Color.fromARGB(255, 37, 70, 255),
              ),
            ),
            Visibility(
              visible: showWarningWidget,
              child: WarningWidget(
                message: 'Der Sensor ST342 hat noch kaum noch Akkulaufzeit',
                isWarnung: true,
                iconColor: const Color.fromARGB(255, 255, 106, 37),
              ),
            ),
            Container(
              height: 70,
              alignment: Alignment.centerLeft,
              child: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Wettervorhersage",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: weatherForecast.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width >= 350 ? 2 : 1,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  WeatherItem weatherData = weatherForecast[index];
                  return WeatherItemCard(weatherData: weatherData);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherItem {
  final String weekday;
  final String date;
  final String weatherIcon;
  final double temperature;
  final double rainPercentage;
  final double windSpeed;

  WeatherItem({
    required this.weekday,
    required this.date,
    required this.weatherIcon,
    required this.temperature,
    required this.rainPercentage,
    required this.windSpeed,
  });
}

class WeatherItemCard extends StatelessWidget {
  final WeatherItem weatherData;

  const WeatherItemCard({Key? key, required this.weatherData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Color.fromARGB(255, 255, 170, 73).withOpacity(1.0),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10), // Adjust the border radius as needed
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display the weekday
          Text(
            weatherData.weekday,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          // Display the date
          Text(
            DateFormat('dd.MM.').format(DateTime.parse(weatherData.date)),
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          // Display the temperature
          Text(
            '${weatherData.temperature}°C',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          // Display the weather icon
          Image.network(
            'https:${weatherData.weatherIcon}',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          // Display the rain percentage
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.water_drop, size: 20, color: Colors.blue),
              Text(
                '${weatherData.rainPercentage}%',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          // Display the wind speed
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.air, size: 24, color: Colors.grey),
              Text(
                '${weatherData.windSpeed} km/h',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  final String x;
  final double y;
  final Color color;

  _ChartData(this.x, this.y, this.color);
}
