import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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
}

class PolygonData {
  final PolygonId id;
  final List<LatLng> points;
  final Color fillColor;
  final Color strokeColor;
  final int strokeWidth;

  const PolygonData({
    required this.id,
    required this.points,
    required this.fillColor,
    required this.strokeColor,
    required this.strokeWidth,
  });

  Polygon toPolygon() {
    return Polygon(
      polygonId: id,
      points: points,
      fillColor: fillColor,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
    );
  }
}

class MapObjects {
  bool visible = true;

  static final CircleData circle1 = CircleData(
    circleId: CircleId('circle1'),
    center: LatLng(49.11924788327113, 9.27132073211473),
    radius: 15,
    fillColor: Color.fromARGB(255, 128, 243, 33).withOpacity(0.5),
    strokeColor: Color.fromARGB(255, 128, 243, 33),
    strokeWidth: 2,
  );

  static final CircleData circle2 = CircleData(
    circleId: CircleId('circle2'),
    center: LatLng(49.12130720429596, 9.276199658137801),
    radius: 20,
    fillColor: Color.fromARGB(255, 255, 0, 0).withOpacity(0.5),
    strokeColor: Color.fromARGB(255, 255, 0, 0),
    strokeWidth: 2,
  );

  static const PolygonData polygon1 = PolygonData(
    id: PolygonId('polygon1'),
    points: [
      LatLng(49.118219, 9.274715547169121),
      LatLng(49.119357582288536, 9.276210839822777),
      LatLng(49.11837115811956, 9.276424453059038),
      LatLng(49.11738937445778, 9.275313664230321),
    ],
    fillColor: Color.fromARGB(255, 136, 241, 50),
    strokeColor: Color.fromARGB(255, 33, 219, 243),
    strokeWidth: 2,
  );

  static const PolygonData polygon2 = PolygonData(
    id: PolygonId('polygon2'),
    points: [
      LatLng(49.117632, 9.277162),
      LatLng(49.117918, 9.277638),
      LatLng(49.117568, 9.278178),
      LatLng(49.117234, 9.277714),
    ],
    fillColor: Color.fromARGB(255, 255, 66, 66),
    strokeColor: Color.fromARGB(255, 255, 97, 97),
    strokeWidth: 2,
  );

  Set<Circle> getCircles() {
    return Set.from([
      if (visible) circle1.toCircle(),
      if (visible) circle2.toCircle(),
    ]);
  }

  Set<Polygon> getPolygons() {
    return Set.from([
      if (visible) polygon1.toPolygon(),
      if (visible) polygon2.toPolygon(),
    ]);
  }

  Set<Overlay> getAllObjects() {
    return Set.from([
      if (visible) circle1.toCircle(),
      if (visible) circle2.toCircle(),
      if (visible) polygon1.toPolygon(),
      if (visible) polygon2.toPolygon(),
    ]);
  }
}
