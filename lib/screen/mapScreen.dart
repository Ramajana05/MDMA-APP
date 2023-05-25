import 'package:flutter/material.dart';
import 'package:forestapp/widget/sidePanelWidget.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'package:forestapp/widget/tabBarWidget.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:forestapp/widget/mapObjects.dart';
import 'package:geolocator/geolocator.dart';

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
  final Completer<GoogleMapController> _controller = Completer(); // Added

  @override
  void initState() {
    super.initState();
    _selectedTab = 'alle';
    _circles = MapObjects().getCircless(_handleCircleTap);
    _polygons = MapObjects().getPolygons();
  }

  void _updateSelectedTab(int index) {
    setState(() {
      _selectedTab = index == 0
          ? 'alle'
          : index == 1
              ? 'standorte'
              : 'sensoren';
      switch (_selectedTab) {
        case 'alle':
          _circles = MapObjects().getCircless(_handleCircleTap);
          _polygons = MapObjects().getPolygons();
          break;
        case 'standorte':
          _circles = Set<Circle>();
          _polygons = MapObjects().getPolygons();
          break;
        case 'sensoren':
          _circles = MapObjects().getCircless(_handleCircleTap);
          _polygons = Set<Polygon>();
          break;
        default:
          _circles = Set<Circle>();
          _polygons = Set<Polygon>();
          break;
      }
    });
  }

  void _handleCircleTap(CircleData circle) {
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
                          circle.circleId.value,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'You tapped circle: ${circle.circleId.value}',
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
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.red,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Red',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 16),
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Orange',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 16),
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.green,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Green',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
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
  void didUpdateWidget(covariant MapSample oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      circles = mapObjects.getCircles();
      polygons = mapObjects.getPolygons();
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
