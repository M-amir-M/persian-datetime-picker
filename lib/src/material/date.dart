// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

/// Utility functions for working with dates.
abstract final class PersianDateUtils {
  /// Returns a [Jalali] with the date of the original, but time set to
  /// midnight.
  static Jalali dateOnly(Jalali date) {
    return Jalali(date.year, date.month, date.day);
  }

  /// Returns a [JalaliRange] with the dates of the original, but with times
  /// set to midnight.
  ///
  /// See also:
  ///  * [dateOnly], which does the same thing for a single date.
  static JalaliRange datesOnly(JalaliRange range) {
    return JalaliRange(start: dateOnly(range.start), end: dateOnly(range.end));
  }

  /// Returns true if the two [Jalali] objects have the same day, month, and
  /// year, or are both null.
  static bool isSameDay(Jalali? dateA, Jalali? dateB) {
    return dateA?.year == dateB?.year &&
        dateA?.month == dateB?.month &&
        dateA?.day == dateB?.day;
  }

  /// Returns true if the two [Jalali] objects have the same month and
  /// year, or are both null.
  static bool isSameMonth(Jalali? dateA, Jalali? dateB) {
    return dateA?.year == dateB?.year && dateA?.month == dateB?.month;
  }

  /// Determines the number of months between two [Jalali] objects.
  ///
  /// For example:
  ///
  /// ```dart
  /// Jalali date1 = Jalali(2019, 6, 15);
  /// Jalali date2 = Jalali(2020, 1, 15);
  /// int delta = DateUtils.monthDelta(date1, date2);
  /// ```
  ///
  /// The value for `delta` would be `7`.
  static int monthDelta(Jalali startDate, Jalali endDate) {
    return (endDate.year - startDate.year) * 12 +
        endDate.month -
        startDate.month;
  }

  /// Returns a [Jalali] that is [monthDate] with the added number
  /// of months and the day set to 1 and time set to midnight.
  ///
  /// For example:
  ///
  /// ```dart
  /// Jalali date = Jalali(2019, 1, 15);
  /// Jalali futureDate = DateUtils.addMonthsToMonthDate(date, 3);
  /// ```
  ///
  /// `date` would be January 15, 2019.
  /// `futureDate` would be April 1, 2019 since it adds 3 months.
  static Jalali addMonthsToMonthDate(Jalali monthDate, int monthsToAdd) {
    return Jalali(monthDate.year, monthDate.month).addMonths(monthsToAdd);
  }

  /// Returns a [Jalali] with the added number of days and time set to
  /// midnight.
  static Jalali addDaysToDate(Jalali date, int days) {
    return Jalali(date.year, date.month, date.day).addDays(days);
  }

  /// Computes the offset from the first day of the week that the first day of
  /// the [month] falls on.
  ///
  /// For example, September 1, 2017 falls on a Friday, which in the calendar
  /// localized for United States English appears as:
  ///
  ///     S M T W T F S
  ///     _ _ _ _ _ 1 2
  ///
  /// The offset for the first day of the months is the number of leading blanks
  /// in the calendar, i.e. 5.
  ///
  /// The same date localized for the Russian calendar has a different offset,
  /// because the first day of week is Monday rather than Sunday:
  ///
  ///     M T W T F S S
  ///     _ _ _ _ 1 2 3
  ///
  /// So the offset is 4, rather than 5.
  ///
  /// This code consolidates the following:
  ///
  /// - [DateTime.weekday] provides a 1-based index into days of week, with 1
  ///   falling on Monday.
  /// - [MaterialLocalizations.firstDayOfWeekIndex] provides a 0-based index
  ///   into the [MaterialLocalizations.narrowWeekdays] list.
  /// - [MaterialLocalizations.narrowWeekdays] list provides localized names of
  ///   days of week, always starting with Sunday and ending with Saturday.
  static int firstDayOffset(
    int year,
    int month,
    MaterialLocalizations localizations,
  ) {
    // 0-based day of week for the month and year, with 0 representing Saturday.
    final int weekdayFromSaturday =
        (Jalali(year, month, 1).weekDay % 7); // Saturday is 0

    // 0-based start of week depending on the locale, with 0 representing Sunday.
    int firstDayOfWeekIndex = localizations.firstDayOfWeekIndex;

    // Adjust firstDayOfWeekIndex to be Saturday-based for comparison.
    firstDayOfWeekIndex =
        (firstDayOfWeekIndex - 6) % 7; // Saturday as 0, adjust accordingly

    // Compute the offset between the localized first day of the week and the first day of the month.
    return (weekdayFromSaturday - firstDayOfWeekIndex) % 7;
  }

