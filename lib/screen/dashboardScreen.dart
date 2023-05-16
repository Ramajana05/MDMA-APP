import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widget/topNavBar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime tomorrow = now.add(const Duration(days: 1));
    DateTime afterTomorrow = now.add(const Duration(days: 2));

    var temperature = 25;
    var visitors = 1234;
    var airPressure = 1013;

    final List<WeatherItem> weatherForecast = [
      WeatherItem(
        weekday: '',
        date: DateTime.now(),
        weatherIcon: Icons.wb_sunny,
        temperature: temperature,
        rainPercentage: 10,
        windStrength: 12.5,
      ),
      WeatherItem(
        weekday: '',
        date: tomorrow,
        weatherIcon: Icons.cloud,
        temperature: temperature,
        rainPercentage: 50,
        windStrength: 8.2,
      ),
      WeatherItem(
        weekday: '',
        date: afterTomorrow,
        weatherIcon: Icons.grain,
        temperature: temperature,
        rainPercentage: 80,
        windStrength: 6.8,
      ),
      WeatherItem(
        weekday: '',
        date: afterTomorrow,
        weatherIcon: Icons.sunny_snowing,
        temperature: temperature,
        rainPercentage: 30,
        windStrength: 6.8,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopNavBar(
        title: 'DASHBOARD',
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: Column(children: [
        //Overview Header
        Container(
          height: 70,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3)),
            ],
          ),
          //Overview Text
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Overview",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        //Visitors
        Container(
          padding: const EdgeInsets.all(16),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  color: const Color(0xff86ffd6),
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Besucher Aktuell',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    visitors.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: visitors > 2000 ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            //Temperature
            Column(children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFCEFFCD),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Temperatur',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$temperature°C',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: temperature >= 25
                            ? Colors.red
                            : temperature >= 15
                                ? Colors.orange
                                : Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              //Air Pressure
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(3, 255, 94, 0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(25),
                child: Column(children: [
                  const Text(
                    'Luftdruck',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${airPressure}hPa",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: airPressure < 1000 || airPressure > 1100
                          ? Colors.red
                          : Colors.black,
                    ),
                  ),
                ]),
              ),
            ]),
          ]),
        ),
        Container(
          height: 70,
          alignment: Alignment.centerLeft,

          //Weather Text
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Wetter",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Weather
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: weatherForecast.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width >= 350
                    ? 2
                    : 1, // Display 2 items in a row if width >= 350, otherwise display 1 item
                crossAxisSpacing: 10,
                mainAxisSpacing: 0,
                childAspectRatio: 1),
            itemBuilder: (BuildContext context, int index) {
              WeatherItem weatherData = weatherForecast[index];
              return WeatherItem(
                weekday: weatherData.weekday,
                date: weatherData.date,
                weatherIcon: weatherData.weatherIcon,
                temperature: weatherData.temperature,
                rainPercentage: weatherData.rainPercentage,
                windStrength: weatherData.windStrength,
              );
            },
          ),
        ),
      ]),
    );
  }
}

class WeatherItem extends StatelessWidget {
  final String weekday;
  final DateTime date;
  final IconData weatherIcon;
  final int temperature;
  final int rainPercentage;
  final double windStrength;

  const WeatherItem({
    super.key,
    required this.weekday,
    required this.date,
    required this.weatherIcon,
    required this.temperature,
    required this.rainPercentage,
    required this.windStrength,
  });

  @override
  Widget build(BuildContext context) {
    final weekday = date.weekday;
    final germanWeekdays = [
      'Montag',
      'Dienstag',
      'Mittwoch',
      'Donnerstag',
      'Freitag',
      'Samstag',
      'Sonntag',
    ];
    final germanWeekday = germanWeekdays[weekday - 1];
    final formattedMonth = date.month.toString().padLeft(2, '0');

    return Column(
      children: [
        Text(germanWeekday),
        Text(' ${date.day}.$formattedMonth'),
        Icon(
          weatherIcon,
          size: 50,
        ),
        Text(' $temperature°C'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.water,
              size: 24,
              color: Colors.blue,
            ),
            Text(' $rainPercentage%'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.air, size: 24, color: Colors.grey),
            Text(' $windStrength km/h'),
          ],
        ),
      ],
    );
  }
}
