import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestapp/Model/ChartData.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:forestapp/widget/mapObjects.dart';
import 'package:forestapp/screen/sensorListScreen.dart';
import 'package:forestapp/provider/userProvider.dart';
import 'package:intl/intl.dart';
import '../Model/dateHelper.dart';
import '../colors/appColors.dart';
import '../widget/warningWidget.dart';
import 'package:intl/date_symbol_data_local.dart';

class LoginService {
  static const String tableName = 'Place';
  static const String columnId = 'ID';
  static const String columnName = 'Name';
  static const String columnLatitude = 'Latitude';
  static const String columnLongitude = 'Longitude';
  List<Map<String, String>> _dropdownItems = [];
  bool isDarkmode = false;

  void main() async {
    final userProvider = UserProvider(); // Create an instance of UserProvider
    final loggedInUsername = userProvider.loggedInUsername;
    final loginService = LoginService();
    final password =
        await loginService.fetchPasswordFromDatabase(loggedInUsername!);

    print('Password: $password'); // Print the fetched password
  }

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

      final circles = await database.query('Sensor',
          where:
              'Name IS NOT NULL'); // Add the condition to filter null values for the "Name" column
      await database.close();

      print('Fetched circles: $circles');

      return List.generate(circles.length, (index) {
        return CircleData.fromMap(circles[index]);
      });
    } catch (e) {
      print('Error fetching circles from database: $e');
      return [];
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

  Future<List<Sensor>> fetchSensorsFromDatabase() async {
    try {
      final database = await _initDatabase();

      final sensors = await database.query('Sensor',
          where:
              'Name IS NOT NULL'); // Add the condition to filter null values for the "Name" column
      await database.close();

      print('Fetched Sensors: $sensors');

      return List.generate(sensors.length, (index) {
        final sensor = sensors[index];
        return Sensor(
          sensorName: sensor['Name'] as String,
          latitude: (sensor['Latitude'] as num?)?.toDouble() ?? 0.0,
          longitude: (sensor['Longitude'] as num?)?.toDouble() ?? 0.0,
          status: sensor['Available'] as String,
          createDate: sensor['CreationDate'] as String,
          signalStrength: sensor['SignalStrength'] as String,
          chargerInfo: sensor['Battery']?.toString() ?? '0',
          temperatur: (sensor['Temperature'] as num?)?.toDouble() ?? 0.0,
          airPressure: (sensor['Humidity'] as int?) ?? 0,
        );
      });
    } catch (e) {
      print('Error fetching sensors from database: $e');
      return [];
    }
  }

  Future<String?> fetchPasswordFromDatabase(String loggedInUsername) async {
    try {
      final database = await _initDatabase();

      final result = await database.rawQuery(
        'SELECT Password FROM User WHERE Username = ?',
        [loggedInUsername],
      );

      await database.close();

      if (result.isNotEmpty) {
        final currentPassword = result.first['Password'] as String?;
        print(
            'Fetched password: $currentPassword'); // Print the fetched password for testing
        return currentPassword;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching password from database: $e');
      rethrow;
    }
  }

  Future<void> changePasswordInDatabase(
      String loggedInUsername, String newPassword) async {
    try {
      final database = await _initDatabase();

      await database.update(
        'User',
        {'Password': newPassword},
        where: 'Username = ?',
        whereArgs: [loggedInUsername],
      );

      await database.close();

      print('Password changed successfully');
    } catch (e) {
      print('Error updating password in database: $e');
      rethrow;
    }
  }

  ///QR Code Scanner
  Future<void> updateSensorNameInDatabase(
      String uuid, String newName, double latitude, double longitude) async {
    try {
      // Open the database
      final database = await _initDatabase();

      // Check if the sensor with the given UUID exists in the database
      final result = await database.rawQuery(
        'SELECT * FROM Sensor WHERE Uuid = ?',
        [uuid],
      );

      if (result.isNotEmpty && result.first['Name'] != null) {
        // Sensor exists and has a name
        print('Sensor with UUID $uuid already exists in the database');
      } else if (result.isNotEmpty && result.first['Name'] == null) {
        // Sensor exists but has no name, update the sensor details
        // Get the current date
        final currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

        // Update the sensor name, latitude, longitude, and creation date in the database
        await database.update(
          'Sensor',
          {
            'Name': newName,
            'Latitude': latitude.toDouble(),
            'Longitude': longitude.toDouble(),
            'CreationDate': currentDate.toString(),
          },
          where: 'Uuid = ?',
          whereArgs: [uuid],
        );

        print('Sensor details updated successfully');
      } else {
        print('Sensor with UUID $uuid not found in the database');
      }

      // Close the database
      await database.close();
    } catch (e) {
      print('Error updating sensor details in the database: $e');
      rethrow;
    }
  }

  Future<bool> isSensorNameNull(String uuid) async {
    try {
      // Open the database
      final database = await _initDatabase();

      // Check if the sensor with the given UUID exists in the database
      final result = await database.rawQuery(
        'SELECT Name FROM Sensor WHERE Uuid = ?',
        [uuid],
      );

      // Check if the sensor name is null
      bool isNull = result.isEmpty || result.first['Name'] == null;

      // Close the database
      await database.close();

      return isNull;
    } catch (e) {
      print('Error retrieving sensor name from database: $e');
      rethrow;
    }
  }

  Future<bool> isUuidNotInDatabase(String uuid) async {
    try {
      // Open the database
      final database = await _initDatabase();

      // Check if the sensor with the given UUID exists in the database
      final result = await database.rawQuery(
        'SELECT Uuid FROM Sensor WHERE Uuid = ?',
        [uuid],
      );

      // Check if the UUID is null or not found in the database
      bool isUuidNull = result.isEmpty || result.first['Uuid'] == null;

      // Close the database
      await database.close();

      return isUuidNull;
    } catch (e) {
      print('Error retrieving sensor UUID from database: $e');
      rethrow;
    }
  }

  Future<int> countOnlineSensorsWithName() async {
    try {
      // Open the database
      final database = await _initDatabase();

      // Count the sensors with a name and status "Online"
      final result = await database.rawQuery(
        'SELECT COUNT(*) AS Count FROM Sensor WHERE Name IS NOT NULL AND Available = "Online"',
      );

      // Extract the count from the query result
      final onlineCount = result.isNotEmpty ? result.first['Count'] as int : 0;

      // Close the database
      await database.close();

      return onlineCount;
    } catch (e) {
      print('Error counting online sensors with name from database: $e');
      rethrow;
    }
  }

  Future<int> countAllSensorsWithName() async {
    try {
      // Open the database
      final database = await _initDatabase();

      // Count the sensors with a name and status "Online"
      final result = await database.rawQuery(
        'SELECT COUNT(*) AS Count FROM Sensor WHERE Name IS NOT NULL',
      );

      // Extract the count from the query result
      final allCount = result.isNotEmpty ? result.first['Count'] as int : 0;

      // Close the database
      await database.close();

      return allCount;
    } catch (e) {
      print('Error counting all sensors with name from database: $e');
      rethrow;
    }
  }

  ///Alerts
  Future<List<Map<String, dynamic>>> loadAlertsFromDatabase() async {
    try {
      // Open the database
      final database = await _initDatabase();

      // Query the database to retrieve alerts
      final result = await database.rawQuery(
        'SELECT * FROM Alert WHERE Type IN (?, ?)',
        ['Warnung', 'Neuigkeit'],
      );

      // Close the database
      await database.close();

      return result;
    } catch (e) {
      print('An error occurred while loading alerts: $e');
      rethrow;
    }
  }

  Future<List<Widget>> loadAlertsFromDatabaseWidgets() async {
    try {
      final List<Map<String, dynamic>> alertsData =
          await loadAlertsFromDatabase();
      final List<Widget> alertsWidgets = [];

      for (final alertData in alertsData) {
        final String type = alertData['Type'];
        final String message = alertData['Message'];
        final Color iconColor = type == 'Warnung' ? orange : blue;

        final WarningWidget alertWidget = WarningWidget(
          message: message,
          isWarnung: type == 'Warnung',
          iconColor: iconColor,
        );

        alertsWidgets.add(alertWidget);
      }

      return alertsWidgets;
    } catch (e) {
      print('An error occurred while loading alerts: $e');
      return [];
    }
  }

  Future<void> addAlertNewSensor(String sensorName) async {
    try {
      // Open the database
      final database = await _initDatabase();

      // Get the current date and time
      final now = DateTime.now();

      // Format the date as "DD.MM.YYYY"
      final dateFormat = DateFormat('dd.MM.yyyy');
      final formattedDate = dateFormat.format(now);

      // Format the time as "HH:MM"
      final timeFormat = DateFormat('HH:mm');
      final formattedTime = timeFormat.format(now);

      // Prepare the row values
      final values = <String, dynamic>{
        'Type': 'Neuigkeit',
        'Message':
            'Neuer Sensor "$sensorName" wurde am $formattedDate um $formattedTime Uhr hinzugefügt.',
        'CreationDate': now.toString(),
      };

      // Insert the row into the "Alerts" table
      await database.insert('Alert', values);

      // Close the database
      await database.close();

      print('Alert row added successfully!');
    } catch (e) {
      print('Error adding alert row to the database: $e');
      rethrow;
    }
  }

  Future<void> deleteAlertEntry(String message) async {
    try {
      final database = await _initDatabase();

      // Delete the entry where 'Message' matches the specified message
      await database.delete(
        'Alert',
        where: 'Message = ?',
        whereArgs: [message],
      );

      await database.close();

      print('Alert entry deleted successfully!');
    } catch (e) {
      print('Error deleting alert entry from the database: $e');
      rethrow;
    }
  }

  ///fetches the data for today hourly until current hour
  Future<List<ChartData>> fetchStatisticDataHourFromDatabase(
      String type) async {
    try {
      final database = await _initDatabase();

      final DateTime now = DateTime.now();
      final DateFormat hourFormat = DateFormat('HH:mm');
      final DateTime previousHour = now.subtract(const Duration(hours: 1));

      final statisticHourly = await database.query(
        'StaitsicsDataHour',
        columns: ['Hour', type],
        where: 'Hour <= ?',
        whereArgs: [hourFormat.format(previousHour)],
      );

      await database.close();

      return List.generate(statisticHourly.length, (index) {
        final data = statisticHourly[index];

        return ChartData(
          data['Hour'] as String,
          (data[type] as num?)?.toDouble() ?? 0.0,
        );
      });
    } catch (e) {
      print('Error fetching statistics data from database: $e');
      return [];
    }
  }

  ///fetches the data für a week until today
  Future<List<ChartData>> fetchStatisticDataWeekFromDatabase(
      String type) async {
    DateTime now = DateTime.now().subtract(Duration(days: 1));
    print(now);
    DateTime sevenDaysAgo = now.subtract(const Duration(days: 6));

    DateFormat dateFormat = DateFormat('yyyyMMdd');
    String sevenDaysAgoFormatted = dateFormat.format(sevenDaysAgo);
    String todayFormatted = dateFormat.format(now);
    print(sevenDaysAgoFormatted);

    print(todayFormatted);
    try {
      await initializeDateFormatting('de_DE', null);

      final database = await _initDatabase();

      // Query the database
      final statisticWeek = await database.rawQuery(
          'SELECT Date,$type FROM StatisticsDataDay where substr(Date,7)||substr(Date,4,2)||substr(Date,1,2) BETWEEN ? AND ?',
          [sevenDaysAgoFormatted, todayFormatted]);

      print('Fetched StatisticsWeek: $statisticWeek');
      DateFormat dateFormat1 = DateFormat('dd.MM.yyyy');

      return List.generate(statisticWeek.length, (index) {
        final data = statisticWeek[index];
        final date = data['Date'] as String;

        final DateTime parsedDate = dateFormat1.parse(date);

        print("parsedDate: $parsedDate");

        final dayName = DateFormat.EEEE('de_DE').format(parsedDate);
        print("dayName $dayName");

        final String weekDayGermanShort = getWeekday(dayName);

        return ChartData(
          weekDayGermanShort,
          (data[type] as num?)?.toDouble() ?? 0.0,
        );
      });
    } catch (e) {
      print('Error fetching statistics data from database: $e');
      return [];
    }
  }

  ///fetches the data of yesterday hourly
  Future<List<ChartData>> fetchStatisticDataYesterdayFromDatabase(
      String type, int startHour, int endHour) async {
    try {
      final database = await _initDatabase();

      final statisticHourly = await database.query(
        'StaitsicsDataYesterdayHour',
        columns: ['Hour', type],
        where: 'Hour >= ? AND Hour < ?',
        whereArgs: [
          startHour.toString().padLeft(2, '0'), // Convert to 2-digit format
          (startHour + 7)
              .toString()
              .padLeft(2, '0'), // Convert to 2-digit format
        ],
      );

      await database.close();

      return List.generate(statisticHourly.length, (index) {
        final data = statisticHourly[index];
        return ChartData(
          data['Hour'] as String,
          (data[type] as num?)?.toDouble() ?? 0.0,
        );
      });
    } catch (e) {
      print(
          'Error fetching StaitsicsDataYesterdayHour data from database: $type:$e');
      return [];
    }
  }
  
  ///fetches the data for the weeks of the month as average values
  Future<List<ChartData>> fetchStatisticDataMonthFromDatabase(
      String type) async {
    try {
      final database = await _initDatabase();

      final DateTime now = DateTime.now();
      final DateTime previousMonth = DateTime(now.year, now.month - 1, 1);
      final DateTime lastDayPreviousMonth = DateTime(now.year, now.month, 0);
      final DateFormat dateFormat = DateFormat('yyyyMMdd');

      List<ChartData> statisticData = [];

      // Get the first and last date of each week in the previous month
      DateTime weekStart = previousMonth;
      DateTime weekEnd;
      for (int i = 0; i < 4; i++) {
        weekEnd = weekStart.add(const Duration(days: 6));

        // If the weekEnd exceeds the last day of the previous month, set it to the last day
        if (weekEnd.isAfter(lastDayPreviousMonth)) {
          weekEnd = lastDayPreviousMonth;
        }

        // If it's the last iteration and there are remaining days, add them to the last week
        if (i == 3 && weekEnd != lastDayPreviousMonth) {
          final remainingDays = lastDayPreviousMonth.difference(weekEnd).inDays;
          weekEnd = lastDayPreviousMonth;
          weekStart = weekStart.subtract(Duration(days: remainingDays));
        }

        final String weekStartFormatted =
            DateFormat('dd.MM.').format(weekStart);
        final String weekEndFormatted = DateFormat('dd.MM.').format(weekEnd);

        final statisticWeek = await database.rawQuery('''
        SELECT AVG($type) AS average
        FROM StatisticsDataDay
        WHERE substr(Date, 7) || substr(Date, 4, 2) || substr(Date, 1, 2) BETWEEN ? AND ?
      ''', [dateFormat.format(weekStart), dateFormat.format(weekEnd)]);

        double average =
            (statisticWeek.first['average'] as num?)?.toDouble() ?? 0.0;

        if (type == "Visitor") {
          average = average.roundToDouble();
        } else {
          average = double.parse(average.toStringAsFixed(2));
        }

        ChartData chartData =
            ChartData('$weekStartFormatted - $weekEndFormatted', average);
        statisticData.add(chartData);

        weekStart = weekEnd.add(const Duration(days: 1));
      }

      await database.close();

      return statisticData;
    } catch (e) {
      print('Error fetching statistics data of the month from database: $e');
      return [];
    }
  }

  Future<List<Map<String, String>>> loadPlacesFromDatabase() async {
    try {
      final database = await _initDatabase();

      final List<Map<String, dynamic>> places = await database.query(tableName);

      await database.close();

      List<Map<String, String>> loadedPlaces = [];

      for (var place in places) {
        final String name = place[columnName];
        final double latitude = place[columnLatitude];
        final double longitude = place[columnLongitude];

        // Do something with the retrieved place data
        print('Name: $name');
        print('Latitude: $latitude');
        print('Longitude: $longitude');

        loadedPlaces.add({
          'name': name,
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
        });
      }

      return loadedPlaces; // Return the loaded places
    } catch (e) {
      // Handle the error
      print('Error loading places: $e');
      return []; // Return an empty list as a fallback
    }
  }

  Future<void> addPlaceFromDatabase(
      String name, double latitude, double longitude) async {
    try {
      final database = await _initDatabase();

      final place = {
        'Name': name, // Updated column name to match the database
        'Latitude': latitude,
        'Longitude': longitude,
      };

      await database.insert('Place', place);

      await database.close();

      print('Place added successfully');
    } catch (e) {
      print('Error adding place: $e');
      rethrow;
    }
  }

  Future<void> deletePlaceFromDatabase(String name) async {
    try {
      final database = await _initDatabase();

      await database.delete(
        'Place',
        where: 'Name = ?',
        whereArgs: [name],
      );

      await database.close();

      print('Place deleted successfully');
    } catch (e) {
      print('Error deleting place: $e');

      fetchDarkModeValue(param0) {}
      rethrow;
    }
  }

  Future<void> updateDarkModeStatus(String username, bool isDarkMode) async {
    try {
      final database = await _initDatabase();

      final updatedValue = isDarkMode ? 'False' : 'True';

      await database.rawUpdate(
        'UPDATE User SET DarkMode = ? WHERE Username = ?',
        [updatedValue, username],
      );

      await database.close();

      print(
          'Dark mode status updated: username = $username, isDarkMode = $isDarkMode');
    } catch (e) {
      print('Updating dark mode status failed: $e');
      rethrow;
    }
  }

  Future<bool> fetchDarkModeValue(String username) async {
    try {
      final database = await _initDatabase();

      final result = await database.rawQuery(
        'SELECT * FROM User WHERE Username = ?',
        [username],
      );

      if (result.isNotEmpty) {
        final userData = result.first;
        final darkModeValue = userData['DarkMode'];

        await database.close();

        return darkModeValue == 'True';
      } else {
        await database.close();
        return false;
      }
    } catch (e) {
      print('Fetching dark mode value failed: $e');
      rethrow;
    }
  }
}
