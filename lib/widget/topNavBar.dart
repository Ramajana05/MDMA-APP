import 'package:flutter/material.dart';
import 'package:forestapp/design/topNavBarDecoration.dart';
import 'package:forestapp/dialog/logoutDialog.dart';
import 'package:forestapp/widget/sidePanelWidget.dart';

class TopNavBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuPressed;

  const TopNavBar({Key? key, required this.title, this.onMenuPressed})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  _TopNavBarState createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  void _handleRefresh() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
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
              RotationTransition(
                turns: _animationController,
                child: const Icon(
                  Icons.refresh,
                  color: Color.fromARGB(
                      255, 40, 233, 127), // Set the color to green
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    setState(() {
      _isLoading = true;
    });

    // Simulate a loading process
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close the loading dialog
      setState(() {
        _isLoading = false;
      });
      // TODO: Add code to handle the refreshed data or perform additional actions
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: topNavBarDecoration.getTitleTextStyle(),
      ),
      backgroundColor: Color.fromARGB(146, 255, 255, 255),
      centerTitle: true,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          decoration: topNavBarDecoration.getBoxDecoration(),
          height: 4.0,
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Color.fromARGB(255, 40, 233, 127), // Set the color to green
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.refresh,
            color: Color.fromARGB(255, 40, 233, 127), // Set the color to green
          ),
          onPressed: _isLoading
              ? null
              : _handleRefresh, // Show the loading dialog on refresh
        ),
      ],
      iconTheme: IconThemeData(
        color: Color.fromARGB(
            255, 40, 233, 127), // Change this to the desired color
      ),
    );
  }
}
