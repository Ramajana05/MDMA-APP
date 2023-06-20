import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget DamagesListItemWidget(String damageTitle, String damageDescription,
    String status, String createDate) {
  Color statusColor = getStatusColor(status);
  Color createDateColor = getCreateDateColor(createDate);

  return Card(
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 3,
          child: ListTile(
            title: Text(damageTitle),
            subtitle: Text(damageDescription),
          ),
        ),
        Flexible(
          flex: 2,
          child: ListTile(
            title: Text(
              status,
              style: TextStyle(color: statusColor),
            ),
            subtitle: Text(
              createDate,
              style: TextStyle(color: createDateColor),
            ),
          ),
        ),
      ],
    ),
  );
}

Color getStatusColor(String status) {
  if (status == 'Stark') {
    return Color.fromARGB(255, 54, 54, 54);
  } else if (status == 'Mittel') {
    return Color.fromARGB(255, 43, 43, 43);
  } else {
    return Color.fromARGB(255, 63, 63, 63);
  }
}

Color getCreateDateColor(String createDate) {
  if (createDate == 'Online') {
    return const Color.fromARGB(255, 96, 240, 100);
  } else {
    return Colors.black;
  }
}
