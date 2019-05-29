import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DayContainer extends StatefulWidget {
  final date;
  final startDate;
  final endDate;
  final Function(Jalali) onSelect;
  final width;
  final height;

  DayContainer(
      {this.date,
      this.startDate,
      this.endDate,
      this.onSelect,
      this.height,
      this.width});
  @override
  _DayContainerState createState() => _DayContainerState();
}

class _DayContainerState extends State<DayContainer> {
  var date;

  @override
  void initState() {
    date = widget.date;
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(DayContainer oldWidget) {
    if (oldWidget != widget) {
      date = widget.date;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var decoration = BoxDecoration();

    bool isValid = date != '';
    bool isStart = isValid && date == widget.startDate;
    bool isBetween =
        isValid && date > widget.startDate && date < widget.endDate;
    bool isEnd = isValid && date == widget.endDate;

    if (isStart) {
      decoration = BoxDecoration(
          color: Colors.blueAccent,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0.0, 2.0),
                spreadRadius: 1.0,
                blurRadius: 1.0)
          ],
          borderRadius: BorderRadius.horizontal(right: Radius.circular(50.0)));
    }
    if (isEnd) {
      decoration = BoxDecoration(
          color: Colors.blueAccent,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0.0, 4.0),
                spreadRadius: -2.0,
                blurRadius: 1.0)
          ],
          borderRadius: BorderRadius.horizontal(left: Radius.circular(50.0)));
    }
    if (isEnd && isStart) {
      decoration = BoxDecoration(
          color: Colors.blueAccent,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0.0, 4.0),
                spreadRadius: -2.0,
                blurRadius: 1.0)
          ],
          borderRadius: BorderRadius.all(Radius.circular(50.0)));
    }
    if (isBetween) {
      decoration = BoxDecoration(
        color: Colors.blueAccent,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(0.0, 4.0),
              spreadRadius: -2.0,
              blurRadius: 1.0)
        ],
      );
    }
    return InkWell(
      onTap: () {
        if (date != '') {
          widget.onSelect(date);
        }
      },
      child: date != ''
          ? Container(
              decoration: decoration,
              width: widget.width,
              height: widget.height,
              child: Container(
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: isStart || isEnd ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Center(
                  child: Text(
                    date != '' ? date.formatter.d : '',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            )
          : Container(
              width: widget.width,
              height: widget.height,
            ),
    );
  }
}
