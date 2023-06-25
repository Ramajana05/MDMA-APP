import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:forestapp/db/databaseInitializer.dart';

class UserProvider with ChangeNotifier {
  late Database _database;
  String? loggedInUsername;
  String? role;
  String? creationDate;

  UserProvider() {
    // Initialize and open the database
    _initDatabase();
  }

  void setLoggedInUsername(String username) {
    loggedInUsername = username;
    notifyListeners();
  }

  Future<void> _initDatabase() async {
    try {
      final databaseInitializer = DatabaseInitializer();
      await databaseInitializer.initDatabase();

      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, 'MDMA.db');

      /// Open the database
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          /// Create the 'User' table if it doesn't exist
          await db.execute(
            'CREATE TABLE IF NOT EXISTS User (ID INTEGER PRIMARY KEY, Username TEXT, Role TEXT, CreationDate TEXT)',
          );
        },
      );
    } catch (e) {
      /// Handle any errors that occur during database initialization
      print('Database initialization failed: $e');
      rethrow;
    }
  }

  Future<void> fetchUserDetails() async {
    if (loggedInUsername != null) {
      final result = await _database.query(
        'User',
        columns: ['Role', 'CreationDate'],
        where: 'Username = ?',
        whereArgs: [loggedInUsername],
      );

      if (result.isNotEmpty) {
        role = result.first['Role'] as String?;
        creationDate = result.first['CreationDate'] as String?;
      } else {
        role = null;
        creationDate = null;
      }

      notifyListeners();
    }
  }

  bool _isSystemDarkModeEnabled = false;

  bool get isSystemDarkModeEnabled => _isSystemDarkModeEnabled;

  void setSystemDarkModeEnabled(bool value) {
    _isSystemDarkModeEnabled = value;
    notifyListeners();
  }
}
