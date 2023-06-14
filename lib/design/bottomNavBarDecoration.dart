import 'package:flutter/material.dart';

BoxDecoration bottomNavBarDecoration2 = BoxDecoration(
  border: Border(
    top: BorderSide(
      color: Color.fromARGB(255, 41, 235, 15),
      width: 4.0,
    ),
  ),
  gradient: LinearGradient(
    colors: [
      Color(0xFF2DFFD9),
      Color(0xFF00FF57),
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.bottomRight,
  ),
  backgroundBlendMode: BlendMode.srcOver,
);
