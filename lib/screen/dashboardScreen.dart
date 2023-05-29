import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../widget/topNavBar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var temperature = 0.0;
  var visitors = 4856;
  var airPressure = 0.0;

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
      backgroundColor: Colors.white,
      appBar: TopNavBar(
        title: 'DASHBOARD',
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                "Übersicht",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        // Visitors
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff86ffd6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xff86ffd6), width: 5),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '$visitors',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Text(
                          'Besucher',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Icon(
                          Icons.person,
                          size: 40,
                        ),
                        Icon(
                          Icons.person,
                          size: 40,
                        ),
                        Icon(
                          Icons.person,
                          size: 40,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // Temperature and Air Pressure
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Temperature
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFCEFFCD),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '$temperature°C',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Temperatur',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.thermostat,
                          size: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              // Air Pressure
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(3, 255, 94, 0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '$airPressure hPa',
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Luftdruck',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/4352492.png',
                          width: 33,
                          height: 33,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        //Weather Forecast
        Container(
          height: 70,
          alignment: Alignment.centerLeft,
          // Weather Text
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
        // Weather
        Container(
          margin: const EdgeInsets.all(8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: weatherForecast.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width >= 350 ? 2 : 1,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemBuilder: (BuildContext context, int index) {
              WeatherItem weatherData = weatherForecast[index];
              return WeatherItemCard(weatherData: weatherData);
            },
          ),
        ),
        // ]),
      ])),
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
      shadowColor: Colors.grey.withOpacity(1.0),
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
              Image.asset(
                'assets/icons8-water-24.png',
                height: 17,
                width: 17,
                color: Colors.blue,
              ),
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
