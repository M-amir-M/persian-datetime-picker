// Copyright 2018 - 2021, Amirreza Madani. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library date;

import 'date_formatter.dart';

/// Super class of Jalali and Georgian classes
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
abstract class Date {
  /// Minimum computable julian day number
  ///
  /// Equivalent to Gregorian(560,3,20) and Jalali(-61,1,1)
  /// and julian day number of 1925675
  static const int minJulianDayNumber = 1925675;

  /// Maximum computable julian day number
  ///
  /// Equivalent to Gregorian(3798,12,31) and Jalali(3177,10,11)
  /// and julian day number of 3108616
  static const int maxJulianDayNumber = 3108616;

  /// Year
  int get year;

  /// Month
  int get month;

  /// Day
  int get day;

  /// Hour
  int get hour;

  /// Minute
  int get minute;

  /// Second
  int get second;

  /// Julian day number
  int get julianDayNumber;

  /// Week day number
  ///
  /// Starting with 1 and ending in 7
  int get weekDay;

  /// Month length
  int get monthLength;

  /// create a formatter for this date object
  ///
  /// Date formatter should be also immutable
  DateFormatter get formatter;

  /// Checks if a year is a leap year or not
  bool isLeapYear();

  /// Converts date to [DateTime] object
  DateTime toDateTime();

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
  Date copy({int? year, int? month, int? day});

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
  Date withYear(int year);

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
  Date withMonth(int month);

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
  Date withDay(int day);

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
  Date add({int years = 0, int months = 0, int days = 0});

  /// Makes a new date object with
  /// added [years] to this date
  ///
  /// Original date object remains unchanged
  ///
  /// This method is safe
  Date addYears(int years);

  /// Makes a new date object with
  /// added [months] to this date
  ///
  /// This method is NOT safe for day being out of month length,
  /// But is safe for month overflow
  ///
  /// Throws DateException on problems
  Date addMonths(int months);

  /// makes a new date object with
  /// added [days] to this date
  ///
  /// Original date object remains unchanged
  ///
  /// this Method is safe
  Date addDays(int days);

  /// Add [days]
  ///
  /// Original date object remains unchanged
  ///
  /// This Method is safe
  ///
  /// Note: This is same as addDays(days)
  Date operator +(int days);

  /// Subtract [days]
  ///
  /// Original date object remains unchanged
  ///
  /// This Method is safe
  ///
  /// Note: This is same as addDays(-days)
  Date operator -(int days);

  /// Subclasses should implement toString
  ///
  /// It should be SUBCLASS_NAME(year, month, day)
  ///
  /// Note: Use formatter for formatting dates for UI
  @override
  String toString();

  /// Subclasses should implement equals operator
  @override
  bool operator ==(Object other);

  /// Subclasses should implement hashcode operator
  @override
  int get hashCode;
}
