import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date and Time Pickers',
      locale: const Locale("fa", "IR"),
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale("fa", "IR"),
        Locale("en", "US"),
      ],
      localizationsDelegates: const [
        PersianMaterialLocalizations.delegate,
        PersianCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        fontFamily: 'Dana',
        datePickerTheme: DatePickerThemeData(
          // headerBackgroundColor: Color(0xffFF4893), // Header background color
          // backgroundColor: Color(0xff121212),
          // dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>(
          //   (Set<WidgetState> states) {
          //     if (states.contains(WidgetState.selected)) {
          //       return Color(0xff89ED5B); // Background color for selected day
          //     } else if (states.contains(WidgetState.disabled)) {
          //       return Colors
          //           .grey.shade200; // Background color for disabled days
          //     }
          //     return Color(0xff121212); // Default background color for normal days
          //   },
          // ),
          // dayForegroundColor: WidgetStateProperty.resolveWith<Color?>(
          //   (Set<WidgetState> states) {
          //     if (states.contains(WidgetState.selected)) {
          //       return Color(0xff121212); // Background color for selected day
          //     } else if (states.contains(WidgetState.disabled)) {
          //       return Colors
          //           .grey.shade200; // Background color for disabled days
          //     }
          //     return Color(0xff89ED5B); // Default background color for normal days
          //   },
          // ),
          // confirmButtonStyle: ButtonStyle(
          //   textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white))
          // ),
          // headerForegroundColor: Colors.white, // Header text color
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String label = '';

  String selectedDate = Jalali.now().toJalaliDateTime();

  @override
  void initState() {
    super.initState();
    label = 'انتخاب تاریخ زمان';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'دیت تایم پیکر فارسی',
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
                              PersianDatePickerEntryMode.calendarOnly,
                          initialDatePickerMode: PersianDatePickerMode.year,
                        );
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
                        Jalali? pickedDate = await showModalBottomSheet<Jalali>(
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
                                                tempPickedDate ?? Jalali.now());
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
                                          textStyle:
                                              TextStyle(fontFamily: 'Dana'),
                                          dateTimePickerTextStyle: TextStyle(
                                              fontFamily: 'Dana', fontSize: 20),
                                        )),
                                        child: PersianCupertinoDatePicker(
                                          mode: PersianCupertinoDatePickerMode
                                              .date,
                                          dateOrder: DatePickerDateOrder.dmy,
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
                            label = '${pickedDate.toDateTime()}';
                          });
                        }
                      },
                      image: '07',
                    ),
                    imageButton(
                      onTap: () async {
                        var picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          initialEntryMode: TimePickerEntryMode.input,
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
                          if (picked != null) label = picked.toString();
                        });
                      },
                      image: '09',
                    ),
                    imageButton(
                      onTap: () async {
                        Jalali? pickedDate = await showModalBottomSheet<Jalali>(
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
                                            print(
                                                tempPickedDate ?? Jalali.now());

                                            Navigator.of(context).pop(
                                                tempPickedDate ?? Jalali.now());
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
                                      child: PersianCupertinoDatePicker(
                                        initialDateTime: Jalali.now(),
                                        mode:
                                            PersianCupertinoDatePickerMode.time,
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
                          initialDate: Jalali.now(),
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
                        var picked = await showPersianDateRangePicker(
                          context: context,
                          initialEntryMode: PersianDatePickerEntryMode.input,
                          initialDateRange: JalaliRange(
                            start: Jalali(1400, 1, 2),
                            end: Jalali(1400, 1, 10),
                          ),
                          firstDate: Jalali(1385, 8),
                          lastDate: Jalali(1450, 9),
                          initialDate: Jalali.now(),
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
