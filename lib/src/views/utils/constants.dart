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

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

class MyDateTime {
  DateTime _time;
  String _hashString;
  MyDateTime(DateTime d) {
    this._time = d;
    _hashString = _time.day.toString() +
        '' +
        _time.month.toString() +
        '' +
        _time.year.toString();
  }

  DateTime getDate() {
    return this._time;
  }

  @override
  int get hashCode => _hashString.hashCode;

  @override
  bool operator ==(Object date) {
    return date is MyDateTime &&
        this._time.year == date._time.year &&
        this._time.month == date._time.month &&
        this._time.day == date._time.day;
  }
}
