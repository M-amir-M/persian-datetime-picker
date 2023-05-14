import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

final ThemeData androidTheme = new ThemeData(
  fontFamily: 'Dana',
);

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: androidTheme,
      home: new MyHomePage(key: super.key, title: 'دیت تایم پیکر فارسی'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String label = '';

  String selectedDate = Jalali.now().toJalaliDateTime();

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
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: new Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.white, Color(0xffE4F5F9)],
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            physics: BouncingScrollPhysics(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      imageButton(
                        onTap: () async {
                          Jalali? picked = await showPersianDatePicker(
                              context: context,
                              initialDate: Jalali.now(),
                              firstDate: Jalali(1385, 8),
                              lastDate: Jalali(1450, 9),
                              initialEntryMode:
                                  PDatePickerEntryMode.calendarOnly,
                              initialDatePickerMode: PDatePickerMode.year,
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData(
                                    dialogTheme: const DialogTheme(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0)),
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              });
                          if (picked != null && picked != selectedDate) {
                            setState(() {
                              label = picked.toJalaliDateTime();
                            });
                          }
                        },
                        image: '08',
                      ),
                      imageButton(
                        onTap: () async {
                          Jalali? pickedDate =
                              await showModalBottomSheet<Jalali>(
                            context: context,
                            builder: (context) {
                              Jalali? tempPickedDate;
                              return Container(
                                height: 250,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                              Navigator.of(context).pop(
                                                  tempPickedDate ??
                                                      Jalali.now());
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
                                        child: PCupertinoDatePicker(
                                          mode: PCupertinoDatePickerMode
                                              .dateAndTime,
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

                          if (pickedDate != null) {
                            setState(() {
                              label = '${pickedDate.toDateTime()}';
                            });
                          }
                        },
                        image: '07',
                      ),
                      imageButton(
                        onTap: () async {
                          var picked = await showPersianTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            initialEntryMode: PTimePickerEntryMode.input,
                            builder: (BuildContext context, Widget? child) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                ),
                              );
                            },
                          );
                          setState(() {
                            if (picked != null)
                              label = picked.persianFormat(context);
                          });
                        },
                        image: '09',
                      ),
                      imageButton(
                        onTap: () async {
                          Jalali? pickedDate =
                              await showModalBottomSheet<Jalali>(
                            context: context,
                            builder: (context) {
                              Jalali? tempPickedDate;
                              return Container(
                                height: 250,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                              print(tempPickedDate ??
                                                  Jalali.now());

                                              Navigator.of(context).pop(
                                                  tempPickedDate ??
                                                      Jalali.now());
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
                                        child: PCupertinoDatePicker(
                                          mode: PCupertinoDatePickerMode.time,
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

                          if (pickedDate != null) {
                            setState(() {
                              label = '${pickedDate.toJalaliDateTime()}';
                            });
                          }
                        },
                        image: '05',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      imageButton(
                        onTap: () async {
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
                            label =
                                "${picked?.start?.toJalaliDateTime() ?? ""} ${picked?.end?.toJalaliDateTime() ?? ""}";
                          });
                        },
                        image: '03',
                      ),
                      imageButton(
                        onTap: () async {
                          var picked = await showPersianTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (BuildContext context, Widget? child) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: child!,
                              );
                            },
                          );
                          setState(() {
                            if (picked != null)
                              label = picked.persianFormat(context);
                          });
                        },
                        image: '04',
                      ),
                      imageButton(
                        onTap: () async {
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
                          setState(() {
                            label =
                                "${picked?.start?.toJalaliDateTime() ?? ""} ${picked?.end?.toJalaliDateTime() ?? ""}";
                          });
                        },
                        image: '06',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 70,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 3,
              spreadRadius: 0,
              offset: Offset(0, 4),
              color: Color(0xff000000).withOpacity(0.3),
            ),
          ], color: Colors.white),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget imageButton({
    required Function onTap,
    required String image,
  }) {
    return ScaleGesture(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 0,
                offset: Offset(0, 4),
                color: Color(0xff000000).withOpacity(0.3),
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Image.asset(
          'assets/images/$image.png',
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

class ScaleGesture extends StatefulWidget {
  final Widget child;
  final double scale;
  final Function onTap;

  ScaleGesture({
    required this.child,
    this.scale = 1.1,
    required this.onTap,
  });

  @override
  _ScaleGestureState createState() => _ScaleGestureState();
}

class _ScaleGestureState extends State<ScaleGesture> {
  late double scale;

  @override
  void initState() {
    scale = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (detail) {
        setState(() {
          scale = widget.scale;
        });
      },
      onTapCancel: () {
        setState(() {
          scale = 1;
        });
      },
      onTapUp: (datail) {
        setState(() {
          scale = 1;
        });
        widget?.onTap();
      },
      child: Transform.scale(
        scale: scale,
        child: widget.child,
      ),
    );
  }
}
