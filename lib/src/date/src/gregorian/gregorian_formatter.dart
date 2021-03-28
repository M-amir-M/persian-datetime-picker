// Copyright 2018 - 2021, Amirreza Madani. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library gregorian_formatter;

import '../date_formatter.dart';
import '../gregorian/gregorian_date.dart';

/// Gregorian date formatter class
class GregorianFormatter extends DateFormatter {
  /// make a [GregorianFormatter] from [Gregorian] date
  GregorianFormatter(Gregorian date) : super(date);

  /// Gregorian month names
  static const List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  /// Gregorian week day names
  static const List<String> _weekDayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  /// Gregorian month name
  @override
  String get mN {
    return _monthNames[date.month - 1];
  }

  /// Gregorian week day name
  @override
  String get wN {
    return _weekDayNames[date.weekDay - 1];
  }
}
