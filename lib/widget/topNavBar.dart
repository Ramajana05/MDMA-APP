import 'package:flutter/material.dart';
import 'package:forestapp/design/topNavBarDecoration.dart';
import 'package:forestapp/dialog/logoutDialog.dart';
import 'package:forestapp/widget/sidePanelWidget.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuPressed;

  const TopNavBar({Key? key, required this.title, this.onMenuPressed})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          Icons.menu,
          color: Color.fromARGB(255, 40, 233, 127), // Set the color to green
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            //showDialog(
            //context: context,

            //builder: (context) => LogoutDialog(),

            //);
            // TODO: Implement logout functionality
          },
        ),
      ],
      iconTheme: IconThemeData(
        color: Color.fromARGB(
            255, 40, 233, 127), // Change this to the desired color
      ),
    );
  }
}
