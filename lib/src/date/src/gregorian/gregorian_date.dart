// Copyright 2018 - 2021, Amirreza Madani. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library gregorian_date;

import '../date.dart';
import '../date_exception.dart';
import '../gregorian/gregorian_formatter.dart';
import '../jalali/jalali_date.dart';

/// Gregorian (Miladi or Milaadi) date class
///
/// Date objects are required to be immutable
///
/// Dates should be uniquely specified by year, month and day
/// Or by using julian day number
///
/// Date objects are valid dates once constructed,
/// It should throw exception when there is a validity or calculation problem
///
/// For example constructing date with day being out of month length
/// or date being out of computable region throws DateException
class Gregorian implements Date, Comparable<Gregorian> {
  /// Gregorian month lengths
  ///
  /// For month 2 (index 1) should check leap year
  static const List<int> _MONTH_LENGTHS = <int>[
    31,
    0, // should check leap year
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31,
  ];

  /// Minimum computable Gregorian date
  ///
  /// equivalent to Gregorian(560,3,20) and Jalali(-61,1,1)
  /// and julian day number of 1925675
  static final Gregorian min = Gregorian(560, 3, 20);

  /// Maximum computable Gregorian date
  ///
  /// equivalent to Gregorian(3798,12,31) and Jalali(3177,10,11)
  /// and julian day number of 3108616
  static final Gregorian max = Gregorian(3798, 12, 31);

  /// Gregorian year (years BC numbered 0, -1, -2, ...)
  @override
  final int year;

  /// Gregorian month (1 to 12)
  @override
  final int month;

  /// Gregorian day of the month (1 to 28/29/30/31)
  @override
  final int day;

  /// Hour
  @override
  final int hour;

  /// Minute
  @override
  final int minute;

  /// second
  @override
  final int second;

  /// Calculates the Julian Day number from Gregorian or Julian
  /// calendar dates. This integer number corresponds to the noon of
  /// the date (i.e. 12 hours of Universal Time).
  ///
  /// The procedure was tested to be good since 1 March, -100100 (of both
  /// calendars) up to a few million years into the future.
  @override
  int get julianDayNumber {
    return (((year + ((month - 8) ~/ 6) + 100100) * 1461) ~/ 4) +
        ((153 * ((month + 9) % 12) + 2) ~/ 5) +
        day -
        34840408 -
        ((((year + 100100 + ((month - 8) ~/ 6)) ~/ 100) * 3) ~/ 4) +
        752;
  }

  /// Week day number
  /// [monday] = 1
  /// [sunday] = 7
  @override
  int get weekDay {
    return julianDayNumber % 7 + 1;
  }

  /// Computes number of days in a given month in a Gregorian year.
  @override
  int get monthLength {
    if (month == 2) {
      return isLeapYear() ? 29 : 28;
    } else {
      return _MONTH_LENGTHS[month - 1];
    }
  }

  /// Formatter for this date object
  @override
  GregorianFormatter get formatter {
    return GregorianFormatter(this);
  }

  /// Create a Gregorian date by using [year], [month] and [day]
  ///
  /// year and month default to 1
  Gregorian(int year,
      [int month = 1,
      int day = 1,
      int hour = 0,
      int minute = 0,
      int second = 0])
      : year = year,
        month = month,
        day = day,
        hour = hour,
        minute = minute,
        second = second {
    // should be between: Gregorian(560,3,20) and Gregorian(3798,12,31)
    if (year < 560 || year > 3798) {
      throw DateException('Gregorian date is out of computable range.');
    }

    if (month < 1 || month > 12) {
      throw DateException('Gregorian month is out of valid range.');
    }

    // monthLength is very cheap
    // isLeapYear is also very cheap
    final ml = monthLength;

    if (day < 1 || day > ml) {
      throw DateException('Gregorian day is out of valid range.');
    }

    // no need for further analysis for MAX, but for MIN being in year 560:
    if (year == 560) {
      if (month < 3 || (month == 3 && day < 20)) {
        throw DateException('Gregorian date is out of computable range.');
      }
    }
  }

