import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:forestapp/widget/mapObjects.dart';

class CircleDataProvider extends ChangeNotifier {
  List<CircleData> _circles = [];

  List<CircleData> get circles => _circles;

  void addCircle(CircleData circle) {
    _circles.add(circle);
    notifyListeners();
  }

  void removeCircle(CircleData circle) {
    _circles.remove(circle);
    notifyListeners();
  }

/* 
  Future<void> loadCircles() async {
    // Load circles from local storage or database here
    // For example, you can use the shared_preferences package
    // to load data from local storage
    final List<String> circleStrings =
        sharedPreferences.getStringList('circles') ?? [];
    _circles = circleStrings
        .map((circleString) => CircleData.fromMap(jsonDecode(circleString)))
        .toList();
    notifyListeners();
  }

  Future<void> saveCircles() async {
    // Save circles to local storage or database here
    // For example, you can use the shared_preferences package
    // to save data to local storage
    final List<String> circleStrings =
        _circles.map((circle) => jsonEncode(circle.toMap())).toList();
    await sharedPreferences.setStringList('circles', circleStrings);
  }
  */
}
