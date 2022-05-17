
// ignore_for_file: constant_identifier_names

library date;

import 'package:persian_datetime_picker/src/date/shamsi_date.dart';

/// Super interface of Jalali and Georgian classes
abstract class ExDate {
  /// Minimum computable julian day number
  ///
  /// equivalent to Gregorian(560,3,20) and Jalali(-61,1,1)
  /// and julian day number of 1925675
  static const int MIN_JULIAN_DAY_NUMBER = 1925675;

  /// Maximum computable julian day number
  ///
  /// equivalent to Gregorian(3798,12,31) and Jalali(3177,10,11)
  /// and julian day number of 3108616
  static const int MAX_JULIAN_DAY_NUMBER = 3108616;

  /// year
  ///
  /// non-null
  int get year;

  /// month
  ///
  /// non-null
  int get month;

  /// day
  ///
  /// non-null
  int get day;

  /// hour
  ///
  /// non-null
  int get hour;

  /// minute
  ///
  /// non-null
  int get minute;

  /// second
  ///
  /// non-null
  int get second;

  /// julian day number
  ///
  /// non-null
  int get julianDayNumber;

  /// week day number
  ///
  /// non-null
  int get weekDay;

  /// month length
  ///
  /// non-null
  int get monthLength;

  /// Formatter for this date object
  ///
  /// non-null
  DateFormatter get formatter;

  /// checks if this year is a leap year
  ///
  /// non-null
  bool isLeapYear();
}
