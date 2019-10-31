import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/utils/consts.dart';
import 'package:persian_datetime_picker/utils/date.dart';

class TimePicker extends StatefulWidget {
  final initTime;
  final Function(String) onSelectDate;

  TimePicker({this.initTime, this.onSelectDate});

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  var initHour;
  var initMinute;
  String changeState = 'hour';
  bool isSlideForward = true;
  var dateUtiles = new DateUtils();
  bool isDisable = false;

  @override
  void initState() {
    super.initState();
    if (widget.initTime == null) {
      var now = new DateTime.now();
      initHour = now.hour;
      initMinute = now.minute;
    } else {
      var split = widget.initTime.split(':');
      initHour = int.parse(split[0]);
      initMinute = int.parse(split[1]);
    }
    isDisable = dateUtiles.isDisable('$initHour:$initMinute');
    controller =
        AnimationController(duration: Duration(milliseconds: 150), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut)
      ..addListener(() {
        setState(() {});
      });
  }

  _changeHour(type) {
    setState(() {
      changeState = 'hour';
      controller.forward(from: 0);

      switch (type) {
        case 'prev':
          isSlideForward = true;
          initHour = initHour > 0 ? initHour - 1 : 24;
          break;
        case 'next':
          isSlideForward = false;
          initHour = initHour < 24 ? initHour + 1 : 0;
          break;
        case 'now':
          var now = new DateTime.now();
          initHour = now.hour;
          initMinute = now.minute;
          break;
        default:
      }

      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isSlideForward = type == 'prev' ? false : true;
          isDisable = dateUtiles.isDisable('$initHour:$initMinute');
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // controller.forward();
        }
      });
    });
  }

  _changeMinute(type) {
    setState(() {
      changeState = 'minute';
      controller.forward(from: 0);

      switch (type) {
        case 'prev':
          isSlideForward = true;
          initMinute = initMinute > 0 ? initMinute - 1 : 59;
          break;
        case 'next':
          isSlideForward = false;
          initMinute = initMinute < 59 ? initMinute + 1 : 0;
          break;
        case 'now':
          var now = new DateTime.now();
          initHour = now.hour;
          initMinute = now.minute;
          break;
        default:
      }
      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isSlideForward = type == 'prev' ? false : true;
          isDisable = dateUtiles.isDisable('$initHour:$initMinute');
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // controller.forward();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    '$initHour:$initMinute',
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
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          FlatButton(
                            child: Icon(
                              Icons.expand_less,
                              size: 50,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _changeMinute('next');
                            },
                          ),
                          Transform(
                            transform: Matrix4.translationValues(
                                0,
                                changeState == 'minute'
                                    ? animation.value *
                                        (isSlideForward ? 50 : -50)
                                    : 0,
                                0),
                            child: Opacity(
                              opacity: changeState == 'minute'
                                  ? 1 - animation.value
                                  : 1,
                              child: Text(
                                initMinute.toString(),
                                style: TextStyle(
                                  fontSize: 40,
                                  color: isDisable
                                      ? Colors.grey.withOpacity(0.5)
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          FlatButton(
                            child: Icon(
                              Icons.expand_more,
                              size: 50,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _changeMinute('prev');
                            },
                          ),
                        ],
                      ),
                    ),
                    Text(
                      ':',
                      style: TextStyle(
                        fontSize: 50,
                        color: isDisable
                            ? Colors.grey.withOpacity(0.5)
                            : Colors.grey,
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          FlatButton(
                            child: Icon(
                              Icons.expand_less,
                              size: 50,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _changeHour('next');
                            },
                          ),
                          Transform(
                            transform: Matrix4.translationValues(
                                0,
                                changeState == 'hour'
                                    ? animation.value *
                                        (isSlideForward ? 50 : -50)
                                    : 0,
                                0),
                            child: Opacity(
                              opacity: changeState == 'hour'
                                  ? 1 - animation.value
                                  : 1,
                              child: Text(
                                initHour.toString(),
                                style: TextStyle(
                                  fontSize: 40,
                                  color: isDisable
                                      ? Colors.grey.withOpacity(0.5)
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          FlatButton(
                            child: Icon(
                              Icons.expand_more,
                              size: 50,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _changeHour('prev');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
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
                    style: TextStyle(
                        fontSize: 16,
                        color: isDisable
                            ? Global.color.withOpacity(0.5)
                            : Global.color),
                  ),
                  onPressed: () {
                    if (!isDisable)
                      widget.onSelectDate('$initHour:$initMinute');
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
                    _changeHour('now');
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