  /// Calculates Gregorian and Julian calendar dates from the Julian Day number
  /// [julianDayNumber] for the period since jdn=-34839655
  /// (i.e. the year -100100 of both calendars)
  /// to some millions years ahead of the present.
  factory Gregorian.fromJulianDayNumber(final int julianDayNumber) {
    if (julianDayNumber < 1925675 || julianDayNumber > 3108616) {
      throw DateException('Julian day number is out of computable range.');
    }

    final int j = 4 * julianDayNumber +
        139361631 +
        ((((4 * julianDayNumber + 183187720) ~/ 146097) * 3) ~/ 4) * 4 -
        3908;
    final int i = (((j % 1461)) ~/ 4) * 5 + 308;
    final int gd = (((i % 153)) ~/ 5) + 1;
    final int gm = (((i) ~/ 153) % 12) + 1;
    final int gy = ((j) ~/ 1461) - 100100 + ((8 - gm) ~/ 6);

    return Gregorian(gy, gm, gd);
  }

  /// Create a Gregorian date by using [DateTime] object
  factory Gregorian.fromDateTime(DateTime dateTime) {
    return Gregorian(dateTime.year, dateTime.month, dateTime.day);
  }

  /// Create a Gregorian date from Jalali date
  factory Gregorian.fromJalali(Jalali date) {
    return Gregorian.fromJulianDayNumber(date.julianDayNumber);
  }

  /// Get Gregorian date for now
  factory Gregorian.now() {
    return Gregorian.fromDateTime(DateTime.now());
  }

  /// Copy this date object with some fields changed
  ///
  /// Original date object remains unchanged
  ///
  /// You can leave out items for not changing them
  ///
  /// This method is NOT safe
  ///
  /// This method does change all fields at once,
  /// Not individually in a order
  ///
  /// Throws DateException on problems
  ///
  /// Note: For ordering use with*() methods
  @override
  Gregorian copy({int? year, int? month, int? day,int? hour,int? minute,int? second}) {
    if (year == null && month == null && day == null && hour == null && minute == null && second == null) {
      return this;
    } else {
      return Gregorian(
        year ?? this.year,
        month ?? this.month,
        day ?? this.day,
        hour ?? this.hour,
        minute ?? this.minute,
        second ?? this.second,
      );
    }
  }

  /// Converts Gregorian date to [DateTime] object
  DateTime toDateTime() {
    return DateTime(year, month, day, hour, minute, second);
  }

  /// Converts a Gregorian date to Jalali.
  Jalali toJalali() {
    return Jalali.fromJulianDayNumber(julianDayNumber);
  }

