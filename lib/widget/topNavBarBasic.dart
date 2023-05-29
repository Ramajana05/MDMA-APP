import 'package:flutter/material.dart';
import 'package:forestapp/design/topNavBarDecoration.dart';

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
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: returnStatus,
      title: Text(
        title,
        style: topNavBarDecoration.getTitleTextStyle(),
      ),
      backgroundColor: Color.fromARGB(255, 248, 245, 245),
      centerTitle: true,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          decoration: topNavBarDecoration.getBoxDecoration(),
          height: 4.0,
        ),
      ),
      leading: returnStatus
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : IconButton(
              icon: Icon(Icons.menu),
              onPressed:
                  onMenuPressed, // Call the callback function when the menu button is pressed
            ),
    );
  }
}
