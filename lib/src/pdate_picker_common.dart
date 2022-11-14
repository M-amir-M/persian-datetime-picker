import 'dart:ui' show hashValues;

import 'package:persian_datetime_picker/src/date/shamsi_date.dart';

/// Mode of the date picker dialog.
///
/// Either a calendar or text input. In [calendar] mode, a calendar view is
/// displayed and the user taps the day they wish to select. In [input] mode a
/// [TextField] is displayed and the user types in the date they wish to select.
///
/// See also:
///
///  * [showDatePicker] and [showDateRangePicker], which use this to control
///    the initial entry mode of their dialogs.
enum PDatePickerEntryMode {
  /// Tapping on a calendar.
  calendar,
  /// only calendar.
  calendarOnly,
  /// Text input.
  input,
  /// Text input only.
  inputOnly,
}

/// Initial display of a calendar date picker.
///
/// Either a grid of available years or a monthly calendar.
///
/// See also:
///
///  * [showDatePicker], which shows a dialog that contains a material design
///    date picker.
///  * [CalendarDatePicker], widget which implements the material design date picker.
enum PDatePickerMode {
  /// Choosing a month and day.
  day,

  /// Choosing a year.
  year,
}

/// Signature for predicating dates for enabled date selections.
///
/// See [showDatePicker], which has a [SelectableDayPredicate] parameter used
/// to specify allowable days in the date picker.
typedef PSelectableDayPredicate = bool Function(Jalali? day);

/// Encapsulates a start and end [Jalali] that represent the range of dates
/// between them.
///
/// See also:
///  * [showDateRangePicker], which displays a dialog that allows the user to
///    select a date range.

class JalaliRange {
  /// Creates a date range for the given start and end [Jalali].
  ///
  /// [start] and [end] must be non-null.
  const JalaliRange({
    required this.start,
    required this.end,
  });

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
  int get hashCode => hashValues(start, end);

  @override
  String toString() => '$start - $end';
}
