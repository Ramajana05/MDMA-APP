import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Model/IntervalTypeEnum.dart';
import 'customLineChartWidget.dart';

/// a Widget that contains the charts
Widget customStatisticContainer(IntervalType type) {
  return Container(
    margin: EdgeInsets.all(10),
    padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
    width: 330,
    height: 300,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 4,
          offset: Offset(4, 8), // Shadow position
        ),
      ],
      border: Border.all(color: Colors.grey, width: 0.5),
    ),
    child: customLineChart(
      intervalType: type,
    ),
  );
}
