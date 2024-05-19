import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

final ThemeData androidTheme = ThemeData(
  fontFamily: 'Dana',
);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: androidTheme,
      home: MyHomePage(key: super.key, title: 'دیت تایم پیکر فارسی'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.white, Color(0xffE4F5F9)],
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            physics: const BouncingScrollPhysics(),
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
                              return SizedBox(
                                height: 250,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CupertinoButton(
                                          child: const Text(
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
                                          child: const Text(
                                            'تایید',
                                            style: TextStyle(
                                              fontFamily: 'Dana',
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop(
                                                tempPickedDate ?? Jalali.now());
                                          },
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      height: 0,
                                      thickness: 1,
                                    ),
                                    Expanded(
                                      child: PCupertinoDatePicker(
                                        mode: PCupertinoDatePickerMode
                                            .dateAndTime,
                                        onDateTimeChanged: (Jalali dateTime) {
                                          tempPickedDate = dateTime;
                                        },
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
                            if (picked != null) {
                              label = picked.persianFormat(context);
                            }
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
                              return SizedBox(
                                height: 250,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CupertinoButton(
                                          child: const Text(
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
                                          child: const Text(
                                            'تایید',
                                            style: TextStyle(
                                              fontFamily: 'Dana',
                                            ),
                                          ),
                                          onPressed: () {
                                            print(
                                                tempPickedDate ?? Jalali.now());

                                            Navigator.of(context).pop(
                                                tempPickedDate ?? Jalali.now());
                                          },
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      height: 0,
                                      thickness: 1,
                                    ),
                                    Expanded(
                                      child: PCupertinoDatePicker(
                                        mode: PCupertinoDatePickerMode.time,
                                        onDateTimeChanged: (Jalali dateTime) {
                                          tempPickedDate = dateTime;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );

                          if (pickedDate != null) {
                            setState(() {
                              label = pickedDate.toJalaliDateTime();
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
                                "${picked?.start.toJalaliDateTime() ?? ""} ${picked?.end.toJalaliDateTime() ?? ""}";
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
                            if (picked != null) {
                              label = picked.persianFormat(context);
                            }
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
                                "${picked?.start.toJalaliDateTime() ?? ""} ${picked?.end.toJalaliDateTime() ?? ""}";
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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 3,
              spreadRadius: 0,
              offset: const Offset(0, 4),
              color: const Color(0xff000000).withOpacity(0.3),
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
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 0,
                offset: const Offset(0, 4),
                color: const Color(0xff000000).withOpacity(0.3),
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(10))),
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
  const ScaleGesture({
    super.key,
    required this.child,
    this.scale = 1.1,
    required this.onTap,
  });

  @override
  State<ScaleGesture> createState() => _ScaleGestureState();
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
        widget.onTap();
      },
      child: Transform.scale(
        scale: scale,
        child: widget.child,
      ),
    );
  }
}
