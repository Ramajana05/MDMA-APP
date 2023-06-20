import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:forestapp/screen/statisticScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:forestapp/widget/warningWidget.dart';

import '../colors/appColors.dart';
import '../Model/ChartData.dart';
import '../widget/sidePanelWidget.dart';
import '../widget/topNavBar.dart';
import '../widget/bottomNavBar.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:forestapp/screen/mapScreen.dart';

import 'package:forestapp/widget/mapObjects.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var currentVisitors = 48;
  var maxVisitors = 70;

  var currentSensors = 9;
  var maxSensors = 10;

  var currentTemperature = 0.0;
  var maxTemperature = 0.0;

  var airHumidity = 0.0;

  bool showWarningWidget = true;
  bool showMap = true;
  bool showStatistics = true;
  bool showWeatherForecast = true;

  late List<ChartData> visitorChartDaily;
  late List<ChartData> tempChartDaily;
  late List<ChartData> airHumidityChartDaily;
  late List<ChartData> rainPercentChartDaily;

  late PageController _pageController;
  int _currentPage = 0;
  Timer? _scrollTimer;
  bool _userScrolled = false;

  String dailyVisitors = "Gestrige Besucher";
  String dailyTemps = "Gestrige Temperatur";
  String dailyAir = 'Gestrige Luftfeuchtigkeit';

  late List<Statistic> _statistics;

  List<WeatherItem> weatherForecast = [];

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(49.120208, 9.273522), // Heilbronn's latitude and longitude
    zoom: 14.5,
  );
  Set<Marker> _markers = {}; // Define the markers set
  Set<Circle> _circles = {}; // Define the circles set
  Set<Polygon> _polygons = {}; // Define the polygons set
  late GoogleMapController _mapController;

  Future<List<WeatherItem>> fetchWeatherData() async {
    final response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/forecast.json?key=27582f8ca711490a986134852231605&q=Heilbronn&days=3&aqi=no&alerts=no'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final weatherData = data['current'];
      final forecastData = data['forecast']['forecastday'];

      if (weatherData != null && forecastData != null) {
        final airWHumidity =
            (weatherData['humidity'] as num?)?.toDouble() ?? 0.0;
        final temperature = (weatherData['temp_c'] as num?)?.toDouble() ?? 0.0;

        for (final forecastDay in forecastData) {
          final maxTempValue =
              (forecastDay['day']['maxtemp_c'] as num?)?.toDouble() ?? 0.0;

          maxTemperature = maxTempValue;
        }

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
          airHumidity = airWHumidity;
          currentTemperature = temperature;
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

  void _handleUserScroll() {
    setState(() {
      _userScrolled = true;
    });
    _scrollTimer?.cancel();
    _scrollTimer = Timer(Duration(seconds: 3), () {
      _startAutoScroll();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();

    _statistics = [
      Statistic(dailyVisitors),
      Statistic(dailyTemps),
      Statistic(dailyAir),
    ];
    _pageController = PageController(initialPage: _statistics.length);
    _currentPage = _statistics.length;
    _startAutoScroll();
    generateData();

    super.initState();

    // Initialize _markers set
    _markers = {};
    _circles = Set<Circle>();
    _polygons = Set<Polygon>();

    MapObjects().getPolygons((PolygonData polygon) {}).then((polygons) {
      setState(() {
        _polygons = polygons;
      });
    });
    MapObjects().getCircles(_handleCircleTap).then((circles) {
      setState(() {
        _circles = circles;
      });
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    _pageController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidePanel(),
      backgroundColor: Colors.white,
      appBar: const TopNavBar(
        title: 'DASHBOARD',
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight *
                    0.5, // Set the minimum height to 60% of the screen height
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          // Visitors
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CustomBottomTabBar(
                                                  trans_index: 1)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryVisitorColor
                                            .withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildCircularChart(
                                        context,
                                        Colors.transparent,
                                        primaryVisitorShadowColor,
                                        primaryVisitorColor,
                                        maxVisitors.toDouble(),
                                        currentVisitors.toInt(),
                                        [
                                          Icons.person,
                                        ],
                                        "",
                                      ),
                                      const SizedBox(height: 8),
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 12.0),
                                        child: Text(
                                          'Besucher',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          /// Sensor
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CustomBottomTabBar(
                                                  trans_index: 4)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryGreen.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildCircularChart(
                                        context,
                                        Colors.transparent,
                                        lightGreen,
                                        primaryGreen,
                                        maxSensors.toDouble(),
                                        currentSensors.toInt(),
                                        [
                                          Icons.sensors,
                                        ],
                                        "",
                                      ),
                                      const SizedBox(height: 8),
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 12.0),
                                        child: Text(
                                          'Sensoren',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Temperature
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CustomBottomTabBar(
                                                  trans_index: 1)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildCircularChart(
                                        context,
                                        Colors.transparent,
                                        lightRed,
                                        Colors.red,
                                        maxTemperature,
                                        currentTemperature.toInt(),
                                        [
                                          Icons.thermostat,
                                        ],
                                        "°C",
                                      ),
                                      const SizedBox(height: 8),
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 12.0),
                                        child: Text(
                                          'Temperatur',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          /// Air Humidity
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CustomBottomTabBar(
                                                  trans_index: 1)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildCircularChart(
                                        context,
                                        Colors.transparent,
                                        lightBlue,
                                        Colors.blue,
                                        100,
                                        airHumidity.toInt(),
                                        [Icons.water_drop_outlined],
                                        "%",
                                      ),
                                      const SizedBox(height: 8),
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 12.0),
                                        child: Text(
                                          'Luftfeuchtigkeit',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //Map
                  const SizedBox(height: 15.0),
                  Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 0.15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CustomBottomTabBar(trans_index: 2)));
                            },
                            child: const Text(
                              "Karte",
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
                                showMap = !showMap;
                              });
                            },
                            icon: Icon(
                              showMap
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: showMap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {},
                            child: GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: _kGooglePlex,
                              zoomControlsEnabled: false,
                              markers: _markers,
                              circles: _circles,
                              polygons: _polygons,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                              onCameraMove: (CameraPosition position) {
                                // Handle camera movements if needed
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  // News
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CustomBottomTabBar(trans_index: 4)));
                    },
                    child: Container(
                      height: 40,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Neuigkeiten",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
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
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                color: Colors.black,
                                size: 30.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: showWarningWidget,
                    child: WarningWidget(
                      message:
                          'Es wurde ein neuer Sensor am 06.06.2023 um 14:34 Uhr hinzugefügt',
                      isWarnung: false,
                      iconColor: darkBlue,
                    ),
                  ),
                  Visibility(
                    visible: showWarningWidget,
                    child: WarningWidget(
                      message: 'Der Sensor ST342 hat kaum noch Akkulaufzeit',
                      isWarnung: true,
                      iconColor: darkRed,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  // Statistics
                  Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CustomBottomTabBar(trans_index: 1)));
                            },
                            child: const Text(
                              "Statistiken",
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
                                showStatistics = !showStatistics;
                              });
                            },
                            icon: Icon(
                              showStatistics
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CustomBottomTabBar(trans_index: 1)));
                    },
                    child: Visibility(
                      visible: showStatistics,
                      child: Container(
                        color: Colors.white,
                        height: 250,
                        child: Stack(
                          children: [
                            PageView.builder(
                              controller: _pageController,
                              itemCount: _statistics.length * 3,
                              onPageChanged: (int index) {
                                setState(() {
                                  _currentPage = index %
                                      _statistics
                                          .length; // Adjust the current page index
                                });
                                _handleUserScroll();
                              },
                              itemBuilder: (BuildContext context, int index) {
                                // Adjust the index to wrap around the statistics list
                                int adjustedIndex = index % _statistics.length;
                                return _buildStatisticItem(
                                    _statistics[adjustedIndex]);
                              },
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: _buildIndicator(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Weather Forecast
                  Container(
                    height: 70,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 8.3),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showWeatherForecast = !showWeatherForecast;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Wettervorhersage",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Icon(
                              showWeatherForecast
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: showWeatherForecast,
                    child: Container(
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _startAutoScroll() {
    _scrollTimer?.cancel();
    _scrollTimer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (!_userScrolled) {
        if (_currentPage < _statistics.length * 3 - 1) {
          _currentPage++;
        } else {
          _currentPage = _statistics.length;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _userScrolled = false; // Reset the user scrolling flag
      }
    });
  }

  void generateData() {
    visitorChartDaily = generateChartData(7, (hour) {
      return ChartData(getHours(hour + 6), Random().nextInt(50) + 100);
    });

    tempChartDaily = generateChartData(7, (hour) {
      return ChartData(getHours(hour + 6), Random().nextInt(15) - 5);
    });

    airHumidityChartDaily = generateChartData(7, (hour) {
      return ChartData(getHours(hour + 6), Random().nextInt(10) + 50);
    });

    rainPercentChartDaily = generateChartData(7, (hour) {
      return ChartData(getHours(hour + 6), Random().nextInt(40) + 10);
    });
  }

  List<ChartData> generateChartData(
      int count, ChartData Function(int) generator) {
    return List.generate(count, generator);
  }

  String getHours(int hour) {
    if (hour >= 6 && hour <= 12) {
      String hourString = hour.toString().padLeft(2, '0');
      return '$hourString:00';
    }
    return '';
  }

  void _handleCircleTap(CircleData circle) {
    int batteryLevel = circle.battery;
  }

  Widget _buildIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_statistics.length, (index) {
          return Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == index ? Colors.blue : Colors.grey,
            ),
          );
        }),
      ),
    );
  }

  Widget buildChartWidget(
    List<ChartData> chartData,
    Color chartColor,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 5,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          crossesAt: 0,
          placeLabelsNearAxisLine: false,
          axisLine: const AxisLine(color: Colors.black, width: 1.5),
          labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
          desiredIntervals: 12,
        ),
        primaryYAxis: NumericAxis(
          labelFormat: (chartData == airHumidityChartDaily)
              ? '{value}%'
              : (chartData == tempChartDaily)
                  ? '{value}°C'
                  : '',
          majorTickLines:
              const MajorTickLines(size: 6, width: 2, color: Colors.black),
          axisLine: const AxisLine(color: Colors.black, width: 1.5),
          labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
        ),
        series: <ChartSeries>[
          LineSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            markerSettings: const MarkerSettings(
              borderColor: Colors.deepPurple,
              isVisible: true,
              color: Colors.grey,
              shape: DataMarkerType.circle,
            ),
            color: chartColor,
            dataLabelMapper: (ChartData data, _) => '${data.y}',
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticItem(Statistic statistic) {
    Widget chartWidget = Container();

    List<Map<String, dynamic>> statistics = [
      {
        'title': dailyVisitors,
        'chartData': visitorChartDaily,
        'chartColor': primaryVisitorColor,
      },
      {
        'title': dailyTemps,
        'chartData': tempChartDaily,
        'chartColor': primaryTempColor,
      },
      {
        'title': dailyAir,
        'chartData': airHumidityChartDaily,
        'chartColor': primaryHumidityColor,
      },
    ];

    for (var data in statistics) {
      if (statistic.title == data['title']) {
        chartWidget = buildChartWidget(
          data['chartData'],
          data['chartColor'],
        );
        break;
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              statistic.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            chartWidget,
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
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10), // Adjust the border radius as needed
      ),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
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

Widget _buildCircularChart(
  BuildContext context,
  Color chartColor,
  Color trackColor,
  Color pointColor,
  double maxValue,
  int value,
  List<IconData> icons,
  String additionalString,
) {
  final availableWidth = MediaQuery.of(context).size.width;
  final availableHeight = MediaQuery.of(context).size.height;

  // Calculate the desired size for the circular chart
  final chartSize = availableWidth < availableHeight
      ? availableWidth * 0.4
      : availableHeight * 0.3;

  return Container(
    width: chartSize,
    height: chartSize,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: chartColor,
          spreadRadius: 3,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Stack(
      children: [
        SfCircularChart(
          series: <CircularSeries<_ChartData, String>>[
            RadialBarSeries<_ChartData, String>(
              maximumValue: maxValue.toDouble(),
              radius: '170%',
              gap: '85%',
              dataSource: [
                _ChartData(
                  'Value',
                  value.toDouble(),
                  pointColor,
                ),
              ],
              cornerStyle: CornerStyle.bothCurve,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              pointColorMapper: (_ChartData data, _) => data.color,
              trackColor: trackColor,
            ),
          ],
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${value.toString()}$additionalString',
                  style: TextStyle(
                    fontSize: chartSize * 0.20,
                    fontWeight: FontWeight.bold,
                    color: pointColor,
                  ),
                ),
                const SizedBox(height: 8),
                Icon(
                  icons[value % icons.length],
                  size: chartSize * 0.2,
                  color: pointColor,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class Statistic {
  final String title;

  Statistic(this.title);
}
