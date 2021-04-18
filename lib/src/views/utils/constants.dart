class CalenderHelper {
  final List<String> monthName = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  final List<String> weekDay = [
    'Mon',
    'Tue',
    'Wed',
    'Thur',
    'Fri',
    'Sat',
    'Sun'
  ];

  String getMonthName(DateTime m) {
    return monthName[m.month - 1];
  }

  String getMonthAndYear(DateTime d) {
    return getMonthName(d) + ' - ' + d.year.toString();
  }

  String getWeekDay(DateTime d) {
    return weekDay[d.weekday - 1];
  }
}
