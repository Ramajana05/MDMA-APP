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
  final List<String> dialogTexts = [
    'Verbindung wird hergestellt...',
    'Änderungen werden hochgeladen...',
    'Herunterladen von neuen Daten...',
    'Fertig',
  ];

  AnimationController? _animationController;
  Animation<double>? _rotationAnimation;
  int _currentIndex = 0;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _rotationAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_animationController!);

    // Start the timer to call fetchUsers after 2 seconds
    Future.delayed(const Duration(seconds: 2), fetchUsers);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void fetchUsers() async {
    try {
      print('Fetching users...');
      setState(() {
        _currentIndex =
            0; // Update dialog text to 'Verbindung wird hergestellt...'
      });

      await Future.delayed(
          const Duration(seconds: 2)); // Simulate an asynchronous operation

      print('Sending request to API...');
      setState(() {
        _currentIndex =
            2; // Update dialog text to 'Herunterladen von neuen Daten...'
      });

      final List<User> userList = await widget.apiService!.fetchUsers();
      if (userList != null) {
        print('Users fetched successfully');
        setState(() {
          _currentIndex = 3; // Update dialog text to 'Fertig'
        });

        // Print the details of each user
        for (User user in userList) {
          setState(() {
            _currentIndex =
                2; // Update dialog text to 'Herunterladen von neuen Daten...'
          });
          await Future.delayed(
              const Duration(seconds: 1)); // Simulate an asynchronous operation

          print('User ID: ${user.id}');
          print('Username: ${user.username}');
          print('updatedAt: ${user.updatedAt}');
          print('createdAt: ${user.createdAt}');
          print('--------------------');
        }
      } else {
        print('Empty user list');
      }

      // Logout
      await widget.apiService!.logout();
      print('Logout completed');

      // Close the dialog
      Navigator.of(context).pop();
    } catch (e) {
      print('Error occurred while fetching users: $e');
      setState(() {
        _errorMessage = 'Error occurred: $e'; // Update error message
      });

      // Close the dialog after a short delay
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.of(context).pop();
      });
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
          color: background,
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
            if (_errorMessage != null) // Display error message if available
              Text(
                _errorMessage!,
                style: TextStyle(
                  fontSize: 16.0,
                  color: red,
                ),
              ),
            if (_errorMessage == null) // Display dialog text if no error
              Text(
                dialogTexts[_currentIndex],
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  final apiService = ApiService();

  // Wrap the LoadingDialog widget with MaterialApp
  runApp(MaterialApp(
    home: Builder(
      builder: (context) {
        // Create an instance of ApiService
        final apiService = ApiService();

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
