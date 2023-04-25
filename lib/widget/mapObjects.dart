import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CircleData {
  final CircleId id;
  final LatLng center;
  final double radius;
  final Color fillColor;
  final Color strokeColor;
  final double strokeWidth;

  const CircleData({
    required this.id,
    required this.center,
    required this.radius,
    required this.fillColor,
    required this.strokeColor,
    required this.strokeWidth,
  });
}

class PolygonData {
  final PolygonId id;
  final List<LatLng> points;
  final Color fillColor;
  final Color strokeColor;
  final double strokeWidth;

  const PolygonData({
    required this.id,
    required this.points,
    required this.fillColor,
    required this.strokeColor,
    required this.strokeWidth,
  });
}

class MapObjects {
  static const CircleData circle1 = CircleData(
    id: CircleId('circle1'),
    center: LatLng(49.140287, 9.219953),
    radius: 5,
    fillColor: Colors.red,
    strokeColor: Colors.red,
    strokeWidth: 2,
  );

  static const PolygonData polygon1 = PolygonData(
    id: PolygonId('polygon1'),
    points: [
      LatLng(49.140287, 9.218493),
      LatLng(49.140431, 9.219608),
      LatLng(49.139823, 9.219762),
      LatLng(49.139678, 9.218647),
    ],
    fillColor: Color.fromARGB(255, 136, 241, 50),
    strokeColor: Color.fromARGB(255, 128, 243, 33),
    strokeWidth: 2,
  );
}
