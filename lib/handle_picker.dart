
import 'package:persian_datetime_picker/date_picker.dart';
import 'package:persian_datetime_picker/month_picker.dart';
import 'package:persian_datetime_picker/time_picker.dart';
import 'package:persian_datetime_picker/utils/consts.dart';
import 'package:persian_datetime_picker/utils/date.dart';
import 'package:persian_datetime_picker/widget/snack_bar.dart';
import 'package:persian_datetime_picker/year_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class HandlePicker extends StatefulWidget {
  final bool isRangeDate;
  final initDateTime;
  final type;
  final Function(String) onSelect;

  HandlePicker({this.isRangeDate, this.initDateTime, this.type, this.onSelect});

  @override
  _HandlePickerState createState() => _HandlePickerState();
}

class _HandlePickerState extends State<HandlePicker>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  // var initDate;
  // var initTime;
  var startSelectedInitDate;
  var startSelectedInitTime;
  var endSelectedInitDate;
  var endSelectedInitTime;
  var initDateTime;

  bool isSecondSelect;
  String pickerType = 'date';

  String outPutFormat(Date d) {
    final f = d.formatter;

    return '${f.yyyy}/${f.mm}/${f.dd}';
  }

  @override
  void initState() {
    super.initState();
    initDateTime = widget.initDateTime;
    if (initDateTime == null) {
      Jalali now = Jalali.now();
      switch (widget.type) {
        case 'rangedate':
          initDateTime = '${DateUtils.jalaliToString(now)} # ${DateUtils.jalaliToString(now)}';
          break;
        case 'datetime':
          initDateTime = '${DateUtils.jalaliToString(now)} 00:00';
          break;
        case 'date':
          initDateTime = '${DateUtils.jalaliToString(now)}';
          break;
        case 'time':
          initDateTime = '00:00';
          break;
        case 'year':
          initDateTime = '${now.formatter.yyyy}';

          break;
        case 'month':
          initDateTime = '${now.formatter.mm}';
          break;
        default:
      }
    }
    isSecondSelect = false;
    if (widget.type == 'rangedate') {
      if (initDateTime != null) {
        var splitInitDateTimes = initDateTime.split('#');
        var splitStartDateTime = splitInitDateTimes[0].split(' ');
        var splitEndDateTime = splitInitDateTimes[1].split(' ');
        startSelectedInitDate =
            splitStartDateTime.length > 0 ? splitStartDateTime[0] : null;
        startSelectedInitTime =
            splitStartDateTime.length > 1 ? splitStartDateTime[1] : null;

        endSelectedInitDate =
            splitEndDateTime.length > 0 ? splitEndDateTime[0] : null;
        endSelectedInitTime =
            splitEndDateTime.length > 1 ? splitEndDateTime[1] : null;
      } else {
        startSelectedInitDate = '${Jalali.now()}';
        endSelectedInitDate = '${Jalali.now()}';
        startSelectedInitTime =
            "${DateTime.now().hour}:${DateTime.now().minute}";
        endSelectedInitTime = "${DateTime.now().hour}:${DateTime.now().minute}";
      }
    } else {
      if (initDateTime != null) {
        var splitDateTime = initDateTime.split(' ');
        startSelectedInitDate =
            splitDateTime.length > 0 ? splitDateTime[0] : null;
        endSelectedInitDate =
            splitDateTime.length > 0 ? splitDateTime[0] : null;
        endSelectedInitTime =
            splitDateTime.length > 1 ? splitDateTime[1] : null;
      } else {
        startSelectedInitDate = '${Jalali.now()}';
        endSelectedInitDate = '${Jalali.now()}';
        startSelectedInitTime =
            "${DateTime.now().hour}:${DateTime.now().minute}";
        endSelectedInitTime = "${DateTime.now().hour}:${DateTime.now().minute}";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget picker;

    switch (widget.type) {
      case 'datetime':
        Widget picked;

        switch (pickerType) {
          case 'date':
            picked = DatePicker(
              startSelectedDate: startSelectedInitDate,
              endSelectedDate: endSelectedInitDate,
              isRangeDate: false,
              onChangePicker: (picker) {
                setState(() {
                  pickerType = 'year';
                });
              },
              onSelectDate: (date) {
                setState(() {
                  startSelectedInitDate = outPutFormat(date);
                  endSelectedInitDate = outPutFormat(date);
                });
              },
              onConfirmedDate: (date) {
                setState(() {
                  startSelectedInitDate = date;
                  pickerType = 'time';
                });
              },
            );
            break;
          case 'time':
            picked = TimePicker(
              initTime: startSelectedInitTime,
              onSelectDate: (time) {
                widget.onSelect('$startSelectedInitDate $time');
                Navigator.of(context).pop();
              },
            );
            break;
          case 'year':
            picked = PersianYearPicker(
              initDate: startSelectedInitDate,
              onSelectYear: (date) {
                setState(() {
                  startSelectedInitDate = outPutFormat(date);
                  endSelectedInitDate = outPutFormat(date);
                  pickerType = 'date';
                });
              },
            );
            break;
          default:
        }
        picker = Container(child: picked);
        break;
      case 'rangedate':
        Widget picked;
        switch (pickerType) {
          case 'date':
            picked = DatePicker(
              startSelectedDate: startSelectedInitDate,
              endSelectedDate: endSelectedInitDate,
              onChangePicker: (picker) {
                setState(() {
                  pickerType = 'year';
                });
              },
              isRangeDate: true,
              onConfirmedDate: (date) {
                widget.onSelect(date);
                Navigator.of(context).pop();
              },
              onSelectDate: (date) {
                var splitStartDate = startSelectedInitDate.split('/');
                var startSelectedDate = Jalali(
                        int.parse(splitStartDate[0]),
                        int.parse(splitStartDate[1]),
                        int.parse(splitStartDate[2])) ??
                    Jalali.now();
                setState(() {
                  if (!isSecondSelect) {
                    startSelectedInitDate = outPutFormat(date);
                    endSelectedInitDate = outPutFormat(date);
                    isSecondSelect = !isSecondSelect;
                    FlushbarHelper.show(context,
                        body: 'تاریخ دوم را انتخاب کنید.',
                        bgColor: Global.color);
                  } else if (isSecondSelect && date >= startSelectedDate) {
                    endSelectedInitDate = outPutFormat(date);
                    isSecondSelect = !isSecondSelect;
                  } else if (isSecondSelect && date < startSelectedDate) {
                    FlushbarHelper.show(context,
                        status: 'warning',
                        body: 'تاریخ انتخاب شده از تاریخ شروع کمتر است.',
                        bgColor: Global.color);
                  } else {
                    startSelectedInitDate = outPutFormat(date);
                    endSelectedInitDate = outPutFormat(date);
                  }
                });
              },
            );
            break;
          case 'time':
            picked = TimePicker(
              initTime: startSelectedInitTime,
              onSelectDate: (time) {
                widget.onSelect('$startSelectedInitDate $time');
                Navigator.of(context).pop();
              },
            );
            break;
          case 'year':
            picked = PersianYearPicker(
              initDate: startSelectedInitDate,
              onSelectYear: (date) {
                setState(() {
                  if (isSecondSelect) {
                    endSelectedInitDate = outPutFormat(date);
                  } else {
                    startSelectedInitDate = outPutFormat(date);
                  }
                  pickerType = 'date';
                });
              },
            );
            break;
          default:
        }
        picker = Container(child: picked);
        break;
      case 'time':
        setState(() {
          startSelectedInitTime = initDateTime;
        });
        picker = Container(
            child: TimePicker(
          initTime: startSelectedInitTime,
          onSelectDate: (time) {
            widget.onSelect('$time');
            Navigator.pop(context);
          },
        ));
        break;
      case 'date':
        Widget picked;

        switch (pickerType) {
          case 'date':
            picked = DatePicker(
              startSelectedDate: startSelectedInitDate,
              endSelectedDate: endSelectedInitDate,
              isRangeDate: false,
              onConfirmedDate: (date) {
                startSelectedInitDate = date;
                widget.onSelect(Global.test);
                Navigator.pop(context);
              },
              onSelectDate: (date) {
                setState(() {
                  startSelectedInitDate = outPutFormat(date);
                  endSelectedInitDate = outPutFormat(date);
                });
              },
              onChangePicker: (picker) {
                setState(() {
                  pickerType = 'year';
                });
              },
            );
            break;
          case 'year':
            picked = PersianYearPicker(
              initDate: startSelectedInitDate,
              onSelectYear: (date) {
                setState(() {
                  startSelectedInitDate = outPutFormat(date);
                  endSelectedInitDate = outPutFormat(date);
                  startSelectedInitDate = outPutFormat(date);
                  pickerType = 'date';
                });
              },
              onChangePicker: (picker) {
                setState(() {
                  pickerType = 'month';
                });
              },
            );
            break;
          case 'month':
            picked = PersianMonthPicker(
              initDate: startSelectedInitDate,
              onSelectMonth: (date) {
                setState(() {
                  startSelectedInitDate = outPutFormat(date);
                  endSelectedInitDate = outPutFormat(date);
                  startSelectedInitDate = outPutFormat(date);
                  pickerType = 'date';
                });
              },
            );
            break;
          default:
        }
        picker = Container(child: picked);
        break;
      case 'year':
        picker = Container(
            child: PersianYearPicker(
          initDate: DateUtils.jalaliToString(
              Jalali.now().copy(year: int.parse(startSelectedInitDate))),
          onSelectYear: (date) {
            startSelectedInitDate = outPutFormat(date);
            widget.onSelect('${date.formatter.yyyy}');
            Navigator.pop(context);
          },
        ));
        break;
      case 'month':
        picker = PersianMonthPicker(
          initDate: DateUtils.jalaliToString(
              Jalali.now().copy(month: int.parse(startSelectedInitDate))),
          onSelectMonth: (date) {
            startSelectedInitDate = outPutFormat(date);
            widget.onSelect('${date.formatter.mm}');
            Navigator.pop(context);
          },
        );
        break;
      default:
        Widget picked;

        switch (pickerType) {
          case 'date':
            picked = DatePicker(
              startSelectedDate: startSelectedInitDate,
              endSelectedDate: endSelectedInitDate,
              isRangeDate: false,
              onConfirmedDate: (date) {
                startSelectedInitDate = date;
                widget.onSelect('$startSelectedInitDate');
                Navigator.pop(context);
              },
              onSelectDate: (date) {
                setState(() {
                  startSelectedInitDate = outPutFormat(date);
                  endSelectedInitDate = outPutFormat(date);
                });
              },
              onChangePicker: (picker) {
                setState(() {
                  pickerType = 'year';
                });
              },
            );
            break;
          case 'year':
            picked = PersianYearPicker(
              initDate: startSelectedInitDate,
              onSelectYear: (date) {
                setState(() {
                  startSelectedInitDate = outPutFormat(date);
                  endSelectedInitDate = outPutFormat(date);
                  startSelectedInitDate = outPutFormat(date);
                  pickerType = 'date';
                });
              },
              onChangePicker: (picker) {
                setState(() {
                  pickerType = 'month';
                });
              },
            );
            break;
          case 'month':
            picked = PersianMonthPicker(
              initDate: startSelectedInitDate,
              onSelectMonth: (date) {
                setState(() {
                  startSelectedInitDate = outPutFormat(date);
                  endSelectedInitDate = outPutFormat(date);
                  startSelectedInitDate = outPutFormat(date);
                  pickerType = 'date';
                });
              },
            );
            break;
          default:
        }
        picker = Container(child: picked);
        break;
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: picker,
    );
  }
}
