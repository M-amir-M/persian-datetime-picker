import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../material/date.dart';

class DefaultPersianMaterialLocalizations extends DefaultMaterialLocalizations {
  const DefaultPersianMaterialLocalizations();

  static const LocalizationsDelegate<MaterialLocalizations> delegate =
      _PersianMaterialLocalizationsDelegate();

  static const List<String> _shortWeekdays = <String>[
    'Sat',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
  ];

  static const List<String> _shortMonths = <String>[
    'Far', // Farvardin
    'Ord', // Ordibehesht
    'Kho', // Khordad
    'Tir', // Tir
    'Mor', // Mordad
    'Sha', // Shahrivar
    'Meh', // Mehr
    'Aba', // Aban
    'Aza', // Azar
    'Dey', // Dey
    'Bah', // Bahman
    'Esf', // Esfand
  ];

  static const List<String> _months = <String>[
    'Farvardin', // Farvardin
    'Ordibehesht', // Ordibehesht
    'Khordad', // Khordad
    'Tir', // Tir
    'Mordad', // Mordad
    'Shahrivar', // Shahrivar
    'Mehr', // Mehr
    'Aban', // Aban
    'Azar', // Azar
    'Dey', // Dey
    'Bahman', // Bahman
    'Esfand', // Esfand
  ];

  @override
  List<String> get narrowWeekdays => _shortWeekdays;

  @override
  String formatYear(DateTime date) {
    return Jalali.fromDateTime(date).year.toString(); // Use Jalali year
  }

  @override
  String formatMediumDate(DateTime date) {
    final jalaliDate = Jalali.fromDateTime(date);
    return '${jalaliDate.day} ${_months[jalaliDate.month - 1]} ${jalaliDate.year}'; // Format medium date
  }

  @override
  String formatShortMonthDay(DateTime date) {
    final jalaliDate = Jalali.fromDateTime(date);
    return '${jalaliDate.day} ${_shortMonths[jalaliDate.month - 1]}'; // Format short month day
  }

  @override
  String formatMonthYear(DateTime date) {
    final jalaliDate = Jalali.fromDateTime(date);
    return '${_months[jalaliDate.month - 1]} ${jalaliDate.year}'; // Format month year
  }

  @override
  String formatFullDate(DateTime date) {
    final jalaliDate = Jalali.fromDateTime(date);
    return '${jalaliDate.day} ${_months[jalaliDate.month - 1]} ${jalaliDate.year}'; // Format full date
  }

  @override
  String formatCompactDate(DateTime date) {
    final jalaliDate = Jalali.fromDateTime(date);
    return '${jalaliDate.day}/${jalaliDate.month}/${jalaliDate.year}'; // Format compact date
  }
}

class _PersianMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _PersianMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return SynchronousFuture<MaterialLocalizations>(
      const DefaultPersianMaterialLocalizations(),
    );
  }

  @override
  bool shouldReload(_PersianMaterialLocalizationsDelegate old) => false;
}

class DefaultPersianCupertinoLocalizations
    extends DefaultCupertinoLocalizations {
  const DefaultPersianCupertinoLocalizations();

  static const LocalizationsDelegate<CupertinoLocalizations> delegate =
      _PersianCupertinoLocalizationsDelegate();

  static const List<String> shortWeekdays = <String>[
    'Sa',
    'Su',
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
  ];

  static const List<String> _shortMonths = <String>[
    'Far', // Farvardin
    'Ord', // Ordibehesht
    'Kho', // Khordad
    'Tir', // Tir
    'Mor', // Mordad
    'Sha', // Shahrivar
    'Meh', // Mehr
    'Aba', // Aban
    'Aza', // Azar
    'Dey', // Dey
    'Bah', // Bahman
    'Esf', // Esfand
  ];

  static const List<String> _months = <String>[
    'Farvardin', // Farvardin
    'Ordibehesht', // Ordibehesht
    'Khordad', // Khordad
    'Tir', // Tir
    'Mordad', // Mordad
    'Shahrivar', // Shahrivar
    'Mehr', // Mehr
    'Aban', // Aban
    'Azar', // Azar
    'Dey', // Dey
    'Bahman', // Bahman
    'Esfand', // Esfand
  ];

  @override
  String datePickerYear(int yearIndex) => yearIndex.toString();

  @override
  String datePickerMonth(int monthIndex) => _months[monthIndex - 1];

  @override
  String datePickerStandaloneMonth(int monthIndex) => _months[monthIndex - 1];

  @override
  String datePickerDayOfMonth(int dayIndex, [int? weekDay]) {
    if (weekDay != null) {
      return ' ${shortWeekdays[weekDay - JalaliExt.saturday]} $dayIndex ';
    }

    return dayIndex.toString();
  }

  @override
  String datePickerMediumDate(DateTime date) {
    Jalali jdate = Jalali.fromDateTime(date);
    return '${shortWeekdays[jdate.weekDay - JalaliExt.saturday]} '
        '${jdate.day.toString().padRight(2)}'
        '${_shortMonths[jdate.month - JalaliExt.farvardin]} ';
  }

  @override
  DatePickerDateOrder get datePickerDateOrder => DatePickerDateOrder.mdy;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder =>
      DatePickerDateTimeOrder.date_time_dayPeriod;

  @override
  String timerPickerHour(int hour) => hour.toString();

  @override
  String timerPickerMinute(int minute) => minute.toString();

  @override
  String timerPickerSecond(int second) => second.toString();
}

class _PersianCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _PersianCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    return SynchronousFuture<CupertinoLocalizations>(
      const DefaultPersianCupertinoLocalizations(),
    );
  }

  @override
  bool shouldReload(_PersianCupertinoLocalizationsDelegate old) => false;
}
