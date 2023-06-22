import 'package:flutter/material.dart';

import '../colors/appColors.dart';

BoxDecoration bottomNavBarDecoration2 = const BoxDecoration(
  border: Border(
    top: BorderSide(
      color: bottomGreen,
      width: 4.0,
    ),
  ),
  gradient: LinearGradient(
    colors: bottomGradient,
    begin: Alignment.bottomLeft,
    end: Alignment.bottomRight,
  ),
  backgroundBlendMode: BlendMode.srcOver,
);
