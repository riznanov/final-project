
import 'package:intl/intl.dart';

class DateTimeUtils{
  static String get currenDay{
    DateTime now = DateTime.now();
    return DateFormat('EEEE').format(now);
  }
   static String get currentMonth {
    DateTime now = DateTime.now();
    return DateFormat('MMM').format(now);
  }

  static String get currentDate {
    DateTime now = DateTime.now();
    return DateFormat('d').format(now);
  }
  static String get year{
    DateTime now = DateTime.now();
    return DateFormat('2019').format(now);
  }
}