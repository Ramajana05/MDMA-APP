String getWeekday(String dayName) {
  switch (dayName) {
    case "Montag":
      return 'Mo';
    case "Dienstag":
      return 'Di';
    case "Mittwoch":
      return 'Mi';
    case "Donnerstag":
      return 'Do';
    case "Freitag":
      return 'Fr';
    case "Samstag":
      return 'Sa';
    case "Sonntag":
      return 'So';
    default:
      throw Exception('Invalid day: $dayName');
  }
}

String getGermanWeekday(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return 'Montag';
    case DateTime.tuesday:
      return 'Dienstag';
    case DateTime.wednesday:
      return 'Mittwoch';
    case DateTime.thursday:
      return 'Donnerstag';
    case DateTime.friday:
      return 'Freitag';
    case DateTime.saturday:
      return 'Samstag';
    case DateTime.sunday:
      return 'Sonntag';
    default:
      return '';
  }
}