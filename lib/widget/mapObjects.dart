import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:forestapp/service/loginService.dart';
import '../colors/appColors.dart';

class CircleData {
  final CircleId circleId;
  final LatLng center;
  final double radius;
  final Color fillColor;
  final Color strokeColor;
  final int strokeWidth;
  final int battery;

  CircleData({
    required this.circleId,
    required this.center,
    required this.radius,
    required this.fillColor,
    required this.strokeColor,
    required this.strokeWidth,
    required this.battery,
  });

  Circle toCircle() {
    return Circle(
      circleId: circleId,
      center: center,
      radius: radius,
      fillColor: fillColor,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
    );
  }

  factory CircleData.fromMap(Map<String, dynamic> map) {
    Color fillColor;
    Color strokeColor;

    final batteryLevel = map['Battery'];

    if (batteryLevel >= 90) {
      fillColor = primaryGreen.withOpacity(0.4);
      strokeColor = primaryGreen;
    } else if (batteryLevel >= 75) {
      fillColor = primaryGreen.withOpacity(0.4);
      strokeColor = primaryGreen;
    } else if (batteryLevel >= 60) {
      fillColor = orange.withOpacity(0.4);
      strokeColor = orange;
    } else if (batteryLevel >= 45) {
      fillColor = orange.withOpacity(0.4);
      strokeColor = orange;
    } else if (batteryLevel >= 30) {
      fillColor = red.withOpacity(0.4);
      strokeColor = red;
    } else if (batteryLevel >= 15) {
      fillColor = red.withOpacity(0.4);
      strokeColor = red;
    } else if (batteryLevel >= 5) {
      fillColor = red.withOpacity(0.4);
      strokeColor = red;
    } else {
      fillColor = red.withOpacity(0.4);
      strokeColor = red;
    }

    return CircleData(
      circleId: CircleId(map['Name']),
      center: LatLng(map['Latitude'], map['Longitude']),
      radius: 27,
      battery: batteryLevel,
      fillColor: fillColor,
      strokeColor: strokeColor,
      strokeWidth: 2,
    );
  }
}

class PolygonData {
  final PolygonId polygonId;
  final List<LatLng> points;
  final Color fillColor;
  final Color strokeColor;
  final int strokeWidth;
  final int visitors;

  const PolygonData({
    required this.polygonId,
    required this.points,
    required this.fillColor,
    required this.strokeColor,
    required this.strokeWidth,
    required this.visitors,
  });

  factory PolygonData.fromMap(Map<String, dynamic> map) {
    Color fillColor;
    Color strokeColor;
    final visitors = map['Visitor'];

    if (visitors < 5) {
      fillColor = primaryVisitorLowCountColor;
      strokeColor = primaryVisitorLowCountColor;
    } else if (visitors >= 5 && visitors <= 10) {
      fillColor = primaryVisitorModerateCountColor;
      strokeColor = primaryVisitorModerateCountColor;
    } else {
      fillColor = primaryGreen;
      strokeColor = primaryGreen;
    }

    return PolygonData(
      polygonId: PolygonId(map['Name']),
      points: [
        LatLng(map['Latitude'], map['Longitude']),
        LatLng(map['Latitude2'], map['Longitude2']),
        LatLng(map['Latitude3'], map['Longitude3']),
        LatLng(map['Latitude4'], map['Longitude4']),
      ],
      visitors: visitors,
      fillColor: fillColor.withOpacity(0.5),
      strokeColor: strokeColor,
      strokeWidth: 2,
    );
  }

  Polygon toPolygon() {
    return Polygon(
      polygonId: polygonId,
      points: points,
      fillColor: fillColor,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
    );
  }
}

class MapObjects {
  Future<Set<Circle>> getCircles(Function(CircleData) onTap) async {
    LoginService loginService = LoginService();
    final fetchedCircles = await loginService.fetchCirclesFromDatabase();

    return Set.from(fetchedCircles.map((circle) {
      return Circle(
        circleId: circle.circleId,
        center: circle.center,
        radius: circle.radius,
        fillColor: circle.fillColor,
        strokeColor: circle.strokeColor,
        strokeWidth: circle.strokeWidth,
        consumeTapEvents: true,
        onTap: () => onTap(circle),
      );
    }));
  }

  Future<Set<Polygon>> getPolygons(Function(PolygonData) onTap) async {
    LoginService loginService = LoginService();
    final fetchedPolygons = await loginService.fetchPolygonsFromDatabase();

    return Set.from(fetchedPolygons.map((polygonData) {
      Polygon polygon = Polygon(
        polygonId: polygonData.polygonId,
        points: polygonData.points,
        fillColor: polygonData.fillColor,
        strokeColor: polygonData.strokeColor,
        strokeWidth: polygonData.strokeWidth,
        consumeTapEvents: true,
        onTap: () => onTap(polygonData),
      );

      return polygon;
    }));
  }

  LatLng calculatePolygonCenter(List<LatLng> points) {
    double latitude = 0;
    double longitude = 0;

    for (LatLng point in points) {
      latitude += point.latitude;
      longitude += point.longitude;
    }

    int totalPoints = points.length;
    latitude /= totalPoints;
    longitude /= totalPoints;

    return LatLng(latitude, longitude);
  }

  Set<Circle> getCircless(Function(CircleData) onTap) {
    return Set.from([
      // Add other circles with onTap callback
    ]);
  }

  // ... existing code ...

  Set<Polygon> getPolygonss(Function(PolygonData) onTap) {
    return Set.from([
      // Define polygons using the toPolygon method and assign the onTap callback
    ]);
  }

  Set<Overlay> getAllObjectss(VoidCallback onTap) {
    return Set.from([
      // Define all objects using the toCircle and toPolygon methods and assign the onTap callback
    ]);
  }

  Set<Overlay> getAllObjects() {
    return Set.from([]);
  }
}
