import 'package:flutter/material.dart';
import 'package:forestapp/widget/topNavBar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    var temperature = 25;
    var visitors = 1234;
    var airPressure = 1013;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      appBar: TopNavBar(
        title: 'Dashboard',
        onMenuPressed: () {
          // Add your side panel logic here
        },
      ),
      body: Column(children: [
        //Overview Header
        Container(
          height: 70,
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
          child: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Overview",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        //Visitors, Temperature and Air pressure
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2.0,
                blurRadius: 2.0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          //Visitors
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
              height: 213,
              decoration: BoxDecoration(
                  color: const Color(0xff86ffd6),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Besucher Aktuell',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    visitors.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: visitors > 2000 ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            //Temperature
            Column(children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFCEFFCD),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Temperatur',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      '$temperature°C',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: temperature >= 25
                            ? Colors.red
                            : temperature >= 15
                                ? Colors.orange
                                : Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(3, 255, 94, 0.25),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Luftdruck',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "${airPressure}hPa",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: airPressure < 1000 || airPressure > 1100
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ]),
        ),
      ]),
    );
  }
}
