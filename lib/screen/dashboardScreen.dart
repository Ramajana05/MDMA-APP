import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widget/topNavBar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime today = DateTime.now();
  DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
  DateTime afterTomorrow = DateTime.now().add(const Duration(days: 2));
  DateTime day3 = DateTime.now().add(const Duration(days: 3));

  var temperature = 0.0;
  var visitors = 4856;
  var airPressure = 0;

  List<WeatherItem> weatherForecast = [];

  Future<void> fetchWeatherData() async {
    final response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=27582f8ca711490a986134852231605&q=Heilbronn&aqi=no'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final weatherData = data['current'];
      final forecastData = data['forecast'];

      if (weatherData != null && forecastData != null) {
        setState(() {
          airPressure = weatherData['pressure_mb'].toDouble();
          temperature = weatherData['temp_c'].toDouble();

          weatherForecast =
              List<WeatherItem>.from(forecastData.map((item) => WeatherItem(
                    weekday: item['date'],
                    date: DateTime.parse(item['date']),
                    weatherIcon: item['day']['condition']['icon'],
                    temperature: item['day']['maxtemp_c'].toDouble(),
                    rainPercentage:
                        item['day']['daily_chance_of_rain'].toDouble(),
                    windSpeed: item['day']['maxwind_kph'].toDouble(),
                  )));
        });
      }
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
      body: Column(children: [
        // Overview Header
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
                offset: const Offset(0, 3),
              ),
            ],
          ),
          // Overview Text
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Overview",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        // Visitors
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xff86ffd6),
                  borderRadius: BorderRadius.circular(20),
                ),
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
// Temperature and Air Pressure
              Column(
                children: [
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(3, 255, 94, 0.25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 70,
          alignment: Alignment.centerLeft,
// Weather Text
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Wetter",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
// Weather
        Expanded(
          child: GridView.builder(
            itemCount: weatherForecast.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width >= 350
                  ? 2
                  : 1, // Display 2 items in a row if width >= 350, otherwise display 1 item
              crossAxisSpacing: 10,
              mainAxisSpacing: 0,
              childAspectRatio: 1,
            ),
            itemBuilder: (BuildContext context, int index) {
              WeatherItem weatherData = weatherForecast[index];
              return WeatherItemCard(weatherData: weatherData);
            },
          ),
        ),
      ]),
    );
  }
}

class WeatherItem {
  final String weekday;
  final DateTime date;
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the weekday
            Text(
              weatherData.weekday,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
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
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            // Display the rain percentage
            Text(
              'Regen: ${weatherData.rainPercentage}%',
              style: const TextStyle(fontSize: 16),
            ),
            // Display the wind speed
            Text(
              'Wind: ${weatherData.windSpeed} km/h',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
