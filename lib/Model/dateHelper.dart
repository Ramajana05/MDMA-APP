String getWeekday(int day) {
  switch (day) {
    case 1:
      return 'Mo';
    case 2:
      return 'Di';
    case 3:
      return 'Mi';
    case 4:
      return 'Do';
    case 5:
      return 'Fr';
    case 6:
      return 'Sa';
    case 7:
      return 'So';
    default:
      throw Exception('Invalid day: $day');
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