import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LoginService {
  Future<Database> _initDatabase() async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, 'MDMADatabase.db');

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
          .firstWhere((key) => key.contains('assets/database/MDMADatabase.db'));
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
      String email, String password, BuildContext context) async {
    try {
      final database = await _initDatabase();

      final result = await database.rawQuery(
        'SELECT * FROM User WHERE Username = ? AND Password = ?',
        [email, password],
      );

      await database.close();

      return result.isNotEmpty;
    } catch (e) {
      // Handle any errors that occur during login
      print('Login failed: $e');
      rethrow;
    }
  }
}
