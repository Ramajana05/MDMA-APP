import 'dart:ffi';

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}

class ChartDataHour {
  final String dataHour;
  final double tempValue;
  final int visitorValue;
  final int humidityValue;

  ChartDataHour(
      {required this.dataHour,
      required this.tempValue,
      required this.visitorValue,
      required this.humidityValue});
}
class ChartDataDay {
  final String date;
  final int visitorValue;
  final double tempValue;
  final int humidityValue;

  ChartDataDay(
      {required this.date,
        required this.tempValue,
        required this.visitorValue,
        required this.humidityValue});
}
