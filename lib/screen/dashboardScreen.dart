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
      body: Column(
        children: [
          //Overview Header
          Container(
            height: 70,
            alignment: Alignment.centerLeft,
            //   decoration: BoxDecoration(
            //  color: Colors.white,
            //  boxShadow: [
            //        BoxShadow(
            //               color: Colors.grey.withOpacity(0.4),
            //             spreadRadius: 1,
            //        blurRadius: 5,
            //        offset: const Offset(0, 3)),
            //      ],
            //     ),
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
          //Visitors
          Container(
            padding: const EdgeInsets.all(16),
            //  decoration: BoxDecoration(
            // color: Colors.white,
            // boxShadow: [
            //    BoxShadow(
            //     color: Colors.grey.withOpacity(0.5),
            //      spreadRadius: 2,
            //      blurRadius: 2,
            //      offset: const Offset(0, 1),
            //     ),
            //    ],
            //      ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: const Color(0xff86ffd6),
                        borderRadius: BorderRadius.circular(20)),
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Besucher Aktuell',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          visitors.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.only(
                          top: 20, left: 35, right: 35, bottom: 20),
                      child: Column(
                        children: [
                          const Text(
                            'Temperatur',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '$temperature°C',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
                    const SizedBox(height: 14),
                    //Air Pressure
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(3, 255, 94, 0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.only(
                          left: 40, right: 40, top: 20, bottom: 20),
                      child: Column(children: [
                        const Text(
                          'Luftdruck',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${airPressure}hPa",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: airPressure < 1000 || airPressure > 1100
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                      ]),
                    ),
                  ]),
                ]),
          ),
          //Neueste
          Container(
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
                // color: Colors.white,
                ),
            child: const Padding(
              padding: EdgeInsets.all(13),
              child: Text(
                "Neueste",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
          //News
          Padding(
            padding: const EdgeInsets.all(11),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons8-megaphone-64.png',
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Neuigkeit',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 61),
                    child: Text(
                      'Ein neuer Schaden wurde hinzugefügt.',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //Warning
          Padding(
            padding: const EdgeInsets.all(11),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons8-warning-50.png',
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Warnung',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 61),
                    child: Text(
                      'Bereich 4 sind zu viele Besucher.',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
