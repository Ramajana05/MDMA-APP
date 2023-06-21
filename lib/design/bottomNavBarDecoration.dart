import 'package:flutter/material.dart';

import '../colors/appColors.dart';

BoxDecoration bottomNavBarDecoration2 = BoxDecoration(
  border: const Border(
    top: BorderSide(
      color: bottomGreen,
      width: 4.0,
    ),
  ),
  gradient: const LinearGradient(
    colors: bottomGradient,
    begin: Alignment.bottomLeft,
    end: Alignment.bottomRight,
  ),
  backgroundBlendMode: BlendMode.srcOver,
);
