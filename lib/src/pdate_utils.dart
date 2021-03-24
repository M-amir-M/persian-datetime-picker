import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

/// Returns a [Jalali] with just the date of the original, but no time set.
Jalali dateOnly(Jalali date) {
  return Jalali(date.year, date.month, date.day);
}

/// Returns true if the two [Jalali] objects have the same day, month, and
/// year.
bool isSameDay(Jalali dateA, Jalali dateB) {
  return dateA.year == dateB.year &&
      dateA.month == dateB.month &&
      dateA.day == dateB.day;
}

/// Determines the number of months between two [Jalali] objects.
///
/// For example:
/// ```
/// Jalali date1 = Jalali(year: 2019, month: 6, day: 15);
/// Jalali date2 = Jalali(year: 2020, month: 1, day: 15);
/// int delta = monthDelta(date1, date2);
/// ```
///
/// The value for `delta` would be `7`.
int monthDelta(Jalali startDate, Jalali endDate) {
  return (endDate.year - startDate.year) * 12 + endDate.month - startDate.month;
}

/// Returns a [Jalali] with the added number of months and truncates any day
/// and time information.
///
/// For example:
/// ```
/// Jalali date = Jalali(year: 2019, month: 1, day: 15);
/// Jalali futureDate = _addMonthsToMonthDate(date, 3);
/// ```
///
/// `date` would be January 15, 2019.
/// `futureDate` would be April 1, 2019 since it adds 3 months and truncates
/// any additional date information.
Jalali addMonthsToMonthDate(Jalali monthDate, int monthsToAdd) {
  return Jalali(monthDate.year, monthDate.month).addMonths(monthsToAdd);
}

/// Computes the offset from the first day of the week that the first day of
/// the [month] falls on.
///
/// For example, September 1, 2017 falls on a Friday, which in the calendar
/// localized for United States English appears as:
///
/// ```
/// S M T W T F S
/// _ _ _ _ _ 1 2
/// ```
///
/// The offset for the first day of the months is the number of leading blanks
/// in the calendar, i.e. 5.
///
/// The same date localized for the Russian calendar has a different offset,
/// because the first day of week is Monday rather than Sunday:
///
/// ```
/// M T W T F S S
/// _ _ _ _ 1 2 3
/// ```
///
/// So the offset is 4, rather than 5.
///
/// This code consolidates the following:
///
/// - [Jalali.weekDay] provides a 1-based index into days of week, with 1
///   falling on Monday.
/// - [MaterialLocalizations.firstDayOfWeekIndex] provides a 0-based index
///   into the [MaterialLocalizations.narrowWeekdays] list.
/// - [MaterialLocalizations.narrowWeekdays] list provides localized names of
///   days of week, always starting with Sunday and ending with Saturday.
int firstDayOffset(int year, int month, MaterialLocalizations localizations) {
  final int weekdayFromShanbe = Jalali(year, month).weekDay - 1;
  return (weekdayFromShanbe - 0) % 7;
}

int getDaysInMonth(int year, int month) {
  if (month == 12) {
    final bool isLeapYear = Jalali(year).isLeapYear();
    if (isLeapYear) return 30;
    return 29;
  }
  const List<int> daysInMonth = <int>[
    31,
    31,
    31,
    31,
    31,
    31,
    30,
    30,
    30,
    30,
    30,
    -1
  ];
  return daysInMonth[month - 1];
}

List<String> narrowWeekdays = [
  "ش",
  "ی",
  "د",
  "س",
  "چ",
  "پ",
  "ج",
];

List<String> shortDayName = [
  "شنبه",
  "۱شنبه",
  "۲شنبه",
  "۳شنبه",
  "۴شنبه",
  "۵شنبه",
  "جمعه",
];

String formatDecimal(int number) {
  if (number > -1000 && number < 1000) return number.toString();

  final String digits = number.abs().toString();
  final StringBuffer result = StringBuffer(number < 0 ? '-' : '');
  final int maxDigitIndex = digits.length - 1;
  for (int i = 0; i <= maxDigitIndex; i += 1) {
    result.write(digits[i]);
    if (i < maxDigitIndex && (maxDigitIndex - i) % 3 == 0) result.write(',');
  }
  return result.toString();
}

String formatYear(Jalali date) {
  return '${date.formatter.yy}';
}

String formatMonthYear(Jalali date) {
  return '${date.formatter.mm} ${date.formatter.yy}';
}

String formatFullDate(Jalali date) {
  return '${date.formatter.wN}, ${date.formatter.m} ${date.day}, ${date.year}';
}

String formatMediumDate(Jalali date) {
  return '${date.formatter.wN}, ${date.formatter.m} ${date.day}';
}

Jalali parseCompactDate(String inputString) {
  List<int> split = inputString.split("/").map((e) => int.parse(e)).toList();
  return Jalali(split[0], split[1], split[2]);
}

class JalaliDate {
  // Weekday constants that are returned by [weekday] method:
  static const int monday = 3;
  static const int tuesday = 4;
  static const int wednesday = 5;
  static const int thursday = 6;
  static const int friday = 7;
  static const int saturday = 1;
  static const int sunday = 2;
  static const int daysPerWeek = 7;

  // Month constants that are returned by the [month] getter.
  static const int farvardin = 1;
  static const int ordibehesht = 2;
  static const int khordad = 3;
  static const int tir = 4;
  static const int mordad = 5;
  static const int shahrivar = 6;
  static const int mehr = 7;
  static const int aban = 8;
  static const int azar = 9;
  static const int dey = 10;
  static const int bahman = 11;
  static const int esfand = 12;
  static const int monthsPerYear = 12;
}

extension JalaliExt on Jalali {
  bool isBefore(Jalali date) {
    return date.compareTo(this) > 0;
  }

  bool isAfter(Jalali date) {
    return date.compareTo(this) < 0;
  }

  bool isAtSameMomentAs(Jalali other) {
    return other.compareTo(this) == 0;
  }

  DateTime toDateTime() {
    return this.toDateTime();
  }

  ///formats

  String formatMediumDate() {
    final f = this.formatter;
    return '${shortDayName[this.weekDay - 1]} ${f.d} ${f.mN}';
  }

  String formatFullDate() {
    final f = this.formatter;
    return '${f.wN} ${f.d} ${f.mN} ${f.yyyy}';
  }

  String formatYear() {
    final f = this.formatter;
    return '${f.yyyy}';
  }

  String formatCompactDate() {
    final f = this.formatter;
    return '${f.yyyy}/${f.mm}/${f.dd}';
  }

  String formatShortDate() {
    final f = this.formatter;
    return '${f.dd} ${f.mN}  ,${f.yyyy}';
  }

  String formatMonthYear() {
    final f = this.formatter;
    return '${f.yyyy}/${f.mm}';
  }

  String formatShortMonthDay() {
    final f = this.formatter;
    return '${f.dd} ${f.mN}';
  }
}

extension DateTimeExt on DateTime {
  Jalali toJalali() {
    return this.toJalali();
  }
}
