import 'package:flutter/material.dart';
import 'package:forestapp/widget/sidePanelWidget.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'package:forestapp/widget/tabBarWidget.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:forestapp/widget/mapObjects.dart';
import 'package:geolocator/geolocator.dart';
import 'package:forestapp/dialog/informationDialog.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(49.120208, 9.273522), // Heilbronn's latitude and longitude
    zoom: 14.0,
  );
  late String _selectedTab;
  late Set<Circle> _circles;
  late Set<Polygon> _polygons;
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    _selectedTab = 'alle';
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
          MapObjects().getPolygons((PolygonData polygon) {
            // Handle the polygon tap here
          }).then((polygons) {
            setState(() {
              _polygons = polygons;
            });
          });
          break;
        case 'standorte':
          MapObjects().getPolygons((PolygonData polygon) {
            // Handle the polygon tap here
          }).then((polygons) {
            setState(() {
              _circles = Set<Circle>();
              _polygons = polygons;
            });
          });
          break;
        case 'sensoren':
          MapObjects().getCircles(_handleCircleTap).then((circles) {
            setState(() {
              _circles = circles;
              _polygons = Set<Polygon>();
            });
          });
          break;
        default:
          setState(() {
            _circles = Set<Circle>();
            _polygons = Set<Polygon>();
          });
          break;
      }
    });
  }

  void _handleCircleTap(CircleData circle) {
    int batteryLevel = circle.battery;

    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        Timer(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });

        return WillPopScope(
          onWillPop: () async {
            return true; // Allow back button to close the bottom sheet
          },
          child: GestureDetector(
            onVerticalDragDown:
                (_) {}, // Disable dragging gesture to prevent unintended behavior
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            circle.circleId.value,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pop(); // Close the bottom sheet
                            },
                            child: Icon(
                              Icons.close,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Standort: ${circle.center.latitude}, ${circle.center.longitude}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.battery_0_bar,
                            color: _getBatteryColor(batteryLevel),
                            size: 16,
                          ),
                          SizedBox(width: 2),
                          Text(
                            '${batteryLevel.toString()}%',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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

  Color _getBatteryColor(int batteryLevel) {
    if (batteryLevel > 60) {
      return Color.fromARGB(255, 19, 240, 30); // Green
    } else if (batteryLevel > 30) {
      return Colors.orange; // Orange
    } else {
      return Colors.red; // Red
    }
  }

  void _handlePolygonTap(PolygonData polygon) {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        Timer(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });

        return WillPopScope(
          onWillPop: () async {
            return true; // Allow back button to close the bottom sheet
          },
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          polygon.polygonId.value,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'You tapped polygon: ${polygon.polygonId.value}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    size: 24,
                  ),
                ),
              ),
            ],
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
      throw 'Location services are disabled.';
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw 'Location permissions are denied.';
      }
    }

    // Get current position
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth =
        20.0 + 8.0 + 16.0 + 20.0 + 8.0 + 16.0 + 20.0 + 8.0 + 16.0;

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
                tabTexts: ['Alle', 'Standorte', 'Sensoren'],
                onTabSelected: _updateSelectedTab,
              ),
              Expanded(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  zoomControlsEnabled: false,
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
                    Icon(
                      Icons.battery_full,
                      color: Color.fromARGB(255, 46, 202, 51),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Voll',
                      style: TextStyle(fontSize: 16),
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
                      style: TextStyle(fontSize: 16),
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
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 46, 202, 51),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '+10',
                      style: TextStyle(fontSize: 16),
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
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 16),
                    Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 170, 169, 169),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Unter 5',
                      style: TextStyle(fontSize: 16),
                    ),
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
                size: 24,
                color: const Color.fromARGB(255, 0, 112, 204),
              ),
            ),
          ),
        ],
      ),
      /*
floatingActionButton: FloatingActionButton(
  onPressed: () {
    // Get current location
    _getCurrentLocation().then((Position position) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Aktueller Standort"),
            content: Text(
                "Latitude: ${position.latitude}\nLongitude: ${position.longitude}"),
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }).catchError((e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to get current location: $e"),
            actions: <Widget>[
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  },
  child: Icon(Icons.location_on),
  backgroundColor: Color.fromARGB(255, 117, 241, 169),
),
floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
*/
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

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(49.120208, 9.273522), // Heilbronn's latitude and longitude
    zoom: 10.0,
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
