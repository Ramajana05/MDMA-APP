import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forestapp/dialog/scannerHelpDialog.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:forestapp/widget/topNavBar.dart';
import '../widget/sidePanelWidget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:forestapp/dialog/scannerHelpDialog.dart';

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

  void _showAlertDialog(String code) {
    bool codeExists = myList.contains(code);
    String qrCodeValue = code ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          key: _scaffoldKey,
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sensor hinzufügen'),
                  Theme(
                    data: Theme.of(context).copyWith(
                      tooltipTheme: TooltipThemeData(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                    child: Positioned(
                      top: 0,
                      right: -10,
                      child: Tooltip(
                        message: 'Tooltip information',
                        child: IconButton(
                          icon: Icon(Icons.info_outline_rounded),
                          color: Colors.blue,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => ScannerHelpDialog(),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        'UUID: $code',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      if (codeExists)
                        Icon(
                          Icons.close,
                          color: Colors.red,
                        )
                      else
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 40,
                    child: TextField(
                      readOnly: false,
                      decoration: InputDecoration(
                        labelText: 'Sensor Name',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 40, 233, 127),
                            width: 2.0,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        focusColor: Color.fromARGB(255, 40, 233, 127),
                      ),
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                      onChanged: (value) {
                        // Add your logic to handle the sensor name input field
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latitude:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        latitude ?? 'Laden...',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Longitude:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        longitude ?? 'Laden...',
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
                            Navigator.of(context).pop();
                            _resetScanner(); // Reset scanner after closing the dialog
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey,
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 255, 255, 255),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          child: const Text('Hinzufügen'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            _resetScanner(); // Reset scanner after adding
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 255, 255, 255),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 40, 233, 127),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
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
                    _showAlertDialog(barcode.rawValue.toString());
                  } else {
                    myList.add(code!);
                    setState(() {
                      _isDialogShown =
                          true; // Set the flag when the dialog is shown
                    });
                    _showAlertDialog(barcode.rawValue.toString());
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
                  color: Colors.white,
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
                  iconSize: 32.0,
                  onPressed: () {
                    cameraController.switchCamera();
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.torchState,
                    builder: (context, state, child) {
                      switch (state) {
                        case TorchState.off:
                          return const Icon(Icons.flash_off_outlined,
                              color: Colors.grey);
                        case TorchState.on:
                          return const Icon(Icons.flash_on_outlined,
                              color: Color.fromARGB(255, 255, 255, 255));
                      }
                    },
                  ),
                  iconSize: 32.0,
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
