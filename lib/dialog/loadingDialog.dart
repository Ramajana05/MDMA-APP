import 'package:flutter/material.dart';
import 'package:forestapp/db/apiService.dart';

import '../colors/appColors.dart';

class LoadingDialog extends StatefulWidget {
  final ApiService? apiService;

  LoadingDialog({this.apiService});

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog>
    with SingleTickerProviderStateMixin {
  final int _currentIndex = 0;
  final List<String> dialogTexts = [
    'Verbindung wird hergestellt...',
    'Änderungen werden hochgeladen...',
    'Herunterladen von neuen Daten...',
  ];

  AnimationController? _animationController;
  Animation<double>? _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _rotationAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_animationController!);

    // Start the timer to close the dialog after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  Future<void> _fetchUsers() async {
    try {
      print('Fetching users...');
      final List<User> userList = await widget.apiService?.getUsers() ?? [];
      print('Users fetched successfully');
      // Do something with the userList
      print('User List: $userList');
    } catch (e) {
      print('Error occurred while fetching users: $e');
      // Handle error
    } finally {
      Navigator.of(context).pop();
    }
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
              animation: _rotationAnimation!,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation!.value * 4.0 * 3.1415,
                  child: const Icon(
                    Icons.refresh,
                    size: 40,
                    color: primaryAppLightGreen,
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
            Text(
              dialogTexts[_currentIndex],
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  // Create an instance of ApiService
  final apiService = ApiService();
  apiService.fetchUsers();
  // Wrap the LoadingDialog widget with MaterialApp
  runApp(MaterialApp(
    home: Builder(
      builder: (context) {
        // Show the loading dialog
        showDialog(
          context: context,
          barrierDismissible: false, // Prevent dialog dismissal on tap outside
          builder: (context) => LoadingDialog(apiService: apiService),
        );

        return Scaffold(
          appBar: AppBar(
            title: Text('Loading Dialog'),
          ),
          body: const Center(
            child: Text('This is the home screen'),
          ),
        );
      },
    ),
  ));
}