  /// Checks if a year is a leap year or not.
  @override
  bool isLeapYear() {
    if (year % 4 == 0) {
      if (year % 100 == 0) {
        return year % 400 == 0;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  /// Default string representation: `Gregorian(YYYY, MM, DD)`.
  /// use formatter for custom formatting.
  @override
  String toString() {
    return 'Gregorian($year, $month, $day)';
  }

  /// Compare dates
  @override
  int compareTo(Gregorian other) {
    if (year != other.year) {
      return year > other.year ? 1 : -1;
    }

    if (month != other.month) {
      return month > other.month ? 1 : -1;
    }

    if (day != other.day) {
      return day > other.day ? 1 : -1;
    }

    return 0;
  }

  /// bigger than operator
  bool operator >(Gregorian other) {
    return compareTo(other) > 0;
  }

  /// bigger than or equal operator
  bool operator >=(Gregorian other) {
    return compareTo(other) >= 0;
  }

  /// less than operator
  bool operator <(Gregorian other) {
    return compareTo(other) < 0;
  }

  /// less than or equal operator
  bool operator <=(Gregorian other) {
    return compareTo(other) <= 0;
  }

  /// Add [days]
  ///
  /// Original date object remains unchanged
  ///
  /// This Method is safe
  ///
  /// Note: This is same as addDays(days)
  @override
  Gregorian operator +(int days) {
    return addDays(days);
  }

  /// Subtract [days]
  ///
  /// Original date object remains unchanged
  ///
  /// This Method is safe
  ///
  /// Note: This is same as addDays(-days)
  @override
  Gregorian operator -(int days) {
    return addDays(-days);
  }

  /// makes a new date instance and
  /// add [days], [months] and [years] separately
  ///
  /// Original date object remains unchanged
  ///
  /// Note: It does not make any conversion,
  /// it simply adds to each field value and changes ALL at once
  ///
  /// This Method is NOT safe for month and day bounds
  ///
  /// Recommended: Use separate add*() methods
  @override
  Gregorian add({int years = 0, int months = 0, int days = 0}) {
    if (years == 0 && months == 0 && days == 0) {
      return this;
    } else {
      return Gregorian(
        year + years,
        month + months,
        day + days,
      );
    }
  }

  /// Makes a new date object with
  /// added [years] to this date
  ///
  /// Original date object remains unchanged
  ///
  /// This method is safe
  @override
  Gregorian addYears(int years) {
    if (years == 0) {
      return this;
    } else {
      return Gregorian(year + years, month, day);
    }
  }

  /// Makes a new date object with
  /// added [months] to this date
  ///
  /// Original date object remains unchanged
  ///
  /// This method is NOT safe for day being out of month length,
  /// But is safe for month overflow
  ///
  /// Throws DateException on problems
  @override
  Gregorian addMonths(int months) {
    if (months == 0) {
      return this;
    } else {
      // this is fast enough, no need for further optimization
      final int sum = month + months - 1;
      final int mod = sum % 12;
      // can not use "sum ~/ 12" directly
      final int deltaYear = (sum - mod) ~/ 12;

      return Gregorian(year + deltaYear, mod + 1, day);
    }
  }

  /// makes a new date object with
  /// added [days] to this date
  ///
  /// Original date object remains unchanged
  ///
  /// this Method is safe
  @override
  Gregorian addDays(int days) {
    if (days == 0) {
      return this;
    } else {
      return Gregorian.fromJulianDayNumber(julianDayNumber + days);
    }
  }

  /// Make a new date object with changed [year]
  ///
  /// Original date object remains unchanged
  ///
  /// This method is NOT safe
  ///
  /// Throws DateException on problems
  ///
  /// Note: For changing at once use copy() methods
  ///
  /// Note: You can chain methods
  @override
  Gregorian withYear(int year) {
    if (year == this.year) {
      return this;
    } else {
      return Gregorian(year, month, day);
    }
  }

  /// Make a new date object with changed [month]
  ///
  /// Original date object remains unchanged
  ///
  /// This method is NOT safe
  ///
  /// Throws DateException on problems
  ///
  /// Note: For changing at once use copy() methods
  ///
  /// Note: You can chain methods
  @override
  Gregorian withMonth(int month) {
    if (month == this.month) {
      return this;
    } else {
      return Gregorian(year, month, day);
    }
  }

  /// Make a new date object with changed [day]
  ///
  /// Original date object remains unchanged
  ///
  /// This method is NOT safe
  ///
  /// Throws DateException on problems
  ///
  /// Note: For changing at once use copy() methods
  ///
  /// Note: You can chain methods
  @override
  Gregorian withDay(int day) {
    if (day == this.day) {
      return this;
    } else {
      return Gregorian(year, month, day);
    }
  }

  /// equals operator
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Gregorian &&
            runtimeType == other.runtimeType &&
            year == other.year &&
            month == other.month &&
            day == other.day;
  }

  /// hashcode operator
  @override
  int get hashCode {
    return year.hashCode ^ month.hashCode ^ day.hashCode;
  }
}
