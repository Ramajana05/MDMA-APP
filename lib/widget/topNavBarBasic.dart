import 'package:flutter/material.dart';
import 'package:forestapp/design/topNavBarDecoration.dart';
import 'package:forestapp/dialog/logoutDialog.dart';

class TopNavBarBasic extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuPressed;

  const TopNavBarBasic({Key? key, required this.title, this.onMenuPressed})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: topNavBarDecoration.getTitleTextStyle(),
      ),
      backgroundColor: Color.fromARGB(255, 232, 241, 232),
      centerTitle: true,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          decoration: topNavBarDecoration.getBoxDecoration(),
          height: 4.0,
        ),
      ),
    );
  }
}
