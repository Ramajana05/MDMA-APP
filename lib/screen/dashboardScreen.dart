import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../widget/sidePanelWidget.dart';
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

  List<WeatherItem> weatherForecast1 = [];
  List<WeatherItem> weatherForecast2 = [];

  Future<void> fetchWeatherData() async {
    const apiKey1 = '27582f8ca711490a986134852231605';
    const apiKey2 = '72f7ad5f2cbe46aa88e03636230106';

    final response1 = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/forecast.json?key=$apiKey1&q=Heilbronn&days=3&aqi=no&alerts=no'));
    final response2 = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/forecast.json?key=$apiKey2&q=Heilbronn&days=2&aqi=no&alerts=no'));

    if (response1.statusCode == 200 && response2.statusCode == 200) {
      final data1 = jsonDecode(response1.body);
      final data2 = jsonDecode(response2.body);

      final weatherData1 = data1['current'];
      final forecastData1 = data1['forecast']['forecastday'];

      final weatherData2 = data2['current'];
      final forecastData2 = data2['forecast']['forecastday'];

      if (weatherData1 != null &&
          forecastData1 != null &&
          weatherData2 != null &&
          forecastData2 != null) {
        final airPressure1 =
            (weatherData1['pressure_mb'] as num?)?.toDouble() ?? 0.0;
        final temperature1 =
            (weatherData1['temp_c'] as num?)?.toDouble() ?? 0.0;

        weatherForecast1 = forecastData1
            .skip(1)
            .map<WeatherItem>((item) => WeatherItem(
                  weekday:
                      getGermanWeekday(DateTime.parse(item['date']).weekday),
                  date: item['date'],
                  weatherIcon: item['day']['condition']['icon'],
                  temperature:
                      (item['day']['maxtemp_c'] as num?)?.toDouble() ?? 0.0,
                  rainPercentage: (item['day']['daily_chance_of_rain'] as num?)
                          ?.toDouble() ??
                      0.0,
                  windSpeed:
                      (item['day']['maxwind_kph'] as num?)?.toDouble() ?? 0.0,
                ))
            .toList();

        final airPressure2 =
            (weatherData2['pressure_mb'] as num?)?.toDouble() ?? 0.0;
        final temperature2 =
            (weatherData2['temp_c'] as num?)?.toDouble() ?? 0.0;

        weatherForecast2 = forecastData2
            .map<WeatherItem>((item) => WeatherItem(
                  weekday:
                      getGermanWeekday(DateTime.parse(item['date']).weekday),
                  date: item['date'],
                  weatherIcon: item['day']['condition']['icon'],
                  temperature:
                      (item['day']['maxtemp_c'] as num?)?.toDouble() ?? 0.0,
                  rainPercentage: (item['day']['daily_chance_of_rain'] as num?)
                          ?.toDouble() ??
                      0.0,
                  windSpeed:
                      (item['day']['maxwind_kph'] as num?)?.toDouble() ?? 0.0,
                ))
            .toList();

        setState(() {
          airPressure = airPressure1;
          temperature = temperature1;
        });
      }
    }
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
      appBar: const TopNavBar(title: 'DASHBOARD'),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Temperatur: ${temperature.toStringAsFixed(1)}°C',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Luftdruck: ${airPressure.toStringAsFixed(1)} mbar',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Weather Forecast 1',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: weatherForecast1.length,
                    itemBuilder: (BuildContext context, int index) {
                      WeatherItem weatherData = weatherForecast1[index];
                      return WeatherItemCard(weatherData: weatherData);
                    },
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: weatherForecast2.length,
                    itemBuilder: (BuildContext context, int index) {
                      WeatherItem weatherData = weatherForecast2[index];
                      return WeatherItemCard(weatherData: weatherData);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: SidePanel(),
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
