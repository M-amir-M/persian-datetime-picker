import 'package:flutter/material.dart';

import 'pdate_utils.dart';

String formatTimeOfDay(TimeOfDay timeOfDay,
    {bool alwaysUse24HourFormat = false}) {
  // Not using intl.DateFormat for two reasons:
  //
  // - DateFormat supports more formats than our material time picker does,
  //   and we want to be consistent across time picker format and the string
  //   formatting of the time of day.
  // - DateFormat operates on DateTime, which is sensitive to time eras and
  //   time zones, while here we want to format hour and minute within one day
  //   no matter what date the day falls on.
  final StringBuffer buffer = StringBuffer();

  // Add hour:minute.
  buffer
    ..write(formatHour(timeOfDay, alwaysUse24HourFormat: alwaysUse24HourFormat))
    ..write(':')
    ..write(formatMinute(timeOfDay));

  if (alwaysUse24HourFormat) {
    // There's no AM/PM indicator in 24-hour format.
    return '$buffer';
  }

  // Add AM/PM indicator.
  buffer..write(' ')..write(_formatDayPeriod(timeOfDay));
  return '$buffer';
}

String formatHour(TimeOfDay timeOfDay, {bool alwaysUse24HourFormat = false}) {
  final TimeOfDayFormat format =
      timeOfDayFormat(alwaysUse24HourFormat: alwaysUse24HourFormat);
  switch (format) {
    case TimeOfDayFormat.h_colon_mm_space_a:
      return formatDecimal(
          timeOfDay.hourOfPeriod == 0 ? 12 : timeOfDay.hourOfPeriod);
    case TimeOfDayFormat.HH_colon_mm:
      return _formatTwoDigitZeroPad(timeOfDay.hour);
    default:
      throw AssertionError(' does not support $format.');
  }
}

/// Formats [number] using two digits, assuming it's in the 0-99 inclusive
/// range. Not designed to format values outside this range.
String _formatTwoDigitZeroPad(int number) {
  assert(0 <= number && number < 100);

  if (number < 10) return '0$number';

  return '$number';
}

@override
String formatMinute(TimeOfDay timeOfDay) {
  final int minute = timeOfDay.minute;
  return minute < 10 ? '0$minute' : minute.toString();
}

TimeOfDayFormat timeOfDayFormat({bool alwaysUse24HourFormat = false}) {
  return alwaysUse24HourFormat
      ? TimeOfDayFormat.HH_colon_mm
      : TimeOfDayFormat.h_colon_mm_space_a;
}

String? _formatDayPeriod(TimeOfDay timeOfDay) {
  switch (timeOfDay.period) {
    case DayPeriod.am:
      return "ق.ظ";
    case DayPeriod.pm:
      return "ب.ظ";
  }
  return null;
}

extension TimeOfDayExt on TimeOfDay {
  String persianFormat(context) {
    return formatTimeOfDay(
      this,
      alwaysUse24HourFormat: MediaQuery.of(context).alwaysUse24HourFormat,
    );
  }
}
