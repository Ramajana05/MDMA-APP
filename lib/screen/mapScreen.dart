import 'package:flutter/material.dart';
import 'package:forestapp/widget/sidePanelWidget.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'package:forestapp/widget/overviewWidget.dart';
import 'package:forestapp/widget/tabBarWidget.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:forestapp/widget/mapObjects.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(49.120208, 9.273522), // Heilbronn's latitude and longitude
    zoom: 15.0,
  );
  late String _selectedTab;
  late Set<Circle> _circles;
  late Set<Polygon> _polygons;
  final Completer<GoogleMapController> _controller = Completer(); // Added

  @override
  void initState() {
    super.initState();
    _selectedTab = 'alle';
    _circles = MapObjects().getCircles();
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
          _circles = MapObjects().getCircles();
          _polygons = MapObjects().getPolygons();
          break;
        case 'standorte':
          _circles = Set<Circle>();
          _polygons = MapObjects().getPolygons();
          break;
        case 'sensoren':
          _circles = MapObjects().getCircles();
          _polygons = Set<Polygon>();
          break;
        default:
          _circles = Set<Circle>();
          _polygons = Set<Polygon>();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidePanel(),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: TopNavBar(
        title: 'KARTE',
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      // Add your body here

      body: Column(children: [
        OverviewContainer(text: "Karten Übersicht"),
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
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Add"),
                content: Text("You pressed the add button!"),
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
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 117, 241, 169),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
    zoom: 15.0,
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
