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
import 'package:forestapp/widget/warningWidget.dart';
import '../colors/appColors.dart';

class LoginService {
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

//Alerts

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

  ///returns the data hourly today
  ///type: String , Column that holds the data required , e.g. : Visitor
  Future<List<ChartData>> fetchStatisticDataHourFromDatabase(
      String type) async {
    try {
      final database = await _initDatabase();

      final statisticHourly =
          await database.query('StaitsicsDataHour', columns: ['Hour', type]);
      await database.close();

      //print('Fetched StatisticsHour: $statisticHourly');

      return List.generate(statisticHourly.length, (index) {
        final data = statisticHourly[index];
        return ChartData(
          data['Hour'] as String,
          (data[type] as num?)?.toDouble() ?? 0.0,
        );
      });
    } catch (e) {
      print('Error fetching StaitsicsDataHour data from database:$type:  $e');
      return [];
    }
  }

  ///returns the data daily for a week
  ///type: String , Column that holds the data required , e.g. : Visitor
  Future<List<ChartData>> fetchStatisticDataWeekFromDatabase(
      String type) async {
    DateTime now = DateTime.now();
    DateTime sevenDaysAgo = now.subtract(const Duration(days: 6));

    DateFormat dateFormat = DateFormat('yyyyMMdd');
    String sevenDaysAgoFormatted = dateFormat.format(sevenDaysAgo);
    String todayFormatted = dateFormat.format(now);

    List<String> germanWeekdays = [
      'Mi',
      'Do',
      'Fr',
      'Sa',
      'So',
      '',
      'Mo',
      'Di',
    ];

    try {
      final database = await _initDatabase();

      // Query the database
      final statisticWeek = await database.rawQuery(
        'SELECT Date,$type FROM StatisticsDataDay WHERE substr(Date,7)||substr(Date,4,2)||substr(Date,1,2) BETWEEN ? AND ?',
        [sevenDaysAgoFormatted, todayFormatted],
      );

      await database.close();

      return List.generate(statisticWeek.length, (index) {
        final data = statisticWeek[index];
        DateTime currentDate = sevenDaysAgo.add(Duration(days: index));
        String germanWeekday = germanWeekdays[currentDate.weekday -
            1]; // Subtract 1 from weekday to match the index in the germanWeekdays list

        return ChartData(
          germanWeekday, // Use German weekday as X value
          (data[type] as num?)?.toDouble() ?? 0.0, // Use type value as Y value
        );
      });
    } catch (e) {
      print('Error fetching statistics data from database: $e');
      return [];
    }
  }

  ///returns the data hourly of yesterday
  ///type: String , Column that holds the data required , e.g. : Visitor
  Future<List<ChartData>> fetchStatisticDataHourYesterdayFromDatabase(
      String type) async {
    try {
      final database = await _initDatabase();

      final statisticHourly = await database
          .query('StaitsicsDataYesterdayHour', columns: ['Hour', type]);
      await database.close();

      //print('Fetched StatisticsHourYesterday: $statisticHourly');

      return List.generate(statisticHourly.length, (index) {
        final data = statisticHourly[index];
        //var dataType = data[type];
        //print("data type: $type:--  $dataType");
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

  Future<List<ChartData>> fetchStatisticDataMonthFromDatabase(
      String type) async {
    try {
      final database = await _initDatabase();

      List<String> previousWeekDates =
          await fetchPreviousMonthWeeksFromDatabase();

      List<ChartData> statisticData = [];

      for (String weekDates in previousWeekDates) {
        List<String> dates = weekDates.split(' - ');

        String firstDate = convertToDatabaseDateFormat(
            dates[0]); // Convert to database date format
        String lastDate = convertToDatabaseDateFormat(
            dates[1]); // Convert to database date format

        final statisticWeek = await database.rawQuery('''
          SELECT AVG($type) AS average_value
          FROM StatisticsDataDay
          WHERE date(substr(Date, 7, 4) || '-' || substr(Date, 4, 2) || '-' || substr(Date, 1, 2)) BETWEEN date(?, 'localtime') AND date(?, 'localtime')
        ''', [firstDate, lastDate]);

        double averageValue =
            (statisticWeek.first['average_value'] as num?)?.toDouble() ?? 0.0;

        ChartData chartData = ChartData(
          'Week ${weekNumber(DateTime.parse(dates[0]))} in ${DateFormat('MMMM').format(DateTime.parse(dates[0]))}',
          averageValue,
        );

        statisticData.add(chartData);
      }

      await database.close();

      return statisticData;
    } catch (e) {
      print('Error fetching statistics for the month data from database: $e');
      return [];
    }
  }

  Future<List<String>> fetchPreviousMonthWeeksFromDatabase() async {
    final DateFormat dateFormat = DateFormat('yyyyMMdd');

    DateTime now = DateTime.now();
    DateTime previousMonth = DateTime(now.year, now.month - 1, now.day);

    int currentWeek = weekNumber(now);
    int previousMonthWeeks =
        numOfWeeks(previousMonth.year, previousMonth.month);

    List<String> previousMonthWeekDates = [];
    for (int i = 1; i <= previousMonthWeeks; i++) {
      DateTime previousWeekStart =
          previousMonth.subtract(Duration(days: (currentWeek + i) * 7));
      DateTime previousWeekEnd = previousWeekStart.add(const Duration(days: 6));

      String previousWeekStartFormatted = dateFormat.format(previousWeekStart);
      String previousWeekEndFormatted = dateFormat.format(previousWeekEnd);

      previousMonthWeekDates
          .add('$previousWeekStartFormatted - $previousWeekEndFormatted');
    }

    return previousMonthWeekDates;
  }

  int weekNumber(DateTime date) {
    DateTime firstDayOfYear = DateTime(date.year, 1, 1);
    int daysOffset = DateTime.thursday - firstDayOfYear.weekday;
    DateTime firstThursday = firstDayOfYear.add(Duration(days: daysOffset));
    DateTime targetDate = date.subtract(Duration(days: daysOffset));

    int weekNumber = targetDate.difference(firstThursday).inDays ~/ 7 + 1;
    if (weekNumber < 1) {
      weekNumber = numOfWeeks(date.year - 1, 12);
    } else if (weekNumber > numOfWeeks(date.year, date.month)) {
      weekNumber = 1;
    }

    return weekNumber;
  }

  int numOfWeeks(int year, int month) {
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
    int weekNumberLastDay =
        lastDayOfMonth.weekday == DateTime.saturday ? 53 : 52;

    return weekNumberLastDay;
  }

  String convertToDatabaseDateFormat(String inputDate) {
    final inputFormat = DateFormat('dd.MM.yyyy');
    final outputFormat = DateFormat('yyyy-MM-dd');
    final date = inputFormat.parse(inputDate);
    return outputFormat.format(date);
  }
}
