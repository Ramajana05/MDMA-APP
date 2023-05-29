// import 'package:fl_chart/src/chart/bar_chart/bar_chart_data.dart';
// import 'package:flutter/material.dart';
// import 'package:forestapp/Model/HumidityModel.dart';
// import 'package:forestapp/widget/customBarChartWidget.dart';
// import 'package:forestapp/widget/customStatisticContainerWidget.dart';
// import 'package:forestapp/widget/topNavBar.dart';
// import 'package:forestapp/design/topNavBarDecoration.dart';
// import 'package:d_chart/d_chart.dart';
// import '../Model/TemperatreModel.dart';
// import '../Model/DateVisitorModel.dart';
// import '../dialog/logoutDialog.dart';
//
// class StatisticsScreen1 extends StatefulWidget {
//   StatisticsScreen1({Key? key}) : super(key: key);
//
//   @override
//   State<StatisticsScreen1> createState() => _StatisticsScreen2();
// }
//
// class _StatisticsScreen2 extends State<StatisticsScreen1> {
//   //lists include the data for the charts
//   List<DateVisitorModel> personsData = [
//     DateVisitorModel(date: 0, numberOfVisitors: 2),
//     DateVisitorModel(date: 1, numberOfVisitors: 15),
//     DateVisitorModel(date: 2, numberOfVisitors: 8),
//     DateVisitorModel(date: 3, numberOfVisitors: 17),
//     DateVisitorModel(date: 4, numberOfVisitors: 2),
//     DateVisitorModel(date: 5, numberOfVisitors: 10),
//     DateVisitorModel(date: 6, numberOfVisitors: 5),
//   ];
//
//   List<TemperatureModel> tempratureData = [
//     TemperatureModel(date: 0, temprature: 12.5),
//     TemperatureModel(date: 1, temprature: 14.8),
//     TemperatureModel(date: 2, temprature: 4.5),
//     TemperatureModel(date: 3, temprature: -18),
//     TemperatureModel(date: 4, temprature: 3),
//     TemperatureModel(date: 5, temprature: 6.8),
//     TemperatureModel(date: 6, temprature: 9),
//   ];
//   List<HumidityModel> humidityData = [
//     HumidityModel(date: 0, humidity: 1),
//     HumidityModel(date: 1, humidity: 89),
//     HumidityModel(date: 2, humidity: 64),
//     HumidityModel(date: 3, humidity: 23),
//     HumidityModel(date: 4, humidity: 92),
//     HumidityModel(date: 5, humidity: 80),
//     HumidityModel(date: 6, humidity: 66),
//   ];
//
//   //sub-lists include only x or y values subtracted from the data-lists above
//   late List<double> x_values;
//   late List<double> y_values;
//
//   //to get the x values for the chart
//   List<double> _get_x_values(List<Object> data) {
//     if (data == personsData) {
//       return x_values = personsData.map((person) => person.date).toList();
//     } else if (data == tempratureData) {
//       return x_values =
//           tempratureData.map((temperature) => temperature.date).toList();
//     } else {
//       return x_values = humidityData.map((humidity) => humidity.date).toList();
//     }
//   }
//
//   //to get the y values for the chart
//   List<double> _get_y_values(List<Object> data) {
//     if (data == personsData) {
//       return y_values =
//           personsData.map((person) => person.numberOfVisitors).toList();
//     } else if (data == tempratureData) {
//       return y_values =
//           tempratureData.map((person) => person.temprature).toList();
//     } else {
//       return y_values =
//           humidityData.map((humidity) => humidity.humidity).toList();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     customBarChart personsBarChartWidget =
//         customBarChart(_get_x_values(personsData), _get_y_values(personsData));
//     customBarChart temperatureBarChartWidget = customBarChart(
//         _get_x_values(tempratureData), _get_y_values(tempratureData));
//     customBarChart humidityBarChartWidget = customBarChart(
//         _get_x_values(humidityData), _get_y_values(humidityData));
//
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 227, 227, 227),
//       appBar: TopNavBar(
//         title: 'STATISTIKS',
//         onMenuPressed: () {
//           // Add your side panel logic here
//         },
//       ),
//       body: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Container(
//               decoration: const BoxDecoration(
//                   border: Border(
//                       bottom: BorderSide(color: Colors.grey, width: 0.5))),
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 8, 20, 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text(
//                       "Overview",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     Text("Heute",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold))
//                   ],
//                 ),
//               ),
//             ),
//             DefaultTabController(
//                 length: 4,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     //Container includes the TabBar
//                     Container(
//                       child: const TabBar(
//                         isScrollable: true,
//                         labelColor: Colors.green,
//                         indicatorColor: Colors.green,
//                         unselectedLabelColor: Colors.black,
//                         labelStyle: TextStyle(fontWeight: FontWeight.bold),
//                         tabs: [
//                           Tab(
//                             text: "Besucher",
//                           ),
//                           Tab(
//                             text: "Sensoren",
//                           ),
//                           Tab(
//                             text: "Temparatur",
//                           ),
//                           Tab(
//                             text: "Luftfeuchtigkeit",
//                           )
//                         ],
//                       ),
//                     ),
//                     //
//                     //Container includes the statistics related to each TabBar
//                     //
//                     Container(
//                       width: MediaQuery.of(context).size.width -
//                           MediaQuery.of(context).viewPadding.left -
//                           MediaQuery.of(context).viewPadding.right,
//                       height: MediaQuery.of(context)
//                               .size
//                               .height - // total height
//                           kToolbarHeight - // top AppBar height
//                           MediaQuery.of(context).padding.top - // top padding
//                           kBottomNavigationBarHeight -
//                           120,
//                       padding: const EdgeInsets.all(10),
//                       decoration: const BoxDecoration(
//                           border: Border(
//                               top: BorderSide(color: Colors.grey, width: 0.5))),
//                       child: TabBarView(children: <Widget>[
//                         Container(
//                           child: ListView(
//                             shrinkWrap: true,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: [
//                                   const Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text(
//                                       "Besucheranzahl der letzen Woche",
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   customStatisticContainer(
//                                       personsBarChartWidget),
//                                   const Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text(
//                                       "Besucheranzahl an den Standorte",
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   customStatisticContainer(
//                                       personsBarChartWidget),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         Container(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   "Sensoren Feldstärke am Standort",
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               customStatisticContainer(personsBarChartWidget),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   "Temapartuen der letzten Woche",
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               customStatisticContainer(
//                                   temperatureBarChartWidget),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   "Luftfeuchtigkeit der letzten Woche",
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               customStatisticContainer(humidityBarChartWidget),
//                             ],
//                           ),
//                         ),
//                       ]),
//                     )
//                   ],
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // DateTime now = DateTime.now();
// // int weekday = now.weekday;
// //
// // int weekday = now.weekday - 1;
// // if (weekday < 0) {
// // weekday = 6;
// // }
