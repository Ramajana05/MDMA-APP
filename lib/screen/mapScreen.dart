import 'package:flutter/material.dart';
import 'package:forestapp/widget/sidePanelWidget.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'package:forestapp/widget/tabBarWidget.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:forestapp/widget/mapObjects.dart';
import 'package:geolocator/geolocator.dart';
import 'package:forestapp/dialog/informationDialog.dart';

import '../colors/appColors.dart';
import '../colors/getBatteryColors.dart';
import '../service/loginService.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  Set<Marker> _markers = {};
  CameraPosition _kGooglePlex = const CameraPosition(
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

  List<Map<String, String>> _dropdownItems = [];
  List<Map<String, String>> _dropdownItemss =
      []; // Declare and initialize the variable

  int selectedIndex = -1;
  bool areItemsVisible = false;
  LoginService loginService = LoginService();

  late Circle _currentLocationCircle;
  bool useCurrentLocation = true;
  bool notifyUser = false;
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

    _currentLocationCircle = Circle(
      circleId: CircleId('currentLocation'),
      center: LatLng(0, 0), // Initial center position
      radius: 10, // Adjust the radius as needed
      fillColor: Colors.blue.withOpacity(0.5),
      strokeColor: Colors.blue,
      strokeWidth: 2,
    );
    _dropdownItems = [];
    loadPlacesFromDatabase(); // Load the places from the database immediately
  }

  Future<void> loadPlacesFromDatabase() async {
    try {
      final List<Map<String, String>> loadedPlaces =
          await loginService.loadPlacesFromDatabase();
      setState(() {
        _dropdownItems = loadedPlaces;
      });
    } catch (e) {
      print('Error loading places: $e');
    }
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
            /// Disable dragging gesture to prevent unintended behavior
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: const BorderRadius.only(
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
                          padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: background,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const Positioned.fill(
                                    child: Icon(
                                      Icons.sensors,
                                      size: 32,
                                      color: mapGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    circle.circleId.value,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: textColor),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        'Standort: ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: textColor),
                                      ),
                                      Text(
                                        '${circle.center.latitude}, ',
                                        style: TextStyle(
                                            fontSize: 16, color: textColor),
                                      ),
                                      Text(
                                        '${circle.center.longitude}',
                                        style: TextStyle(
                                            fontSize: 16, color: textColor),
                                      ),
                                      const SizedBox(width: 8),
                                      // Container(
                                      //   color: background,
                                      //   width: 24,
                                      //   height: 24,
                                      //   child: Icon(
                                      //     Icons.battery_full,
                                      //     color: green,
                                      //     size: 16,
                                      //   ),
                                      // ),
                                      // const SizedBox(width: 2),
                                      Icon(
                                        Icons.battery_6_bar_outlined,
                                        color: getBatteryColor(batteryLevel),
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '$batteryLevel%',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: textColor),
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
                            color: background.withOpacity(0.3),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 24,
                            color: buttonTextColor,
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
            onVerticalDragDown: (_) {},
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: background,
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
                          padding: EdgeInsets.fromLTRB(
                              4.0, 16.0, 8.0, 8.0), // Reduce the bottom padding
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: background,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const Positioned.fill(
                                    child: Icon(
                                      Icons.place,
                                      size: 32,
                                      color: mapGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Standort: ${polygon.polygonId.value}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: textColor),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        color: grey,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${polygon.visitors.toString()} Besucher',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: textColor),
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
                            color: background.withOpacity(0.3),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 24,
                            color: buttonTextColor,
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
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle disabled location services
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Handle denied location permission
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      _currentLocationCircle = _currentLocationCircle.copyWith(
        centerParam: LatLng(position.latitude, position.longitude),
      );
      _circles = Set.of([_currentLocationCircle]);
    });

    CameraPosition newPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 15.0,
    );

    _mapController.animateCamera(CameraUpdate.newCameraPosition(newPosition));
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
      backgroundColor: background,
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
                    _mapController = controller;

                    setState(() {
                      _circles = Set.of([_currentLocationCircle]);
                    });
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
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.battery_full,
                      color: primaryGreen,
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
                      color: orange,
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
                      color: red,
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
          //LEGEND
          Positioned(
            bottom: legendPosition,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.person,
                      color: primaryGreen,
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
                      color: primaryVisitorModerateCountColor,
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
                      color: primaryVisitorLowCountColor,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '< 5',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Info
          Positioned(
            top: areItemsVisible ? 120 : 65,
            right: 16,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => InformationDialog(),
                );
              },
              child: const Icon(
                Icons.info_outline,
                size: 30,
                color: const Color.fromARGB(255, 0, 112, 204),
              ),
            ),
          ),
          //currentLocation
          Positioned(
            top: areItemsVisible ? 240 : 180,
            right: 16,
            child: GestureDetector(
              onTap: _moveToCurrentLocation,
              child: Icon(
                Icons.my_location,
                size: 35,
                color: Colors.blue, // Set icon color to blue
              ),
            ),
          ),
          //ForetsVisible
          Positioned(
            top: areItemsVisible ? 180 : 120,
            right: 16,
            child: GestureDetector(
              onTap: () {
                setState(() async {
                  // Toggle visibility state
                  areItemsVisible = !areItemsVisible;
                  final loadedPlaces =
                      await loginService.loadPlacesFromDatabase();
                  setState(() {
                    _dropdownItems = loadedPlaces;
                  });
                });
              },
              child: Icon(
                areItemsVisible ? Icons.forest_outlined : Icons.forest_outlined,
                size: 35,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          //itms forest
          Positioned(
            top: 60,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (areItemsVisible)
                      ..._dropdownItems.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        final isSelected = selectedIndex == index;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                              double latitude = double.parse(item['latitude']!);
                              double longitude =
                                  double.parse(item['longitude']!);

                              _mapController.animateCamera(
                                CameraUpdate.newLatLng(
                                    LatLng(latitude, longitude)),
                              );

                              print('Item clicked: ${item['name']}');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: isSelected
                                          ? primaryAppLightGreen
                                          : const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      item['name'] as String,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: isSelected
                                            ? primaryAppLightGreen
                                            : const Color.fromARGB(
                                                255, 0, 0, 0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    Visibility(
                      visible: areItemsVisible,
                      child: GestureDetector(
                        onTap: () async {
                          final loadedPlaces =
                              await loginService.loadPlacesFromDatabase();
                          setState(() {
                            _dropdownItems = loadedPlaces;
                          });

                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  String newItemName = '';
                                  String latitude = '';
                                  String longitude = '';

                                  return AlertDialog(
                                    title: Text(
                                      'Neues Gebiet',
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          onChanged: (value) {
                                            newItemName = value;
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Name',
                                            fillColor: Colors.white,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              borderSide: const BorderSide(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              borderSide: const BorderSide(
                                                color: primaryAppLightGreen,
                                                width: 2.0,
                                              ),
                                            ),
                                            labelStyle: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                            focusColor: const Color.fromARGB(
                                                255, 40, 233, 127),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Aktueller Standort',
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                ),
                                              ),
                                              Checkbox(
                                                value: useCurrentLocation,
                                                onChanged: (value) {
                                                  setState(() {
                                                    useCurrentLocation = value!;
                                                    if (useCurrentLocation) {
                                                      latitude = '';
                                                      longitude = '';
                                                    }
                                                  });
                                                },
                                                activeColor:
                                                    primaryAppLightGreen,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible: !useCurrentLocation,
                                          child: TextFormField(
                                            onChanged: (value) {
                                              latitude = value.replaceAll(
                                                  RegExp(r'[^0-9]'), '');
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Latitude',
                                              enabled: !useCurrentLocation,
                                              fillColor: Colors.white,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 40, 233, 127),
                                                  width: 2.0,
                                                ),
                                              ),
                                              labelStyle: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                              focusColor: const Color.fromARGB(
                                                  255, 40, 233, 127),
                                            ),
                                            readOnly: useCurrentLocation,
                                            controller: TextEditingController(
                                                text: latitude),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Visibility(
                                          visible: !useCurrentLocation,
                                          child: TextFormField(
                                            onChanged: (value) {
                                              longitude = value.replaceAll(
                                                  RegExp(r'[^0-9]'), '');
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Longitude',
                                              enabled: !useCurrentLocation,
                                              fillColor: Colors.white,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 40, 233, 127),
                                                  width: 2.0,
                                                ),
                                              ),
                                              labelStyle: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                              focusColor: const Color.fromARGB(
                                                  255, 40, 233, 127),
                                            ),
                                            readOnly: useCurrentLocation,
                                            controller: TextEditingController(
                                                text: longitude),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ButtonBar(
                                        alignment: MainAxisAlignment.center,
                                        buttonPadding: EdgeInsets.symmetric(
                                            horizontal:
                                                8.0), // Reduce the horizontal padding of the TextButtons
                                        children: [
                                          TextButton(
                                            child: Text(
                                              'Abbrechen',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(dialogContext).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text(
                                              'Hinzufügen',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  primaryAppLightGreen,
                                            ),
                                            onPressed: () async {
                                              if (newItemName.isEmpty ||
                                                  latitude.isEmpty &&
                                                      !useCurrentLocation ||
                                                  longitude.isEmpty &&
                                                      !useCurrentLocation) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Felder dürfen nicht leer sein'),
                                                  ),
                                                );
                                              } else {
                                                if (useCurrentLocation) {
                                                  // Rest of your code

                                                  Geolocator
                                                          .getCurrentPosition()
                                                      .then((position) {
                                                    final name = newItemName;
                                                    final latitude =
                                                        position.latitude;
                                                    final longitude =
                                                        position.longitude;

                                                    loginService
                                                        .addPlaceFromDatabase(
                                                      name,
                                                      latitude,
                                                      longitude,
                                                    );

                                                    setState(() {
                                                      _dropdownItems.add({
                                                        'Name': name,
                                                        'Latitude':
                                                            latitude.toString(),
                                                        'Longitude': longitude
                                                            .toString(),
                                                      });
                                                    });
                                                  });
                                                } else {
                                                  final lat =
                                                      double.tryParse(latitude);
                                                  final lon = double.tryParse(
                                                      longitude);
                                                  if (lat != null &&
                                                      lon != null) {
                                                    final name = newItemName;
                                                    final latitudeValue = lat;
                                                    final longitudeValue = lon;

                                                    loginService
                                                        .addPlaceFromDatabase(
                                                      newItemName,
                                                      latitudeValue,
                                                      longitudeValue,
                                                    );

                                                    final loadedPlaces =
                                                        await loginService
                                                            .loadPlacesFromDatabase();
                                                    setState(() {
                                                      _dropdownItems =
                                                          loadedPlaces;
                                                    });
                                                  }
                                                }
                                              }

                                              Navigator.of(dialogContext).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Visibility(
                      visible: areItemsVisible,
                      child: GestureDetector(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return FutureBuilder<List<Map<String, String>>>(
                                future: loginService.loadPlacesFromDatabase(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Map<String, String>>>
                                        snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text(
                                          'Failed to load places from the database.'),
                                      actions: [
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(dialogContext).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  } else {
                                    final List<Map<String, String>> places =
                                        snapshot.data ?? [];
                                    String selectedPlace = places.isNotEmpty
                                        ? places[0]['name'] ?? ''
                                        : '';

                                    return StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                        return AlertDialog(
                                          title: Text(
                                            'Gebiet Entfernen',
                                            style: TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          content: SingleChildScrollView(
                                            child: Container(
                                              height:
                                                  50.0, // Adjust the height as needed
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: DropdownButton<String>(
                                                value: selectedPlace,
                                                items: places.map((item) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: item['name'],
                                                    child: Text(
                                                      item['name'] ?? '',
                                                      style: TextStyle(
                                                        fontSize:
                                                            18.0, // Adjust the font size as needed
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedPlace = value ?? '';
                                                  });
                                                },
                                                dropdownColor: Colors
                                                    .white, // Customize the dropdown background color
                                                style: TextStyle(
                                                  fontSize:
                                                      18.0, // Adjust the font size as needed
                                                  color: Colors
                                                      .black, // Customize the text color
                                                ),
                                                underline:
                                                    Container(), // Remove the default underline
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            ButtonBar(
                                              alignment:
                                                  MainAxisAlignment.center,
                                              buttonPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              children: [
                                                TextButton(
                                                  child: Text(
                                                    'Abbrechen',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(dialogContext)
                                                        .pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text(
                                                    'Löschen',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                  ),
                                                  onPressed: () async {
                                                    // Delete the selected item
                                                    setState(() {
                                                      _dropdownItems
                                                          .removeWhere((item) =>
                                                              item['name'] ==
                                                              selectedPlace);
                                                    });

                                                    // Delete the place from the database
                                                    loginService
                                                        .deletePlaceFromDatabase(
                                                            selectedPlace);

                                                    final loadedPlaces =
                                                        await loginService
                                                            .loadPlacesFromDatabase();
                                                    setState(() {
                                                      _dropdownItems =
                                                          loadedPlaces;
                                                    });

                                                    Navigator.of(dialogContext)
                                                        .pop();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: background,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_outlined,
                                  color: red,
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
        return const SizedBox.shrink();
    }
  }
}
