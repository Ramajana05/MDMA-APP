import 'package:sqflite/sqflite.dart';

class SessionProvider {
  static const String tableName = 'session';
  static const String columnUserId = 'user_id';
  static const String columnIsLoggedIn = 'is_logged_in';

  Future<void> createSessionTable(Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        $columnUserId TEXT PRIMARY KEY,
        $columnIsLoggedIn INTEGER
      )
    ''');
  }

  Future<void> insertSessionData(String userId, int isLoggedIn) async {
    final Database database = await openDatabase('MDMADatabase.db');
    await createSessionTable(database);
    await database.insert(
      tableName,
      {
        columnUserId: userId,
        columnIsLoggedIn: isLoggedIn,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await database.close();
  }

  Future<Map<String, dynamic>> getSessionData() async {
    final Database database = await openDatabase('MDMADatabase.db');
    final List<Map<String, dynamic>> rows =
        await database.query(tableName, limit: 1);

    if (rows.isNotEmpty) {
      final Map<String, dynamic> sessionData = rows.first;
      return sessionData;
    } else {
      throw Exception('No session data found');
    }
  }

  Future<String?> getLoggedInUserId() async {
    final Map<String, dynamic> sessionData = await getSessionData();
    if (sessionData[columnIsLoggedIn] == 1) {
      return sessionData[columnUserId];
    } else {
      return null;
    }
  }
}
