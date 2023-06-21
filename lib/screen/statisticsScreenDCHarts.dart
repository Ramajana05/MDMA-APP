// import 'package:flutter/material.dart';
// import 'package:forestapp/widget/topNavBar.dart';
// import 'package:forestapp/design/topNavBarDecoration.dart';
// import 'package:d_chart/d_chart.dart';
// import '../dialog/logoutDialog.dart';

// class StatisticsScreen1 extends StatefulWidget {
//   StatisticsScreen1({Key? key}) : super(key: key);

//   @override
//   State<StatisticsScreen1> createState() => _StatisticsScreen1();
// }

// class _StatisticsScreen1 extends State<StatisticsScreen1> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 227, 227, 227),
//       appBar: TopNavBar(
//         title: 'STATISTIKS',
//         onMenuPressed: () {
//           // Add your side panel logic here
//         },
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Container(
//             decoration: const BoxDecoration(
//                 border:
//                     Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(20, 8, 20, 15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Text(
//                     "Overview",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   Text("Heute",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
//                 ],
//               ),
//             ),
//           ),
//           DefaultTabController(
//               length: 4,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   const TabBar(
//                     isScrollable: true,
//                     labelColor: Colors.green,
//                     indicatorColor: Colors.green,
//                     unselectedLabelColor: Colors.black,
//                     labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                     tabs: [
//                       Tab(
//                         text: "Besucher",
//                       ),
//                       Tab(
//                         text: "Sensoren",
//                       ),
//                       Tab(
//                         text: "Temparatur",
//                       ),
//                       Tab(
//                         text: "Luftfeuchtigkeit",
//                       )
//                     ],
//                   ),
//                   Container(
//                     height: 400,
//                     padding: const EdgeInsets.all(20),
//                     decoration: const BoxDecoration(
//                         border: Border(
//                             top: BorderSide(color: Colors.grey, width: 0.5))),
//                     child: TabBarView(children: <Widget>[
//                       Container(
//                         child: ListView(
//                           shrinkWrap: true,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "Besucheranzahl der letzen Woche",
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: const EdgeInsets.only(
//                                       left: 20, right: 20, top: 30, bottom: 20),
//                                   width: 300,
//                                   height: 300,
//                                   decoration: const BoxDecoration(
//                                       color: Colors.white70,
//                                       borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(10),
//                                           topRight: Radius.circular(10),
//                                           bottomLeft: Radius.circular(10),
//                                           bottomRight: Radius.circular(10)),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey,
//                                           blurRadius: 4,
//                                           offset:
//                                               Offset(4, 8), // Shadow position
//                                         ),
//                                       ],
//                                       border: Border(
//                                           bottom: BorderSide(
//                                               color: Colors.grey, width: 0.5),
//                                           top: BorderSide(
//                                               color: Colors.grey, width: 0.5),
//                                           right: BorderSide(
//                                               color: Colors.grey, width: 0.5),
//                                           left: BorderSide(
//                                               color: Colors.grey, width: 0.5))),
//                                   child: DChartBar(
//                                     data: const [
//                                       {
//                                         'id': 'Bar',
//                                         'data': [
//                                           {
//                                             'domain': 'Donnerstag',
//                                             'measure': 2
//                                           },
//                                           {'domain': 'Freitag', 'measure': 18},
//                                           {'domain': 'Samstag', 'measure': 10},
//                                           {'domain': 'Sonntag', 'measure': 20},
//                                           {'domain': 'Montag', 'measure': 3},
//                                           {'domain': 'Dienstag', 'measure': 12},
//                                           {'domain': 'Heute', 'measure': 8},
//                                         ],
//                                       },
//                                     ],
//                                     domainLabelRotation: 270,
//                                     xAxisTitle: "Woche 20",
//                                     yAxisTitle: "Besucheranzahl",
//                                     axisLineTick: 2,
//                                     axisLinePointTick: 2,
//                                     axisLinePointWidth: 10,
//                                     axisLineColor: Colors.black38,
//                                     domainLabelFontSize: 10,
//                                     measureLabelPaddingToAxisLine: 16,
//                                     domainLabelPaddingToAxisLine: 60,
//                                     barColor: (barData, index, id) =>
//                                         Colors.green,
//                                     showBarValue: true,
//                                   ),
//                                 ),
//                                 const Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "Besucheranzahl an den Standorte",
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: const EdgeInsets.only(
//                                       left: 20, right: 20, top: 30, bottom: 10),
//                                   width: 300,
//                                   height: 300,
//                                   decoration: const BoxDecoration(
//                                       color: Colors.white70,
//                                       borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(10),
//                                           topRight: Radius.circular(10),
//                                           bottomLeft: Radius.circular(10),
//                                           bottomRight: Radius.circular(10)),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey,
//                                           blurRadius: 4,
//                                           offset:
//                                               Offset(4, 8), // Shadow position
//                                         ),
//                                       ],
//                                       border: Border(
//                                           bottom: BorderSide(
//                                               color: Colors.grey, width: 0.5),
//                                           top: BorderSide(
//                                               color: Colors.grey, width: 0.5),
//                                           right: BorderSide(
//                                               color: Colors.grey, width: 0.5),
//                                           left: BorderSide(
//                                               color: Colors.grey, width: 0.5))),
//                                   child: DChartBar(
//                                     data: const [
//                                       {
//                                         'id': 'Bar',
//                                         'data': [
//                                           {
//                                             'domain': 'Walderlebnispfad',
//                                             'measure': 2
//                                           },
//                                           {
//                                             'domain': 'Waldheide',
//                                             'measure': 18
//                                           },
//                                           {
//                                             'domain': 'Grillstelle',
//                                             'measure': 10
//                                           },
//                                           {
//                                             'domain': 'NSG Köpfertal',
//                                             'measure': 20
//                                           },
//                                           {'domain': 'Sportpfad', 'measure': 3},
//                                           {
//                                             'domain': 'MTB-Downhillstrecke',
//                                             'measure': 6
//                                           },
//                                           {
//                                             'domain': '(Hoch-)Schulwald',
//                                             'measure': 14
//                                           },
//                                         ],
//                                       },
//                                     ],
//                                     domainLabelRotation: 270,
//                                     xAxisTitle: "Standort",
//                                     yAxisTitle: "Besucheranzahl",
//                                     axisLineTick: 2,
//                                     axisLinePointTick: 2,
//                                     axisLinePointWidth: 10,
//                                     axisLineColor: Colors.black38,
//                                     measureLabelPaddingToAxisLine: 16,
//                                     domainLabelPaddingToAxisLine: 100,
//                                     domainLabelFontSize: 10,
//                                     barColor: (barData, index, id) =>
//                                         Colors.green,
//                                     showBarValue: true,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                       Container(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             const Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Text(
//                                 "Sensoren Feldstärke am Standort",
//                                 style: TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.only(
//                                   left: 20, right: 20, top: 30, bottom: 10),
//                               width: 300,
//                               height: 230,
//                               decoration: const BoxDecoration(
//                                   color: Colors.white70,
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(10),
//                                       topRight: Radius.circular(10),
//                                       bottomLeft: Radius.circular(10),
//                                       bottomRight: Radius.circular(10)),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey,
//                                       blurRadius: 4,
//                                       offset: Offset(4, 8), // Shadow position
//                                     ),
//                                   ],
//                                   border: Border(
//                                       bottom: BorderSide(
//                                           color: Colors.grey, width: 0.5),
//                                       top: BorderSide(
//                                           color: Colors.grey, width: 0.5),
//                                       right: BorderSide(
//                                           color: Colors.grey, width: 0.5),
//                                       left: BorderSide(
//                                           color: Colors.grey, width: 0.5))),
//                               child: DChartBar(
//                                 data: const [
//                                   {
//                                     'id': 'Bar',
//                                     'data': [
//                                       {'domain': 'TemSen 1', 'measure': 12},
//                                       {'domain': 'TemSen 2', 'measure': 18},
//                                       {'domain': 'TemSen 5', 'measure': 5},
//                                       {'domain': 'HumiSen 4', 'measure': 30},
//                                       {'domain': 'TemSen 9', 'measure': 5},
//                                       {'domain': 'HumiSen 12', 'measure': 12},
//                                     ],
//                                   },
//                                 ],
//                                 domainLabelRotation: 270,
//                                 domainLabelPaddingToAxisLine: 60,
//                                 domainLabelFontSize: 10,
//                                 xAxisTitle: "Sensor",
//                                 yAxisTitle: "Feldstärke",
//                                 axisLineTick: 2,
//                                 axisLinePointTick: 2,
//                                 axisLinePointWidth: 10,
//                                 axisLineColor: Colors.green,
//                                 measureLabelPaddingToAxisLine: 16,
//                                 barColor: (barData, index, id) => Colors.green,
//                                 showBarValue: true,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               "Temapartuen der letzten Woche",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.only(
//                                 left: 20, right: 20, top: 30, bottom: 10),
//                             width: 300,
//                             height: 230,
//                             decoration: const BoxDecoration(
//                                 color: Colors.white70,
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),
//                                     topRight: Radius.circular(10),
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10)),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey,
//                                     blurRadius: 4,
//                                     offset: Offset(4, 8), // Shadow position
//                                   ),
//                                 ],
//                                 border: Border(
//                                     bottom: BorderSide(
//                                         color: Colors.grey, width: 0.5),
//                                     top: BorderSide(
//                                         color: Colors.grey, width: 0.5),
//                                     right: BorderSide(
//                                         color: Colors.grey, width: 0.5),
//                                     left: BorderSide(
//                                         color: Colors.grey, width: 0.5))),
//                             child: DChartBar(
//                               data: const [
//                                 {
//                                   'id': 'Bar',
//                                   'data': [
//                                     {'domain': 'Donnerstag', 'measure': 2},
//                                     {'domain': 'Freitag', 'measure': 18},
//                                     {'domain': 'Samstag', 'measure': 10},
//                                     {'domain': 'Sonntag', 'measure': 20},
//                                     {'domain': 'Montag', 'measure': 3},
//                                     {'domain': 'Dienstag', 'measure': 12},
//                                     {'domain': 'Heute', 'measure': 8},
//                                   ],
//                                 },
//                               ],
//                               domainLabelRotation: 270,
//                               domainLabelPaddingToAxisLine: 60,
//                               xAxisTitle: "Woche 20",
//                               yAxisTitle: "Temparatur",
//                               axisLineTick: 2,
//                               axisLinePointTick: 2,
//                               axisLinePointWidth: 10,
//                               axisLineColor: Colors.green,
//                               domainLabelFontSize: 10,
//                               measureLabelPaddingToAxisLine: 16,
//                               barColor: (barData, index, id) => Colors.green,
//                               showBarValue: true,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 "Luftfeuchtigkeit der letzten Woche",
//                                 style: TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.only(
//                                   left: 20, right: 20, top: 30, bottom: 10),
//                               width: 300,
//                               height: 230,
//                               decoration: const BoxDecoration(
//                                   color: Colors.white70,
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(10),
//                                       topRight: Radius.circular(10),
//                                       bottomLeft: Radius.circular(10),
//                                       bottomRight: Radius.circular(10)),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey,
//                                       blurRadius: 4,
//                                       offset: Offset(4, 8), // Shadow position
//                                     ),
//                                   ],
//                                   border: Border(
//                                       bottom: BorderSide(
//                                           color: Colors.grey, width: 0.5),
//                                       top: BorderSide(
//                                           color: Colors.grey, width: 0.5),
//                                       right: BorderSide(
//                                           color: Colors.grey, width: 0.5),
//                                       left: BorderSide(
//                                           color: Colors.grey, width: 0.5))),
//                               child: DChartBar(
//                                 data: const [
//                                   {
//                                     'id': 'Bar',
//                                     'data': [
//                                       {'domain': 'Donnerstag', 'measure': 2},
//                                       {'domain': 'Freitag', 'measure': 18},
//                                       {'domain': 'Samstag', 'measure': 10},
//                                       {'domain': 'Sonntag', 'measure': 20},
//                                       {'domain': 'Montag', 'measure': 3},
//                                       {'domain': 'Dienstag', 'measure': 12},
//                                       {'domain': 'Heute', 'measure': 8},
//                                     ],
//                                   },
//                                 ],
//                                 domainLabelRotation: 270,
//                                 domainLabelPaddingToAxisLine: 60,
//                                 domainLabelFontSize: 10,
//                                 xAxisTitle: "Woche 20",
//                                 yAxisTitle: "Luftfeuchtigkeit",
//                                 axisLineTick: 2,
//                                 axisLinePointTick: 2,
//                                 axisLinePointWidth: 10,
//                                 axisLineColor: Colors.green,
//                                 measureLabelPaddingToAxisLine: 16,
//                                 barColor: (barData, index, id) => Colors.green,
//                                 showBarValue: true,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ]),
//                   )
//                 ],
//               ))
//         ],
//       ),
//     );
//   }
// }

// class VisitorModel {
//   DateTime dateTime;
//   int numberOfVisitors;

//   VisitorModel({required this.dateTime, required this.numberOfVisitors});
// }
