import 'dart:async';
import 'package:flutter/material.dart';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:forestapp/widget/topNavBar.dart';
import '../colors/appColors.dart';
import '../widget/sidePanelWidget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:forestapp/service/loginService.dart';

class ScanScreen extends StatefulWidget {
  ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreen();
}

class _ScanScreen extends State<ScanScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
  );
  List<String> myList = [];
  bool _canDetect = true;
  bool _isDialogShown = false; // Flag to track if the dialog is shown

  Timer? _timer;
  String? latitude;
  String? longitude;

  @override
  void initState() {
    super.initState();
    _initScanner();
  }

  void _initScanner() {
    cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
    );
    _getCurrentLocation();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      setState(() {
        _canDetect = true; // Allow detection after 1 second
      });
    });
  }

  void _getCurrentLocation() async {
    setState(() {
      latitude = 'Laden...';
      longitude = 'Laden...';
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
      });
    } catch (e) {
      setState(() {
        latitude = 'Ein Fehler ist Aufgetretet';
        longitude = 'Ein Fehler ist Aufgetretet';
      });
      Timer(const Duration(seconds: 1), _getCurrentLocation);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool isSensorNameValid(String sensorName) {
    return sensorName != null && sensorName.isNotEmpty;
  }

  // Create a TextEditingController instance outside the _showAlertDialog method
  final TextEditingController _sensorNameController = TextEditingController();

  void _showAlertDialog(String code, double latitude, double longitude) async {
    String qrCodeValue = code;
    String sensorName = '';

    final loginService = LoginService();
    bool isSensorNameNull = await loginService.isSensorNameNull(code);
    bool isUuidNotInDatabase = await loginService.isUuidNotInDatabase(code);

    if (!isUuidNotInDatabase) {
      if (!isSensorNameNull) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Text('Hinweis'),
                ],
              ),
              content: Text('Dieser Sensor wurde bereits angelegt.'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:
                        Colors.white, // Set the background color of the button
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color:
                          Colors.orange, // Set the text color of the "OK" text
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _resetScanner();
                  },
                ),
              ],
            );
          },
        );
      } else {
        await showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            String localSensorName = sensorName ?? '';

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Builder(
                  builder: (BuildContext errorDialogContext) {
                    return AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Neuen Sensor hinzufügen',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      content: Container(
                        width: MediaQuery.of(context).size.width *
                            0.9, // Set dialog width to 90% of the screen width
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Container(
                                          height:
                                              45, // Adjust the height of the text field
                                          child: TextField(
                                            controller: _sensorNameController,
                                            decoration: InputDecoration(
                                              labelText: 'Sensor Name',
                                              filled: true,
                                              fillColor: Colors.white,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: BorderSide(
                                                  color: primaryAppLightGreen,
                                                  width: 2.0,
                                                ),
                                              ),
                                              labelStyle: TextStyle(
                                                color: Colors.grey,
                                              ),
                                              focusColor: primaryAppLightGreen,
                                            ),
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                            ),
                                            onChanged: (value) {
                                              // Handle the text change
                                              print('Sensor Name: $value');
                                              localSensorName = value;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Latitude:',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  latitude.toString() ?? 'Laden...',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Longitude:',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  longitude.toString() ?? 'Laden...',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    child: const Text('Abbrechen'),
                                    onPressed: () {
                                      Navigator.of(dialogContext).pop();
                                      _resetScanner(); // Reset scanner after closing the dialog
                                    },
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                      ),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.grey,
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButton(
                                    child: const Text('Hinzufügen'),
                                    onPressed: () async {
                                      if (localSensorName.trim().isEmpty) {
                                        showDialog(
                                          context: errorDialogContext,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Row(
                                                children: [
                                                  Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const Text(
                                                    'Fehler',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              content: const Text(
                                                  'Der Sensor Name darf nicht leer sein.'),
                                              actions: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors
                                                        .white, // Set the background color of the button
                                                  ),
                                                  child: const Text(
                                                    'OK',
                                                    style: TextStyle(
                                                      color: Colors
                                                          .red, // Set the text color of the "OK" text
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        print(
                                            'Code: $code, Sensor Name: $localSensorName, Latitude: $latitude, Longitude: $longitude');
                                        final loginService = LoginService();
                                        await loginService
                                            .updateSensorNameInDatabase(
                                                code,
                                                localSensorName,
                                                latitude,
                                                longitude);

                                        await loginService
                                            .addAlertNewSensor(localSensorName);
                                        // Update the sensor name in the database
                                        Navigator.of(dialogContext).pop();
                                        _resetScanner(); // Reset scanner after adding
                                      }
                                    },
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                      ),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(
                                            255, 255, 255, 255),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        primaryAppLightGreen,
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(
                  Icons.warning_amber,
                  color: Colors.red,
                ),
                const SizedBox(width: 8),
                Text('Fehler'),
              ],
            ),
            content: Text('Der Sensor existiert nicht.'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary:
                      Colors.white, // Set the background color of the button
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.red, // Set the text color of the "OK" text
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _resetScanner();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _resetScanner() {
    setState(() {
      _canDetect = false;
      _isDialogShown = false;
      _getCurrentLocation();
    });
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _canDetect = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidePanel(),
      appBar: TopNavBar(
        title: 'QR CODE SCANNER',
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (barcode) {
              if (_canDetect && !_isDialogShown) {
                setState(() {
                  _canDetect =
                      false; // Disable detection until 1 second elapses
                });
                final List<Barcode> barcodes = barcode.barcodes;
                for (final barcode in barcodes) {
                  debugPrint('Barcode found! ${barcode.rawValue}');
                  final String? code = barcode.rawValue;
                  if (myList.contains(code)) {
                    setState(() {
                      _isDialogShown =
                          true; // Set the flag when the dialog is shown
                    });
                    _showAlertDialog(
                        barcode.rawValue ?? '',
                        double.parse(latitude ?? '0.0'),
                        double.parse(longitude ?? '0.0'));
                  } else {
                    myList.add(code!);
                    setState(() {
                      _isDialogShown =
                          true; // Set the flag when the dialog is shown
                    });
                    _showAlertDialog(
                        barcode.rawValue ?? '',
                        double.parse(latitude ?? '0.0'),
                        double.parse(longitude ?? '0.0'));
                  }
                }
              }
            },
          ),
          Positioned(
            top: 10,
            right: 0,
            child: Column(
              children: [
                IconButton(
                  color: white,
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.cameraFacingState,
                    builder: (context, state, child) {
                      switch (state) {
                        case CameraFacing.front:
                          return const Icon(Icons.camera_front_outlined);
                        case CameraFacing.back:
                          return const Icon(Icons.camera_rear_outlined);
                      }
                    },
                  ),
                  iconSize: 40.0,
                  onPressed: () {
                    cameraController.switchCamera();
                  },
                ),
                IconButton(
                  color: white,
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.torchState,
                    builder: (context, state, child) {
                      switch (state) {
                        case TorchState.off:
                          return const Icon(Icons.flash_off_outlined,
                              color: grey);
                        case TorchState.on:
                          return const Icon(Icons.flash_on_outlined,
                              color: white);
                      }
                    },
                  ),
                  iconSize: 40.0,
                  onPressed: () => cameraController.toggleTorch(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
