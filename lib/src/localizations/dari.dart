import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../material/date.dart';

class DariMaterialLocalizations extends DefaultMaterialLocalizations {
  const DariMaterialLocalizations();

  static const LocalizationsDelegate<MaterialLocalizations> delegate =
      _DariMaterialLocalizationsDelegate();

  static const List<String> _narrowWeekdays = <String>[
    'ش', // S (شنبه)
    'ی', // S (یکشنبه)
    'د', // M (دوشنبه)
    'س', // T (سه‌شنبه)
    'چ', // W (چهارشنبه)
    'پ', // T (پنج‌شنبه)
    'ج', // F (جمعه)
  ];
  static const List<String> _shortMonths = <String>[
    'حم', // Hamal
    'ثو', // Sowr
    'جوز', // Jawza
    'سر', // Saratan
    'اسد', // Asad
    'سنب', // Sonbola
    'میز', // Mizan
    'عق', // Aqrab
    'قوس', // Qaws
    'جد', // Jadi
    'دلو', // Dalw
    'حوت', // Hoot
  ];

  static const List<String> _months = <String>[
    'حمل', // Hamal
    'ثور', // Sowr
    'جوزا', // Jawza
    'سرطان', // Saratan
    'اسد', // Asad
    'سنبله', // Sonbola
    'میزان', // Mizan
    'عقرب', // Aqrab
    'قوس', // Qaws
    'جدی', // Jadi
    'دلو', // Dalw
    'حوت', // Hoot
  ];

  @override
  List<String> get narrowWeekdays => _narrowWeekdays;

  @override
  String get okButtonLabel => 'تایید'; // Confirm

  @override
  String get cancelButtonLabel => 'لغو'; // Cancel

  @override
  String get datePickerHelpText => 'انتخاب تاریخ'; // Select Date

  @override
  String get nextMonthTooltip => "ماه بعد"; // Next Month

  @override
  String get previousMonthTooltip => "ماه قبل"; // Previous Month

  @override
  int get firstDayOfWeekIndex =>
      6; // Saturday as the first day of the week in Afghanistan

  @override
  String get saveButtonLabel => "ذخیره"; // Save

  @override
  String get dateRangePickerHelpText =>
      "انتخاب بازهٔ زمانی"; // Select Date Range

  @override
  String get dateRangeStartLabel => "تاریخ شروع"; // Start Date

  @override
  String get dateRangeEndLabel => "تاریخ پایان"; // End Date

  @override
  String get closeButtonTooltip => "بستن"; // Close

  @override
  String get inputDateModeButtonLabel => "ورودی تاریخ"; // Switch to Input Mode

  @override
  String get calendarModeButtonLabel => "تقویم"; // Switch to Calendar Mode

  @override
  String get dateInputLabel => "تاریخ"; // Date

  @override
  String get timePickerDialHelpText => "انتخاب زمان"; // Select Time

  @override
  String get anteMeridiemAbbreviation => "ق.ظ"; // AM

  @override
  String get postMeridiemAbbreviation => "ب.ظ"; // PM

  @override
  String get timePickerInputHelpText => "زمان"; // Time

  @override
  String get timePickerHourLabel => "ساعت"; // Hour

  @override
  String get timePickerMinuteLabel => "دقیقه"; // Minute

  @override
  String get inputTimeModeButtonLabel =>
      "ورودی زمان"; // Switch to Input Time Mode

  @override
  String get dialModeButtonLabel => "حالت انتخابگر دیال"; // Switch to Dial Mode

  @override
  String get invalidDateFormatLabel => "قالب نادرست."; // Invalid Format

  @override
  String get invalidDateRangeLabel =>
      "قالب بازه نادرست."; // Invalid Range Format

  @override
  String get invalidTimeLabel => "قالب زمان نادرست."; // Invalid Time Format

  @override
  String get unspecifiedDate => "تاریخ نامشخص"; // Unspecified Date

  @override
  String get unspecifiedDateRange =>
      "بازهٔ زمانی نامشخص"; // Unspecified Date Range

  @override
  String formatYear(DateTime date) {
    return Jalali.fromDateTime(date).year.toString(); // Jalali year
  }

  @override
  String formatMediumDate(DateTime date) {
    final jalaliDate = Jalali.fromDateTime(date);
    return '${jalaliDate.day} ${_months[jalaliDate.month - 1]} ${jalaliDate.year}'; // Medium date format
  }

  @override
  String formatShortMonthDay(DateTime date) {
    final jalaliDate = Jalali.fromDateTime(date);
    return '${jalaliDate.day} ${_shortMonths[jalaliDate.month - 1]}'; // Short month day format
  }

  @override
  String formatMonthYear(DateTime date) {
    final jalaliDate = Jalali.fromDateTime(date);
    return '${_months[jalaliDate.month - 1]} ${jalaliDate.year}'; // Month-year format
  }

  @override
  String formatFullDate(DateTime date) {
    final jalaliDate = Jalali.fromDateTime(date);
    return '${jalaliDate.day} ${_months[jalaliDate.month - 1]} ${jalaliDate.year}'; // Full date format
  }

  @override
  String formatCompactDate(DateTime date) {
    final jalaliDate = Jalali.fromDateTime(date);
    return '${jalaliDate.day}/${jalaliDate.month}/${jalaliDate.year}'; // Compact date format
  }
}

class _DariMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _DariMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode == 'fa' && locale.countryCode == 'AF';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return SynchronousFuture<MaterialLocalizations>(
        const DariMaterialLocalizations());
  }

  @override
  bool shouldReload(_DariMaterialLocalizationsDelegate old) => false;
}

class DariCupertinoLocalizations extends DefaultCupertinoLocalizations {
  const DariCupertinoLocalizations();

  static const LocalizationsDelegate<CupertinoLocalizations> delegate =
      _DariCupertinoLocalizationsDelegate();

  static const List<String> _shortWeekdays = <String>[
    'ش', // Saturday
    'ی', // Sunday
    'د', // Monday
    'س', // Tuesday
    'چ', // Wednesday
    'پ', // Thursday
    'ج', // Friday
  ];

  static const List<String> _months = <String>[
    'حمل', // Hamal
    'ثور', // Sawr
    'جوزا', // Jawza
    'سرطان', // Saratan
    'اسد', // Asad
    'سنبله', // Sunbula
    'میزان', // Meezan
    'عقرب', // Aqrab
    'قوس', // Qaws
    'جدی', // Jadi
    'دلو', // Dalwa
    'حوت', // Hoot
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
      return ' ${_shortWeekdays[weekDay - JalaliExt.saturday]} $dayIndex ';
    }
    return dayIndex.toString();
  }

  @override
  String datePickerHour(int hour) => hour.toString();

  @override
  String datePickerMinute(int minute) => minute.toString().padLeft(2, '0');

  @override
  String get anteMeridiemAbbreviation => 'ق.ظ';

  @override
  String get postMeridiemAbbreviation => 'ب.ظ';

  @override
  String get todayLabel => 'امروز';

  @override
  String get alertDialogLabel => 'هشدار';
}

class _DariCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _DariCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'fa' && locale.countryCode == 'AF';

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    return SynchronousFuture<CupertinoLocalizations>(
        const DariCupertinoLocalizations());
  }

  @override
  bool shouldReload(_DariCupertinoLocalizationsDelegate old) => false;
}
