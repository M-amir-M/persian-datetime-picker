import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/utils/consts.dart';
import 'package:persian_datetime_picker/utils/date.dart';
import 'package:persian_datetime_picker/widget/partition.dart';
import 'package:shamsi_date/shamsi_date.dart';

class PersianMonthPicker extends StatefulWidget {
  final initDate;
  final Function(Jalali) onSelectMonth;

  PersianMonthPicker({this.initDate, this.onSelectMonth});

  @override
  _PersianMonthPickerState createState() => _PersianMonthPickerState();
}

class _PersianMonthPickerState extends State<PersianMonthPicker>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  int selectedMonth;
  List months;
  var initDate;
  String monthNFormat(Date d) {
    final f = d.formatter;

    return '${f.mN}';
  }

  _makeMonthList() {
    setState(() {
      months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    });
  }

  
  String outPutFormat(Date d) {
    final f = d.formatter;

    return '${f.yyyy}/${f.mm}/${f.dd}';
  }

  @override
  void initState() {
    months = [];
    super.initState();
    if (widget.initDate != null) {
      var splitInitDate = widget.initDate.split('#');
      var splitStartDate = splitInitDate[0].split('/');
      initDate = Jalali(int.parse(splitStartDate[0]),
              int.parse(splitStartDate[1]), int.parse(splitStartDate[2])) ??
          Jalali.now();

      selectedMonth = initDate.month;
    } else {
      initDate = Jalali.now();
      selectedMonth = initDate.month;
    }

    _makeMonthList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> monthList = months.map((month) {
      BoxDecoration decoration = BoxDecoration();
      if (initDate.month == month) {
        decoration = BoxDecoration(
            color: Global.color,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(0.0, 4.0),
                  spreadRadius: -2.0,
                  blurRadius: 1.0)
            ],
            borderRadius: BorderRadius.all(Radius.circular(50.0)));
      }
      var dateUtiles = new DateUtils();
      bool isDisable = dateUtiles.isDisable('$month');
      return GestureDetector(
        onTap: () {
          setState(() {
            if (!isDisable) initDate = initDate.copy(month: month);
          });
        },
        child: Container(
          decoration: decoration,
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(3),
          child: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                color:
                    initDate.month == month ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Center(
              child: Text(
                '${monthNFormat(initDate.copy(month: month))}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: isDisable ? Colors.grey : Colors.black,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      );
    }).toList();

    List chunks = partition(monthList, 3).toList();

    List rows = chunks.map((row) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row,
        ),
      );
    }).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Global.color,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${monthNFormat(initDate)}',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ],
              )),
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: rows,
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
                    style: TextStyle(fontSize: 16, color: Global.color),
                  ),
                  onPressed: () {
                    widget.onSelectMonth(initDate);
                  },
                ),
                FlatButton(
                  child: Text(
                    'انصراف',
                    style: TextStyle(fontSize: 16, color: Global.color),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text(
                    'اکنون',
                    style: TextStyle(fontSize: 16, color: Global.color),
                  ),
                  onPressed: () {
                    setState(() {
                      initDate = Jalali.now();
                      selectedMonth = initDate.month;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
