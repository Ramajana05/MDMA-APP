import 'dart:io';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInitializer {
  Future<void> initDatabase() async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, 'MDMA.db');

      final databaseExists = await File(path).exists();

      if (!databaseExists) {
        final dbAssetPath = await _getDatabaseAssetPath();
        await _copyDatabase(dbAssetPath, path);
      }
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
}
