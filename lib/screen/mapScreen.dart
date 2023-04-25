import 'package:flutter/material.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:forestapp/widget/mapObjects.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 227, 227),
      appBar: TopNavBar(
        title: 'KARTE',
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: MapSample(),
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
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(49.120208, 9.273522), // Heilbronn's latitude and longitude
    zoom: 15.0,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(27.2820, 27.9835),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        circles: {
          Circle(
            circleId: CircleId('Sensor 1'),
            center: LatLng(49.120208, 9.273522),
            radius: 12, // in meters
            fillColor: Colors.red.withOpacity(0.5),
            strokeColor: Colors.red,
            strokeWidth: 2,
          ),
          Circle(
            circleId: CircleId('Sensor 2'),
            center: LatLng(49.118576, 9.271999),
            radius: 12, // in meters
            fillColor: Color.fromARGB(255, 128, 243, 33).withOpacity(0.5),
            strokeColor: Color.fromARGB(255, 128, 243, 33),
            strokeWidth: 2,
          ),
          Circle(
            circleId: CircleId('Sensor 3'),
            center: LatLng(49.11924788327113, 9.27132073211473),
            radius: 12, // in meters
            fillColor: Color.fromARGB(255, 128, 243, 33).withOpacity(0.5),
            strokeColor: Color.fromARGB(255, 128, 243, 33),
            strokeWidth: 2,
          ),
          Circle(
            circleId: CircleId('Sensor 4'),
            center: LatLng(49.121971067673584, 9.271998578981089),
            radius: 12, // in meters
            fillColor: Color.fromARGB(255, 243, 159, 33).withOpacity(0.5),
            strokeColor: Color.fromARGB(255, 243, 159, 33),
            strokeWidth: 2,
          ),
        },
        polygons: {
          Polygon(
            polygonId: PolygonId('Standort 1'),
            points: [
              LatLng(49.118219, 9.274715547169121),
              LatLng(49.119357582288536, 9.276210839822777),
              LatLng(49.11837115811956, 9.276424453059038),
              LatLng(49.11738937445778, 9.275313664230321),
            ],
            strokeColor: Color.fromARGB(255, 128, 243, 33),
            strokeWidth: 2,
            fillColor: Color.fromARGB(255, 136, 241, 50).withOpacity(0.3),
          ),
          Polygon(
            polygonId: PolygonId('Standort 2'),
            points: [
              LatLng(49.117960804409414, 9.270505018089207),
              LatLng(49.11757103952385, 9.271826245032099),
              LatLng(49.11674638218748, 9.270723307757986),
              LatLng(49.1170609567584, 9.269654837273738),
            ],
            strokeColor: Color.fromARGB(255, 243, 47, 33),
            strokeWidth: 2,
            fillColor: Color.fromARGB(255, 243, 47, 33).withOpacity(0.3),
          ),
          Polygon(
            polygonId: PolygonId('Standort 3'),
            points: [
              LatLng(49.12362646009464, 9.269988016241872),
              LatLng(49.121522435358635, 9.270527995948981),
              LatLng(49.11969026955464, 9.262876368609966),
              LatLng(49.12153872646519, 9.263944839094),
            ],
            strokeColor: Color.fromARGB(255, 128, 243, 33),
            strokeWidth: 2,
            fillColor: Color.fromARGB(255, 136, 241, 50).withOpacity(0.3),
          ),
          Polygon(
            polygonId: PolygonId('Standort 4'),
            points: [
              LatLng(49.121466, 9.277417),
              LatLng(49.121418, 9.281072),
              LatLng(49.123426, 9.284784),
              LatLng(49.12405, 9.277302),
            ],
            strokeColor: Color.fromARGB(255, 243, 159, 33),
            strokeWidth: 2,
            fillColor: Color.fromARGB(255, 243, 159, 33).withOpacity(0.3),
          ),
        },
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  List<LatLng> _createSquarePoints(
      {required LatLng center, required double length}) {
    final double offset = length / 2;
    final LatLng northEast =
        LatLng(center.latitude + offset, center.longitude + offset);
    final LatLng northWest =
        LatLng(center.latitude + offset, center.longitude - offset);
    final LatLng southEast =
        LatLng(center.latitude - offset, center.longitude + offset);
    final LatLng southWest =
        LatLng(center.latitude - offset, center.longitude - offset);
    return [northEast, northWest, southWest, southEast];
  }
}
