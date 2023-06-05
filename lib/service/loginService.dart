import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:forestapp/widget/mapObjects.dart';

class LoginService {
  Future<Database> _initDatabase() async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, 'MDMA.db');

      final databaseExists = await File(path).exists();

      if (!databaseExists) {
        final dbAssetPath = await _getDatabaseAssetPath();
        await _copyDatabase(dbAssetPath, path);
      }

      final database = await openDatabase(path);
      return database;
    } catch (e) {
      // Handle any errors that occur during database initialization
      print('Database initialization failed: $e');
      rethrow;
    }
  }

  Future<String> _getDatabaseAssetPath() async {
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final manifest = json.decode(manifestContent) as Map<String, dynamic>;
      final dbPath = manifest.keys
          .firstWhere((key) => key.contains('assets/database/MDMA.db'));
      return dbPath;
    } catch (e) {
      // Handle any errors related to loading the asset manifest
      print('Error loading database asset path: $e');
      rethrow;
    }
  }

  Future<void> _copyDatabase(String dbAssetPath, String dbPath) async {
    try {
      final byteData = await rootBundle.load(dbAssetPath);
      final bytes = byteData.buffer.asUint8List();

      await File(dbPath).writeAsBytes(bytes);
    } catch (e) {
      // Handle any errors related to copying the database
      print('Error copying database: $e');
      rethrow;
    }
  }

  Future<bool> performLogin(
      String username, String password, BuildContext context) async {
    try {
      final database = await _initDatabase();

      final result = await database.rawQuery(
        'SELECT * FROM User WHERE Username = ? AND Password = ?',
        [username, password],
      );

      await database.close();

      return result.isNotEmpty;
    } catch (e) {
      // Handle any errors that occur during login
      print('Login failed: $e');
      rethrow;
    }
  }

  Future<List<CircleData>> fetchCirclesFromDatabase() async {
    try {
      final database = await _initDatabase();

      final circles = await database.query('Sensor');
      await database.close();

      print(
          'Fetched circles: $circles'); // Print the fetched circles for debugging

      return List.generate(circles.length, (index) {
        return CircleData.fromMap(circles[index]);
      });
    } catch (e) {
      // Handle the exception here
      print('Error fetching circles from database: $e');
      return []; // Return an empty list or null, depending on your preference
    }
  }

  Future<List<PolygonData>> fetchPolygonsFromDatabase() async {
    try {
      final database = await _initDatabase();

      final maps = await database.query('Location');
      await database.close();

      print(
          'Fetched polygons: $maps'); // Print the fetched polygons for debugging

      return List.generate(maps.length, (index) {
        return PolygonData.fromMap(maps[index]);
      });
    } catch (e) {
      // Handle the exception here
      print('Error fetching polygons from database: $e');
      return []; // Return an empty list or null, depending on your preference
    }
  }
}
