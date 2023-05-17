import 'package:flutter/material.dart';
import 'package:forestapp/widget/topNavBar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:forestapp/design/topNavBarDecoration.dart';

class ScanScreen extends StatefulWidget {
  ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreen();
}

class _ScanScreen extends State<ScanScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 232, 241, 232),
        title: Text(
          "CODE SCANNEN",
          style: topNavBarDecoration.getTitleTextStyle(),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
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
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('switched Camera'),
              )),
              cameraController.switchCamera()
            },
          ),
        ],
      ),
      body: MobileScanner(
        // allowDuplicates: true,
        controller: cameraController,
        onDetect: (barcode) {
          final String code = barcode.raw.toString();
          //debugPrint('Barcode found! $code');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //content: Text(code),
            content: Text("QR wurde erfolgreich gescannt"),
          ));
        },
      ),
    );
  }
}
