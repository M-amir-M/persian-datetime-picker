import 'package:persian_datetime_picker/widget/render_table.dart';
import 'package:persian_datetime_picker/widget/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DatePicker extends StatefulWidget {
  final bool isRangeDate;
  final initDate;
  final startSelectedDate;
  final endSelectedDate;
  final Function(String) onSelectDate;

  DatePicker(
      {this.isRangeDate,
      this.initDate,
      this.startSelectedDate,
      this.endSelectedDate,
      this.onSelectDate});

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  Jalali initDate;
  Jalali startSelectedDate;
  Jalali endSelectedDate;
  bool isRangeDate;

  bool isSecondSelect = false;
  bool isSlideForward = true;

  final weekDaysName = [
    'ش',
    'ی',
    'د',
    'س ',
    'چ',
    'پ',
    'ج',
  ];

  @override
  void didUpdateWidget(DatePicker oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    isRangeDate = widget.isRangeDate;

    if (isRangeDate) {
      if (widget.initDate != null) {
        var splitInitDate = widget.initDate.split('#');
        var splitStartDate = splitInitDate[0].split('/');
        var splitEndDate = splitInitDate[1].split('/');
        startSelectedDate = Jalali(int.parse(splitStartDate[0]),
                int.parse(splitStartDate[1]), int.parse(splitStartDate[2])) ??
            Jalali.now();
        endSelectedDate = Jalali(int.parse(splitEndDate[0]),
                int.parse(splitEndDate[1]), int.parse(splitEndDate[2])) ??
            Jalali.now();

        initDate = Jalali.now();
      } else {
        initDate = Jalali.now();
        startSelectedDate = initDate;
        endSelectedDate = initDate;
      }
    } else {
      print('${widget.initDate}==============');
      if (widget.initDate != null) {
        var splitInitDate = widget.initDate.split('/');
        initDate = Jalali(int.parse(splitInitDate[0]),
                int.parse(splitInitDate[1]), int.parse(splitInitDate[2])) ??
            Jalali.now();
        startSelectedDate = initDate;
        endSelectedDate = initDate;
      } else {
        initDate = Jalali.now();
        startSelectedDate = initDate;
        endSelectedDate = initDate;
      }
    }

    controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut)
      ..addListener(() {
        setState(() {});
      });
  }

  _changeMonth(type) {
    setState(() {
      controller.forward(from: 0);
      int year = int.parse(initDate.formatter.y);
      int month = int.parse(initDate.formatter.m);
      int day = int.parse(initDate.formatter.d);
      var newDate = initDate;
      switch (type) {
        case 'prev':
          isSlideForward = true;

          newDate = initDate.copy(
              month: month > 1 ? month - 1 : 12,
              year: month == 1 ? year - 1 : year);
          break;
        case 'next':
          isSlideForward = false;

          newDate = initDate.copy(
              month: month < 12 ? month + 1 : 1,
              year: month == 12 ? year + 1 : year);
          break;
        case 'now':
          newDate = Jalali.now();
          break;
        default:
      }

      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          initDate = newDate;

          isSlideForward = type == 'prev' ? false : true;
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // controller.forward();
        }
      });
    });
  }

  String outPutFormat(Date d) {
    final f = d.formatter;

    return '${f.yyyy}/${f.mm}/${f.dd}';
  }

  String fullFormat(Date d) {
    final f = d.formatter;

    return '${f.wN} ${f.d} ${f.mN} ${f.yy}';
  }

  String yearMonthNFormat(Date d) {
    final f = d.formatter;

    return '${f.mN} ${f.yy}';
  }

  String monthDayFormat(Date d) {
    final f = d.formatter;

    return '${f.wN} ${f.dd} ${f.mN}';
  }

  @override
  Widget build(BuildContext context) {
    final cellWidth = 42.0;
    final cellHeight = 35.0;

    List weekDaysWidget = weekDaysName.map((day) {
      return Container(
        width: cellWidth,
        height: cellHeight,
        child: Text(
          day,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      );
    }).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
          child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: isRangeDate
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'از ${fullFormat(startSelectedDate)}',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'تا ${fullFormat(endSelectedDate)}',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${startSelectedDate.formatter.yyyy}',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '${monthDayFormat(startSelectedDate)}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          _changeMonth('prev');
                        },
                        icon: Icon(Icons.chevron_left),
                      ),
                      Transform(
                          transform: Matrix4.translationValues(
                              animation.value * (isSlideForward ? 100 : -100),
                              0,
                              0),
                          child: Opacity(
                            opacity: 1 - animation.value,
                            child: Text(yearMonthNFormat(initDate)),
                          )),
                      IconButton(
                        onPressed: () {
                          _changeMonth('next');
                        },
                        icon: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: weekDaysWidget,
                  ),
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      animation.value * (isSlideForward ? 300 : -300), 0, 0),
                  child: Opacity(
                    opacity: 1 - animation.value,
                    child: RenderTable(
                      initDate: initDate,
                      startSelectedDate: startSelectedDate,
                      endSelectedDate: endSelectedDate,
                      onSelect: (date) {
                        setState(() {
                          if (widget.isRangeDate && !isSecondSelect) {
                            startSelectedDate = date;
                            endSelectedDate = date;
                            isSecondSelect = !isSecondSelect;
                            FlushbarHelper.show(context,
                                body: 'تاریخ دوم را انتخاب کنید.',
                                bgColor: Colors.blueAccent);
                          } else if (widget.isRangeDate &&
                              isSecondSelect &&
                              date >= startSelectedDate) {
                            endSelectedDate = date;
                            isSecondSelect = !isSecondSelect;
                          } else if (widget.isRangeDate &&
                              isSecondSelect &&
                              date < startSelectedDate) {
                            FlushbarHelper.show(context,
                                status: 'warning',
                                body:
                                    'تاریخ انتخاب شده از تاریخ شروع کمتر است.',
                                bgColor: Colors.blueAccent);
                          } else {
                            startSelectedDate = date;
                            endSelectedDate = date;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'تایید',
                    style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                  onPressed: () {
                    if (isRangeDate) {
                      widget.onSelectDate(
                          '$startSelectedDate # $endSelectedDate');
                    } else {
                      widget.onSelectDate('$startSelectedDate');
                    }
                  },
                ),
                FlatButton(
                  child: Text(
                    'انصراف',
                    style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text(
                    'اکنون',
                    style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                  onPressed: () {
                    startSelectedDate = Jalali.now();
                    endSelectedDate = Jalali.now();
                    _changeMonth('now');
                  },
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
