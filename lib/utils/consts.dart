import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Global {
  static Color color = Colors.blueAccent;
  static PickerType pickerType = PickerType.date;
  static var disable;
  static var min;
  static var max;
}

enum PickerType {
  datetime,
  date,
  time,
  rangedate,
  month,
  year,
  day,
}