  /// Returns the number of days in a month, according to the proleptic
  /// Jalali calendar.
  static int getDaysInMonth(int year, int month) {
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
      -1,
    ];
    return daysInMonth[month - 1];
  }
}

/// Mode of date entry method for the date picker dialog.
///
/// In [calendar] mode, a calendar grid is displayed and the user taps the
/// day they wish to select. In [input] mode, a [TextField] is displayed and
/// the user types in the date they wish to select.
///
/// [calendarOnly] and [inputOnly] are variants of the above that don't
/// allow the user to change to the mode.
///
/// See also:
///
///  * [showDatePicker] and [showDateRangePicker], which use this to control
///    the initial entry mode of their dialogs.
enum PersianDatePickerEntryMode {
  /// User picks a date from calendar grid. Can switch to [input] by activating
  /// a mode button in the dialog.
  calendar,

  /// User can input the date by typing it into a text field.
  ///
  /// Can switch to [calendar] by activating a mode button in the dialog.
  input,

  /// User can only pick a date from calendar grid.
  ///
  /// There is no user interface to switch to another mode.
  calendarOnly,

  /// User can only input the date by typing it into a text field.
  ///
  /// There is no user interface to switch to another mode.
  inputOnly,
}

/// Initial display of a calendar date picker.
///
/// Either a grid of available years or a monthly calendar.
///
/// See also:
///
///  * [showDatePicker], which shows a dialog that contains a Material Design
///    date picker.
///  * [CalendarDatePicker], widget which implements the Material Design date picker.
enum PersianDatePickerMode {
  /// Choosing a month and day.
  day,

  /// Choosing a year.
  year,
}

/// Signature for predicating dates for enabled date selections.
///
/// See [showDatePicker], which has a [PersianSelectableDayPredicate] parameter used
/// to specify allowable days in the date picker.
typedef PersianSelectableDayPredicate = bool Function(Jalali day);

/// Encapsulates a start and end [Jalali] that represent the range of dates.
///
/// The range includes the [start] and [end] dates. The [start] and [end] dates
/// may be equal to indicate a date range of a single day. The [start] date must
/// not be after the [end] date.
///
/// See also:
///  * [showDateRangePicker], which displays a dialog that allows the user to
///    select a date range.
@immutable
class JalaliRange {
  /// Creates a date range for the given start and end [Jalali].
  ///
  /// [start] and [end] must be non-null.
  const JalaliRange({required this.start, required this.end});

  /// The start of the range of dates.
  final Jalali start;

  /// The end of the range of dates.
  final Jalali end;

  /// Returns a [Duration] of the time between [start] and [end].
  ///
  /// See [Jalali.difference] for more details.
  Duration get duration => end.toDateTime().difference(start.toDateTime());

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is JalaliRange && other.start == start && other.end == end;
  }

  @override
  int get hashCode => Object.hash(start, end);

  @override
  String toString() => '$start - $end';
}

extension JalaliExt on Jalali {
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

  static const List<String> months = <String>[
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];

  static List<String> narrowWeekdays = ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'];

  static List<String> shortDayName = [
    'شنبه',
    '۱شنبه',
    '۲شنبه',
    '۳شنبه',
    '۴شنبه',
    '۵شنبه',
    'جمعه',
  ];

  /// Convert Jalali to milliseconds since epoch
  int get millisecondsSinceEpoch {
    // Convert Jalali to DateTime
    DateTime dateTime = toDateTime();

    // Return the milliseconds since epoch
    return dateTime.millisecondsSinceEpoch;
  }

  bool isBefore(Jalali date) {
    return date.compareTo(this) > 0;
  }

  bool isAfter(Jalali date) {
    return date.compareTo(this) < 0;
  }

