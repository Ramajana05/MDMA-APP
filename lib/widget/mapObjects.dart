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
  static final CircleData circle1 = CircleData(
    circleId: CircleId('Sensor 1'),
    center: LatLng(49.11924788327113, 9.27132073211473),
    radius: 25,
    fillColor: Color.fromARGB(255, 128, 189, 113).withOpacity(0.2),
    strokeColor: Color.fromARGB(255, 128, 189, 113),
    strokeWidth: 2,
  );

  Set<Circle> getCircless(Function(CircleData) onTap) {
    return Set.from([
      Circle(
        circleId: circle1.circleId,
        center: circle1.center,
        radius: circle1.radius,
        fillColor: circle1.fillColor,
        strokeColor: circle1.strokeColor,
        strokeWidth: circle1.strokeWidth,
        consumeTapEvents: true,
        onTap: () => onTap(circle1),
      ),
      Circle(
        circleId: circle2.circleId,
        center: circle2.center,
        radius: circle2.radius,
        fillColor: circle2.fillColor,
        strokeColor: circle2.strokeColor,
        strokeWidth: circle2.strokeWidth,
        consumeTapEvents: true,
        onTap: () => onTap(circle2),
      ),
      // Add other circles with onTap callback
    ]);
  }

  Set<Polygon> getPolygonss(VoidCallback onTap) {
    return Set.from([
      // Define polygons using the toPolygon method and assign the onTap callback
    ]);
  }

  // Define all objects (circles and polygons)...

  Set<Overlay> getAllObjectss(VoidCallback onTap) {
    return Set.from([
      // Define all objects using the toCircle and toPolygon methods and assign the onTap callback
    ]);
  }

  static final CircleData circle2 = CircleData(
    circleId: CircleId('circle2'),
    center: LatLng(49.12130720429596, 9.276199658137801),
    radius: 25,
    fillColor: Color.fromARGB(255, 128, 189, 113).withOpacity(0.2),
    strokeColor: Color.fromARGB(255, 128, 189, 113),
    strokeWidth: 2,
  );

  static final CircleData circle3 = CircleData(
    circleId: CircleId('circle3'),
    center: LatLng(49.121771, 9.272174),
    radius: 25,
    fillColor: Color.fromARGB(255, 128, 189, 113).withOpacity(0.2),
    strokeColor: Color.fromARGB(255, 128, 189, 113),
    strokeWidth: 2,
  );

  static final CircleData circle4 = CircleData(
    circleId: CircleId('circle4'),
    center: LatLng(49.113963, 9.276469),
    radius: 25,
    fillColor: Color.fromARGB(255, 128, 189, 113).withOpacity(0.2),
    strokeColor: Color.fromARGB(255, 128, 189, 113),
    strokeWidth: 2,
  );

  static final CircleData circle5 = CircleData(
    circleId: CircleId('circle5'),
    center: LatLng(49.119830, 9.273334),
    radius: 25,
    fillColor: Color.fromARGB(255, 128, 189, 113).withOpacity(0.2),
    strokeColor: Color.fromARGB(255, 128, 189, 113),
    strokeWidth: 2,
  );

  /*static const PolygonData polygon1 = PolygonData(
    id: PolygonId('polygon1'),
    points: [
      LatLng(49.119597, 9.277048),
      LatLng(49.119541, 9.283962),
      LatLng(49.116816, 9.285894),
      LatLng(49.116788, 9.277176),
    ],
    fillColor: Color.fromARGB(255, 106, 118, 221),
    strokeColor: Color.fromARGB(255, 124, 113, 189),
    strokeWidth: 2,
  );
  */

  /*static const PolygonData polygon2 = PolygonData(
    id: PolygonId('polygon2'),
    points: [
      LatLng(49.123457, 9.263429),
      LatLng(49.118794, 9.269597),
      LatLng(49.115704, 9.268051),
      LatLng(49.118570, 9.258174),
    ],
    fillColor: Color.fromARGB(255, 158, 221, 106),
    strokeColor: Color.fromARGB(255, 128, 189, 113),
    strokeWidth: 2,
  );
  */

  /*static const PolygonData polygon3 = PolygonData(
    id: PolygonId('Grillplatz'),
    points: [
      LatLng(49.127550, 9.266083),
      LatLng(49.129635, 9.267883),
      LatLng(49.126532, 9.270152),
      LatLng(49.125465, 9.267543),
    ],
    fillColor: Color.fromARGB(255, 106, 156, 221),
    strokeColor: Color.fromARGB(255, 106, 156, 221),
    strokeWidth: 2,
  );
*/
  /* static const PolygonData polygon4 = PolygonData(
    id: PolygonId('Waldheide'),
    points: [
      LatLng(49.133342, 9.272091),
      LatLng(49.132892, 9.279133),
      LatLng(49.123569, 9.276814),
      LatLng(49.123288, 9.272176),
    ],
    fillColor: Color.fromARGB(255, 158, 221, 106),
    strokeColor: Color.fromARGB(255, 128, 189, 113),
    strokeWidth: 2,
  );
  */

  /*static const PolygonData polygon5 = PolygonData(
    id: PolygonId('Grillplatzweg'),
    points: [
      LatLng(49.125444, 9.267543),
      LatLng(49.126525, 9.270119),
      LatLng(49.124285, 9.271537),
      LatLng(49.123955, 9.268477),
    ],
    fillColor: Color.fromARGB(255, 252, 139, 34),
    strokeColor: Color.fromARGB(255, 252, 139, 34),
    strokeWidth: 2,
  );
*/
/*
  static const PolygonData polygon6 = PolygonData(
    id: PolygonId('Jägerhaus'),
    points: [
      LatLng(49.134910, 9.263202),
      LatLng(49.138097, 9.267174),
      LatLng(49.133576, 9.271879),
      LatLng(49.132215, 9.268185),
    ],
    fillColor: Color.fromARGB(255, 252, 139, 34),
    strokeColor: Color.fromARGB(255, 252, 139, 34),
    strokeWidth: 2,
  );
  */

  Set<Circle> getCircles() {
    return Set.from([
      circle1.toCircle(),
      circle2.toCircle(),
      circle3.toCircle(),
      circle4.toCircle(),
      circle5.toCircle(),
    ]);
  }

  Set<Polygon> getPolygons() {
    return Set.from([
      //polygon1.toPolygon(),
      //polygon2.toPolygon(),
    ]);
  }

  Set<Overlay> getAllObjects() {
    return Set.from([
      circle1.toCircle(),
      circle2.toCircle(),
      circle3.toCircle(),
      circle4.toCircle(),
      circle5.toCircle(),
    ]);
  }
}
