import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

import 'package:forestapp/service/loginService.dart';

class CircleData {
  final CircleId circleId;
  final LatLng center;
  final double radius;
  final Color fillColor;
  final Color strokeColor;
  final int strokeWidth;

  CircleData({
    required this.circleId,
    required this.center,
    required this.radius,
    required this.fillColor,
    required this.strokeColor,
    required this.strokeWidth,
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
    return CircleData(
      circleId: CircleId(map['Name']),
      center: LatLng(map['Latitude'], map['Longitude']),
      radius: 25,
      fillColor: Color.fromARGB(255, 128, 189, 113).withOpacity(0.2),
      strokeColor: Color.fromARGB(255, 128, 189, 113),
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

  const PolygonData({
    required this.polygonId,
    required this.points,
    required this.fillColor,
    required this.strokeColor,
    required this.strokeWidth,
  });

  factory PolygonData.fromMap(Map<String, dynamic> map) {
    return PolygonData(
      polygonId: PolygonId(map['Name']),
      points: [
        LatLng(map['Latitude'], map['Longitude']),
        LatLng(map['Latitude2'], map['Longitude2']),
        LatLng(map['Latitude3'], map['Longitude3']),
        LatLng(map['Latitude4'], map['Longitude4']),
      ],
      fillColor: Color.fromARGB(255, 158, 221, 106),
      strokeColor: Color.fromARGB(255, 128, 189, 113),
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
      // Create a new instance of Polygon using the PolygonData
      Polygon polygon = Polygon(
        polygonId: polygonData.polygonId,
        points: polygonData.points,
        fillColor: polygonData.fillColor,
        strokeColor: polygonData.strokeColor,
        strokeWidth: polygonData.strokeWidth,
        onTap: () => onTap(polygonData),
      );
      return polygon;
    }));
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
