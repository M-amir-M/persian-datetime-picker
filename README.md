
  
# 📆 Persian (Farsi, Shamsi, Jalali) Date && Time Picker for Flutter

[![pub package](https://img.shields.io/pub/v/persian_datetime_picker.svg?color=%23e67e22&label=pub&logo=persian_datetime_picker)](https://pub.dartlang.org/packages/persian_datetime_picker) 
[![APK](https://img.shields.io/badge/APK-Demo-brightgreen.svg)](https://github.com/M-amir-M/persian-datetime-picker/raw/master/sample.apk)

![Persian DateTime Picker Banner](https://github.com/M-amir-M/persian-datetime-picker/raw/master/assets/banner.png)

## <img src="assets/Telescope.webp" width="36px"> Overview
A Persian Date & Time picker inspired by Material Design's DateTime picker, built on the [shamsi_date](https://pub.dartlang.org/packages/shamsi_date) library. It offers full support for the Persian (Jalali) calendar and is highly customizable, including compatibility with Material 3. 

Additionally, it supports multiple languages, including Persian, Dari, Kurdish, Pashto, and custom locales, all while ensuring seamless integration with Flutter and maintaining Material Design standards.


## <img src="assets/Rocket.png" width="36px">️ Features
- 🌟 Fully supports Persian (Jalali) calendar
- 🛠 High customizable 
- support material 3
- 🛠 Support, Persian, Dari, Kurd, Pashto and custom locale and multi-language
- 📱 Compatible with Material Design standards
- 🧑‍💻 Simple integration with Flutter

## <img src="assets/Fire.png" width="36px">️ Getting Started

To use the Persian DateTime Picker, add the package to your `pubspec.yaml`:

```yaml
dependencies:
  persian_datetime_picker: <latest_version>
```

Then, import it in your Dart code:

```dart
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
```

Add localization to materialApp:

```dart
    return MaterialApp(
      title: 'Date and Time Pickers',
      locale: const Locale("fa", "IR"),
      supportedLocales: const [
        Locale("fa", "IR"),
        Locale("en", "US"),
      ],
      localizationsDelegates: const [
	    //Add your localization delegate
        PersianMaterialLocalizations.delegate,
        PersianCupertinoLocalizations.delegate,
        //
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      ...
    );
```

## <img src="assets/Comet.png" width="36px">️ Usage Examples

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

## <img src="assets/Star.png" width="36px">️ Support Us
Feel free to check it out and give it a  <img src="assets/Star.png" width="24px">️ if you love it. 
Follow me for more updates and more projects


## <img src="assets/Folded Hands Medium Skin Tone.png" width="36px">️  Contributions and Feedback


Pull requests and feedback are always welcome!  
Feel free to reach out at [mem.amir.m@gmail.com](mailto:mem.amir.m@gmail.com) or connect with me on [LinkedIn](https://www.linkedin.com/in/mohammad-amir-mohammadi/).

*Banner designed by [Nader Mozaffari](https://www.linkedin.com/in/nadermozaffari)*


### <img src="assets/Eyes.png" width="36px">️  Project License:
This project is licensed under [MIT License](LICENSE).
