import 'package:flutter/material.dart';
import 'package:forestapp/design/topNavBarDecoration.dart';
import 'package:forestapp/dialog/logoutDialog.dart';

import '../colors/appColors.dart';

class TopNavBarBasic extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuPressed;
  final bool returnStatus;

  const TopNavBarBasic({
    Key? key,
    required this.title,
    this.onMenuPressed,
    required this.returnStatus,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  _TopNavBarBasicState createState() => _TopNavBarBasicState();
}

class _TopNavBarBasicState extends State<TopNavBarBasic> {
  Color backgroundColor = background;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkBackgroundColor();
  }

  void checkBackgroundColor() {
    setState(() {
      backgroundColor = background;
    });
  }

  void reloadBackgroundColor() {
    setState(() {
      // Reload the background color from appColors.dart
      backgroundColor = background;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.returnStatus,
      title: Text(
        widget.title,
        style: topNavBarDecoration
            .getTitleTextStyle()
            .copyWith(fontSize: 27), // Adjust the fontSize as desired
      ),
      backgroundColor: backgroundColor, // Use the updated background color
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
        icon:
            const Icon(Icons.arrow_back, size: 35, color: primaryAppLightGreen),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      iconTheme: IconThemeData(
        color: primaryAppLightGreen,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, size: 35),
          onPressed: () {
            reloadBackgroundColor(); // Reload the background color
          },
        ),
      ],
    );
  }
}
