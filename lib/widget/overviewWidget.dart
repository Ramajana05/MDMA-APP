import 'package:flutter/material.dart';

class OverviewContainer extends StatelessWidget {
  final String text;

  const OverviewContainer({Key? key, this.text = "Overview"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3)),
        ],
      ),
      //Overview Text
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
