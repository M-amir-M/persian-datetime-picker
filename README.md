
# 📆 Persian (Farsi, Shamsi) DateTime Picker for Flutter

A Persian DateTime picker inspired by Material Design's DateTime picker and built upon the [shamsi_date](https://pub.dartlang.org/packages/shamsi_date) library.

[![pub package](https://img.shields.io/pub/v/persian_datetime_picker.svg?color=%23e67e22&label=pub&logo=persian_datetime_picker)](https://pub.dartlang.org/packages/persian_datetime_picker) 
[![APK](https://img.shields.io/badge/APK-Demo-brightgreen.svg)](https://github.com/M-amir-M/persian-datetime-picker/raw/master/sample.apk)

![Persian DateTime Picker Banner](https://github.com/M-amir-M/persian-datetime-picker/raw/master/banner.png)

## Features
- 🌟 Fully supports Persian (Jalali) calendar
- 🛠 Built using the stable and widely used `shamsi_date` library
- 📱 Compatible with Material Design standards
- 🧑‍💻 Simple integration with Flutter

## Getting Started

To use the Persian DateTime Picker, add the package to your `pubspec.yaml`:

```yaml
dependencies:
  persian_datetime_picker: <latest_version>
```

Then, import it in your Dart code:

```dart
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
```

## Usage Examples

### 1. Persian Date Picker

```dart
Jalali picked = await showPersianDatePicker(
  context: context,
  initialDate: Jalali.now(),
  firstDate: Jalali(1385, 8),
  lastDate: Jalali(1450, 9),
);
var label = picked.formatFullDate();
```

### 2. Persian Time Picker

```dart
var picked = await showTimePicker(
  context: context,
  initialTime: TimeOfDay.now(),
);
var label = picked.persianFormat(context);
```

### 3. Modal Bottom Sheet with Persian Date Picker

```dart
Jalali pickedDate = await showModalBottomSheet<Jalali>(
  context: context,
  builder: (context) {
    Jalali tempPickedDate;
    return Container(
      height: 250,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: Text('لغو', style: TextStyle(fontFamily: 'Dana')),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoButton(
                child: Text('تایید', style: TextStyle(fontFamily: 'Dana')),
                onPressed: () => Navigator.of(context).pop(tempPickedDate ?? Jalali.now()),
              ),
            ],
          ),
          Divider(height: 0, thickness: 1),
          Expanded(
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(dateTimePickerTextStyle: TextStyle(fontFamily: "Dana")),
              ),
              child: PCupertinoDatePicker(
                mode: PCupertinoDatePickerMode.dateAndTime,
                onDateTimeChanged: (Jalali dateTime) {
                  tempPickedDate = dateTime;
                },
              ),
            ),
          ),
        ],
      ),
    );
  },
);
```

### 4. Persian Date Range Picker

```dart
var picked = await showPersianDateRangePicker(
  context: context,
  initialEntryMode: PDatePickerEntryMode.input,
  initialDateRange: JalaliRange(
    start: Jalali(1400, 1, 2),
    end: Jalali(1400, 1, 10),
  ),
  firstDate: Jalali(1385, 8),
  lastDate: Jalali(1450, 9),
);
```

## Contributions and Feedback

Pull requests and feedback are always welcome!  
Feel free to reach out at [mem.amir.m@gmail.com](mailto:mem.amir.m@gmail.com) or connect with me on [LinkedIn](https://www.linkedin.com/in/mohammad-amir-mohammadi/).

*Banner designed by [Nader Mozaffari](https://www.linkedin.com/in/nadermozaffari)*