  bool isAtSameMomentAs(Jalali other) {
    return other.compareTo(this) == 0;
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  ///formats
  String datePickerMediumDate() {
    return '${shortDayName[weekDay - saturday]} '
        '${formatter.mN} '
        '${day.toString().padRight(2)}';
  }

  String formatMediumDate() {
    final f = formatter;
    return '${shortDayName[weekDay - 1]} ${f.d} ${f.mN}';
  }

  String formatFullDate() {
    final f = formatter;
    return '${f.wN} ${f.d} ${f.mN} ${f.yyyy}';
  }

  String toJalaliDateTime() {
    final f = formatter;
    return '${f.yyyy}-${f.mm}-${f.dd} ${_twoDigits(hour)}:${_twoDigits(minute)}:${_twoDigits(second)}';
  }

  String formatYear() {
    final f = formatter;
    return f.yyyy;
  }

  String formatCompactDate() {
    // Assumes IR yyyy/mm/dd format
    final f = formatter;
    final String month = f.mm;
    final String day = f.dd;
    final String year = f.yyyy;
    return '$year/$month/$day';
  }

  String formatShortDate() {
    final f = formatter;
    return '${f.dd} ${f.mN}  ,${f.yyyy}';
  }

  String formatMonthYear() {
    final f = formatter;
    return '${f.yyyy}/${f.mm}';
  }

  String formatShortMonthDay() {
    final f = formatter;
    return '${f.dd} ${f.mN}';
  }

  /// copyWith method to allow partial updates to a Jalali instance
  Jalali copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
  }) {
    return Jalali(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
    );
  }

  /// Adds the specified number of hours to the current Jalali date.
  Jalali addHours(int hours) {
    // Calculate the new hour and the number of days to add if the hour overflows
    int newHour = (hour + hours) % 24;
    int dayOverflow = (hour + hours) ~/ 24;

    // Create a new Jalali date with the updated hour and adjusted day
    Jalali newDateTime = copyWith(hour: newHour);

    return dayOverflow > 0 ? newDateTime.addDays(dayOverflow) : newDateTime;
  }
}

Jalali? parseCompactJalaliDate(String? inputString) {
  if (inputString == null) {
    return null;
  }

  // Assumes US mm/dd/yyyy format
  final List<String> inputParts = inputString.split('/');
  if (inputParts.length != 3) {
    return null;
  }

  final int? year = int.tryParse(inputParts[0], radix: 10);
  if (year == null || year < 1) {
    return null;
  }

  final int? month = int.tryParse(inputParts[1], radix: 10);
  if (month == null || month < 1 || month > 12) {
    return null;
  }

  final int? day = int.tryParse(inputParts[2], radix: 10);
  if (day == null ||
      day < 1 ||
      day > PersianDateUtils.getDaysInMonth(year, month)) {
    return null;
  }

  try {
    return Jalali(year, month, day);
  } on ArgumentError {
    return null;
  }
}

String? jalaliStringToGregorianString(
  String? jalaliDateString,
  String seprator,
) {
  if (jalaliDateString == null || jalaliDateString.isEmpty) {
    return null; // Return null if the input is null or empty
  }

  try {
    // Assuming the input format is "yyyy/mm/dd"
    final List<String> parts = jalaliDateString.split(seprator);
    if (parts.length != 3) {
      throw FormatException("Invalid Jalali date format");
    }

    final int year = int.parse(parts[0]);
    final int month = int.parse(parts[1]);
    final int day = int.parse(parts[2]);

    // Create a Jalali instance
    Jalali jalaliDate = Jalali(year, month, day);

    // Convert Jalali date to DateTime
    DateTime dateTime = jalaliDate.toDateTime();

    // Format DateTime as a string, e.g., "yyyy-mm-dd"
    return '${dateTime.year.toString().padLeft(4, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')}';
  } catch (e) {
    // TODO: Use a data structure similar to Rust's "Result" to directly
    // return errors to the caller instead.
    // ignore: avoid_print
    print("Error converting Jalali date: $e");
    return null; // Return null in case of error
  }
}

extension DateTimeExt on DateTime {
  Jalali toJalali() {
    return Jalali.fromDateTime(this);
  }
}
