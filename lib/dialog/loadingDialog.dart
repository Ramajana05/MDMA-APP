import 'dart:async';
import 'package:flutter/material.dart';

class LoadingDialog extends StatefulWidget {
  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final List<String> dialogTexts = [
    'Verbindung wird hergestellt...',
    'Änderungen werden hochgeladen...',
    'Herunterladen von neuen Daten...',
  ];

  Timer? _timer;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _rotationAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_animationController);
    // Start the timer when the dialog is created
    _startTimer();
  }

  @override
  void dispose() {
    // Cancel the timer and animation controller when the dialog is disposed
    _cancelTimer();
    _animationController.dispose();
    super.dispose();
  }

  void _startTimer() {
    Timer(Duration(seconds: 2), () {
      _timer = Timer.periodic(Duration(seconds: 2), (timer) {
        // Update the current index and check if it exceeds the text list length
        setState(() {
          _currentIndex = (_currentIndex + 1) % dialogTexts.length;
        });

        // Close the dialog after displaying the last text
        if (_currentIndex == dialogTexts.length - 1) {
          Future.delayed(Duration(seconds: 2), () {
            _cancelTimer();
            Navigator.of(context).pop();
          });
        }
      });
    });
  }

  void _cancelTimer() {
    _animationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 4.0 * 3.1415,
                  child: const Icon(
                    Icons.refresh,
                    color: Color.fromARGB(255, 40, 233, 127),
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
            Text(
              dialogTexts[_currentIndex],
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
