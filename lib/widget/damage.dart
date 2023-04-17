import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Please don't delete this part, it could be that we have to implement this widget as a class





// class DamagesListItemWidget extends StatefulWidget {
//   final String damageTitle;
//   final String damageDescription;
//   final String status;
//
//   DamagesListItemWidget(
//       {Key? key,
//       required this.damageTitle,
//       required this.damageDescription,
//       required this.status}):super(key: key);
//
//   @override
//   State<DamagesListItemWidget> createState() {
//     return _DamagesListItemWidget();
//   }
// }

Widget DamagesListItemWidget(String damageTitle, String damageDescription,
    String status, String createDate) {
  return Card(
    color: Colors.white60,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(
        flex: 3,
        child: ListTile(
          title: Text(damageTitle),
          subtitle: Text(damageDescription),
        ),
        // child: Column(
        //   children: [Text(damageTitle), Text(damageTitle))],
        // ),
      ),
      Flexible(
        flex: 2,
        child: ListTile(
          title: Text(status,
              style: TextStyle(
                  color: status == 'abgeschlossen'
                      ? Colors.green
                      : status == "In Bearbeitung"
                          ? Colors.red
                          : Colors.orangeAccent)),
          subtitle: Text(createDate),
        ),
      ),
    ]),
  );
}
