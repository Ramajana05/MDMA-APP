import 'package:flutter/material.dart';


BoxDecoration bottomNavBarDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(247, 0, 0, 1), // dark green
      Color.fromARGB(227, 255, 0, 0), // light green
    ],
  ),
);

BoxDecoration bottomNavBarDecoration2 = BoxDecoration(
  border: Border(
    top: BorderSide(
      color: Color.fromARGB(255, 41, 235, 15),
      width: 7.0,
    ),
  ),
  gradient: bottomNavBarDecoration.gradient,
);