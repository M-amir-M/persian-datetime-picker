
  

# 📆 A persian (farsi,shamsi) datetime picker for flutter, inspired by material datetime picker.



[![pub package](https://img.shields.io/pub/v/persian_datetime_picker.svg?color=%23e67e22&label=pub&logo=persian_datetime_picker)](https://pub.dartlang.org/packages/persian_datetime_picker)   [![APK](https://img.shields.io/badge/APK-Demo-brightgreen.svg)](https://github.com/M-amir-M/persian-datetime-picker/raw/master/sample.apk)

![Persian DateTime Picker Banner](https://github.com/M-amir-M/persian-datetime-picker/raw/master/banner.png)

  
  
Persian datetime picker inspired by material datetime picker and based on [shamsi_date](https://pub.dartlang.org/packages/shamsi_date).

The Banner designed by [Nader Mozaffari](https://www.linkedin.com/in/nadermozaffari).

 

## Usage

  

Add it to your pubspec.yaml file:

  

```yaml

dependencies:

persian_datetime_picker: version

```

  

In your library add the following import:

  

```dart

import  'package:persian_datetime_picker/persian_datetime_picker.dart';

```

  

Here is many examples how to use:


```dart
/////////////////////////Example 1////////////////////////////
Jalali picked = await showPersianDatePicker(
    context: context,
    initialDate: Jalali.now(),
    firstDate: Jalali(1385, 8),
    lastDate: Jalali(1450, 9),
);
var label = picked.formatFullDate();
/////////////////////////Example 2////////////////////////////
var picked = await showTimePicker(
  context: context,
  initialTime: TimeOfDay.now(),
);
var label = picked.persianFormat(context);
/////////////////////////Example 3////////////////////////////
  Jalali pickedDate = await showModalBottomSheet<Jalali>(
    context: context,
    builder: (context) {
      Jalali tempPickedDate;
      return Container(
        height: 250,
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    child: Text(
                      'لغو',
                      style: TextStyle(
                        fontFamily: 'Dana',
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  CupertinoButton(
                    child: Text(
                      'تایید',
                      style: TextStyle(
                        fontFamily: 'Dana',
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(tempPickedDate ?? Jalali.now());
                    },
                  ),
                ],
              ),
            ),
            Divider(
              height: 0,
              thickness: 1,
            ),
            Expanded(
              child: Container(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(fontFamily: "Dana"),
                    ),
                  ),
                  child: PCupertinoDatePicker(
                    mode: PCupertinoDatePickerMode.dateAndTime,
                    onDateTimeChanged: (Jalali dateTime) {
                      tempPickedDate = dateTime;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
  
 /////////////////////////Example 4//////////////////////////// 
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


 
##Pull request and feedback are always appreciated.
###Contact me with `mem.amir.m@gmail.com`.
