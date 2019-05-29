import 'package:persian_datetime_picker/date_picker.dart';
import 'package:persian_datetime_picker/time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class HandlePicker extends StatefulWidget {
  final bool isRangeDate;
  final initDateTime;
  final type;
  final Function(String) onSelect;

  HandlePicker(
      {this.isRangeDate, this.initDateTime, this.type, this.onSelect});

  @override
  _HandlePickerState createState() => _HandlePickerState();
}

class _HandlePickerState extends State<HandlePicker>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  var initDate;
  var initTime;
  var startSelectedDate;
  var endSelectedDate;

  bool isSecondSelect = false;
  String pickerType = 'date';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget picker;
    switch (widget.type) {
      case 'datetime':
        if (widget.initDateTime != null) {
          var split = widget.initDateTime.split(' ');
          initDate = split.length > 0 ? split[0] : null;
          initTime = split.length > 1 ? split[1] : null;
        } else {
          var f = Jalali.now().formatter;
          initDate = '${f.yyyy}/${f.mm}/${f.dd}';
          initTime = "${DateTime.now().hour}:${DateTime.now().minute}";
        }

        picker = Container(
            child: pickerType == 'date'
                ? DatePicker(
                    initDate: initDate,
                    isRangeDate: false,
                    onSelectDate: (date) {
                      setState(() {
                        startSelectedDate = date;
                        pickerType = 'time';
                      });
                    },
                  )
                : TimePicker(
                    initTime: initTime,
                    onSelectDate: (time) {
                      widget.onSelect('$startSelectedDate $time');
                      Navigator.pop(context);
                    },
                  ));
        break;
      case 'rangedate':
        picker = Container(
            child: DatePicker(
          initDate: widget.initDateTime,
          isRangeDate: true,
          onSelectDate: (date) {
            widget.onSelect('$date');
            Navigator.pop(context);
          },
        ));
        break;
      case 'time':
        picker = Container(
            child: TimePicker(
          initTime: initTime,
          onSelectDate: (time) {
            widget.onSelect('$time');
            Navigator.pop(context);
          },
        ));
        break;
      case 'date':
        picker = Container(
            child: DatePicker(
          initDate: initDate,
          isRangeDate: false,
          onSelectDate: (date) {
            startSelectedDate = date;
            widget.onSelect('$startSelectedDate');
            Navigator.pop(context);
          },
        ));
        break;
      default:
        picker = Container(
            child: DatePicker(
          initDate: initDate,
          isRangeDate: false,
          onSelectDate: (date) {
            startSelectedDate = date;
            widget.onSelect('$startSelectedDate');
            Navigator.pop(context);
          },
        ));
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: picker,
    );
  }
}
