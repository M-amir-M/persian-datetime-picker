library persian_datetime_picker;

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/widget/dialog.dart';

import 'handle_picker.dart';

class PersianDateTimePicker extends StatefulWidget {
  final initial;
  final type;
  final Function(String) onSelect;
  PersianDateTimePicker(
      {this.type = 'date', this.initial = null, this.onSelect});

  @override
  _PersianDateTimePickerState createState() => _PersianDateTimePickerState();
}

class _PersianDateTimePickerState extends State<PersianDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CDialog(
        insetAnimationCurve: Curves.bounceInOut,
        insetAnimationDuration: Duration(seconds: 2),
        child: HandlePicker(
          type: widget.type,
          initDateTime: widget.initial,
          onSelect: widget.onSelect,
        ),
      ),
    );
  }
}
