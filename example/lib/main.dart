// import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

final ThemeData androidTheme = new ThemeData(
  fontFamily: 'IranYekan',
);

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: androidTheme,
      home: new MyHomePage(title: 'دیت تایم پیکر فارسی'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String label;

  String selectedDate = Jalali.now().formatFullDate();

  @override
  void initState() {
    super.initState();
    label = 'انتخاب تاریخ زمان';
  }

  @override
  Widget build(BuildContext context) {
    return new Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: new AppBar(
          title: new Text(
            widget.title,
            style: TextStyle(fontFamily: 'IS'),
          ),
        ),
        body: new Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  Jalali picked = await showPersianDatePicker(
                    context: context,
                    initialDate: Jalali.now(),
                    firstDate: Jalali(1385, 8),
                    lastDate: Jalali(1450, 9),
                  );
                  if (picked != null && picked != selectedDate)
                    setState(() {
                      label = picked.formatFullDate();
                    });
                },
                child: Text('تاریخ '),
              ),
              RaisedButton(
                onPressed: () async {
                  final DateTime picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now().add(Duration(days: -10000)),
                    lastDate: DateTime.now().add(Duration(days: 10000)),
                    initialDate: DateTime.now(),
                  );
                  if (picked != null && picked != selectedDate)
                    setState(() {
                      label = picked.toIso8601String();
                    });
                },
                child: Text('Date '),
              ),
              RaisedButton(
                onPressed: () async {
                  var picked = await showPersianTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (BuildContext context, Widget child) {
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: child,
                      );
                    },
                  );
                  setState(() {
                    label = picked.persianFormat(context);
                  });
                },
                child: Text('زمان '),
              ),
              RaisedButton(
                onPressed: () async {
                  var picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  setState(() {
                    label = picked.format(context);
                  });
                },
                child: Text('Time'),
              ),
              RaisedButton(
                onPressed: () async {
                  var picked = await showPersianDateRangePicker(
                    context: context,
                    initialDateRange: JalaliRange(
                      start: Jalali(1400, 1, 2),
                      end: Jalali(1400, 1, 10),
                    ),
                    firstDate: Jalali(1385, 8),
                    lastDate: Jalali(1450, 9),
                  );
                  setState(() {
                    label = "${picked.start} ${picked.end}";
                  });
                },
                child: Text('محدوده تاریخ'),
              ),
              RaisedButton(
                onPressed: () async {
                  var picked = await showDateRangePicker(
                    context: context,
                    initialDateRange: DateTimeRange(
                      start: DateTime.now(),
                      end: DateTime.now().add(
                        Duration(days: 5),
                      ),
                    ),
                    firstDate: DateTime.now().add(Duration(days: -10000)),
                    lastDate: DateTime.now().add(Duration(days: 10000)),
                  );
                  setState(() {
                    // label = picked.format(context);
                  });
                },
                child: Text('Range Datetime'),
              ),
              RaisedButton(
                onPressed: () async {
                  _selectPDate();
                },
                child: Text('تاریخ ios'),
              ),
              RaisedButton(
                onPressed: () async {
                  _selectDate();
                },
                child: Text('Cupertino Date'),
              ),
              Text(label)
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  _selectPDate() async {
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
                          fontFamily: 'IranYekan',
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
                          fontFamily: 'IranYekan',
                        ),
                      ),
                      onPressed: () {
                        print(tempPickedDate);

                        Navigator.of(context).pop(tempPickedDate);
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
                        dateTimePickerTextStyle: TextStyle(
                          fontFamily: "IranYekan"
                        ),
                      ),
                    ),
                    child: PCupertinoDatePicker(
                      mode: PCupertinoDatePickerMode.time,
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

    if (pickedDate != null) {
      setState(() {
        label = "${pickedDate.toDateTime()}";
      });
    }
  }

  _selectDate() async {
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        print(tempPickedDate);

                        Navigator.of(context).pop(tempPickedDate);
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
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
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

    if (pickedDate != null) {
      setState(() {
        label = pickedDate.toString();
      });
    }
  }
}
