import 'package:flutter/material.dart';
import 'package:forestapp/design/topNavBarDecoration.dart';

import '../colors/appColors.dart';

class TopNavBarBasic extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuPressed;
  final bool returnStatus;

  const TopNavBarBasic(
      {Key? key,
      required this.title,
      this.onMenuPressed,
      required this.returnStatus})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: returnStatus,
      title: Text(
        title,
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
          Icons.arrow_back,
          color: primaryAppLightGreen // Set the color to green
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      iconTheme: IconThemeData(
        color: primaryAppLightGreen, // Change this to the desired color
      ),
    );
  }
}
