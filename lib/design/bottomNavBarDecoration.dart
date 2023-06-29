import 'package:flutter/material.dart';

/// The `bottomNavBarDecoration2` defines the decoration for the bottom navigation bar.
/// It consists of a top border with a specified color and width.
/// The background is filled with a gradient that starts from the bottom left and ends at the bottom right,
/// using the specified colors.
/// The background blend mode is set to `BlendMode.srcOver`.

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
