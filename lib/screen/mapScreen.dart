import 'package:flutter/material.dart';
import 'package:forestapp/widget/sidePanelWidget.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'package:forestapp/widget/tabBarWidget.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:forestapp/widget/mapObjects.dart';
import 'package:geolocator/geolocator.dart';
import 'package:forestapp/dialog/informationDialog.dart';

import '../colors/getBatteryColors.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  Set<Marker> _markers = {};
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(49.120208, 9.273522), // Heilbronn's latitude and longitude
    zoom: 15.0,
  );
  late String _selectedTab;
  late Set<Circle> _circles;
  late Set<Polygon> _polygons;
  final Completer<GoogleMapController> _controller = Completer();

  late GoogleMapController _mapController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> dropdownItems = ['Wald', 'Current Location'];
  String? selectedDropdownItem;

  @override
  void initState() {
    super.initState();
    _markers = {};
    _selectedTab = 'alle';
    _circles = <Circle>{};
    _polygons = <Polygon>{};

    MapObjects().getPolygons(_handlePolygonTap).then((polygons) {
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

  void _updateSelectedTab(int index) async {
    setState(() {
      _selectedTab = index == 0
          ? 'alle'
          : index == 1
              ? 'standorte'
              : 'sensoren';
      switch (_selectedTab) {
        case 'alle':
          MapObjects().getCircles(_handleCircleTap).then((circles) {
            setState(() {
              _circles = circles;
            });
          });
          MapObjects().getPolygons(_handlePolygonTap).then((polygons) {
            setState(() {
              _polygons = polygons;
            });
          });
          break;
        case 'standorte':
          MapObjects().getPolygons(_handlePolygonTap).then((polygons) {
            setState(() {
              _circles = <Circle>{};
              _polygons = polygons;
            });
          });
          break;
        case 'sensoren':
          MapObjects().getCircles(_handleCircleTap).then((circles) {
            setState(() {
              _circles = circles;
              _polygons = <Polygon>{};
            });
          });
          break;
        default:
          setState(() {
            _circles = <Circle>{};
            _polygons = <Polygon>{};
          });
          break;
      }
    });
  }

  void _handleCircleTap(CircleData circle) {
    int batteryLevel = circle.battery;

    showBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        Timer(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });

        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: GestureDetector(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(4.0, 16.0, 8.0, 8.0),
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const Positioned.fill(
                                  child: Icon(
                                    Icons.sensors,
                                    size: 32,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    circle.circleId.value,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Text(
                                        'Standort: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${circle.center.latitude}, ',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        '${circle.center.longitude}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        width: 24,
                                        height: 24,
                                        child: const Icon(
                                          Icons.battery_full,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      Icon(
                                        Icons.battery_6_bar_outlined,
                                        color: getBatteryColor(batteryLevel),
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '$batteryLevel%',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 7.0,
                      right: 8.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // Close the bottom sheet
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.3),
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 24,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handlePolygonTap(PolygonData polygon) {
    showBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        Timer(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });

        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: GestureDetector(
            onVerticalDragDown: (_) {},
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              4.0, 16.0, 8.0, 8.0), // Reduce the bottom padding
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Positioned.fill(
                                  child: Icon(
                                    Icons.place,
                                    size: 32,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Standort: ${polygon.polygonId.value}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        '${polygon.visitors.toString()} Besucher',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 7.0,
                      right: 8.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // Close the bottom sheet
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.3),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 24,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Standort Service ist ausgeschaltet';
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw 'Standort Service wurde abgelehnt';
      }
    }

    // Get current position
    return await Geolocator.getCurrentPosition();
  }

  void _moveToCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Show an alert or toast message to inform the user that location services are disabled
      return;
    }

    // Request location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      // Update the camera position with the current location
      _kGooglePlex = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.0,
      );
    });

    // Move the map camera to the current location
    _mapController.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth =
        20.0 + 8.0 + 16.0 + 20.0 + 8.0 + 16.0 + 20.0 + 8.0 + 16.0;
    bool showBatteryLegend = _selectedTab == 'sensoren';
    bool showPersonLegend = _selectedTab == 'standorte';
    bool showBothLegends = _selectedTab == 'alle';
    double legendPosition = showPersonLegend ? 2 : 30;

    return Scaffold(
      drawer: SidePanel(),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: TopNavBar(
        title: 'KARTE',
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: Stack(
        children: [
          Column(
            children: [
              TabBarWidget(
                tabTexts: const ['Alle', 'Standorte', 'Sensoren'],
                onTabSelected: _updateSelectedTab,
              ),
              Expanded(
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
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 2,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (showBatteryLegend || showBothLegends) ...[
                      Icon(
                        Icons.battery_full,
                        color: Color.fromARGB(255, 46, 202, 51),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Voll',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.battery_5_bar,
                        color: Colors.orange,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Mittel',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.battery_2_bar,
                        color: Colors.red,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Niedrig',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: legendPosition,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (showPersonLegend || showBothLegends) ...[
                      Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 46, 202, 51),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '+10',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 128, 197, 130),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '5 - 10',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 170, 169, 169),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '< 5',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 16,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => InformationDialog(),
                );
              },
              child: Icon(
                Icons.info_outline,
                size: 30,
                color: const Color.fromARGB(255, 0, 112, 204),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  final String selectedTab; // Added
  const MapSample({Key? key, required this.selectedTab}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  MapObjects mapObjects = MapObjects();
  Set<Circle> circles = Set<Circle>();
  Set<Polygon> polygons = Set<Polygon>();
  Set<Marker> _markers = {};
  late GoogleMapController _mapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(49.120208, 9.273522), // Heilbronn's latitude and longitude
    zoom: 1.0,
  );

  @override
  void didUpdateWidget(covariant MapSample oldWidget) async {
    super.didUpdateWidget(oldWidget);
    setState(() async {
      circles = await mapObjects.getCircles((circleData) {
        // Define the onTap functionality for the circle here
        print('You tapped circle: ${circleData.circleId.value}');
      });
      polygons = await mapObjects.getPolygons((polygonData) {
        // Define the onTap functionality for the polygon here
        print('You tapped polygon: ${polygonData.polygonId.value}');
      });
      print('Circles: $circles');
      print('Polygons: $polygons');
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.selectedTab) {
      case 'alle':
        // show all circles and polygons
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _mapController = controller;
          },
          circles: circles,
          polygons: polygons,
        );
      case 'standorte':
// show only circles
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          circles: circles,
        );
      case 'sensoren':
// show only polygons
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          polygons: polygons,
        );
      default:
        return SizedBox.shrink();
    }
  }
}
