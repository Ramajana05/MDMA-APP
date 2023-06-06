import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:forestapp/design/topNavBarDecoration.dart';

class ScanScreen extends StatefulWidget {
  ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreen();
}

class _ScanScreen extends State<ScanScreen> {
  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
  );
  List<String> myList = [];
  bool _canDetect = true;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      setState(() {
        _canDetect = true; // Allow detection after 1 second
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 232, 241, 232),
        title: Text(
          "Scan Code",
          style: topNavBarDecoration.getTitleTextStyle(),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () {
              cameraController.switchCamera();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Switched Camera'),
                    content: const Text('Camera switched successfully.'),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (barcode) {
          if (_canDetect) {
            setState(() {
              _canDetect = false; // Disable detection until 1 second elapses
            });
            final List<Barcode> barcodes = barcode.barcodes;
            for (final barcode in barcodes) {
              debugPrint('Barcode found! ${barcode.rawValue}');
              final String? code = barcode.rawValue;
              if (myList.contains(code)) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Code lesen'),
                      content: const Text('Dieser Code existiert bereits'),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                myList.add(code!);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Code lesen'),
                      content: const Text('Neuer Code, erfolgreich hinzugefügt'),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            }
          }
        },
      ),
    );
  }
}