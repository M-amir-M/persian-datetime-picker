library persian_datetime_picker;

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/utils/consts.dart';
import 'package:persian_datetime_picker/widget/dialog.dart';

import 'handle_picker.dart';

class PersianDateTimePicker extends StatefulWidget {
  final initial;
  final type;
  final disable;
  final Color color;
  final Function(String) onSelect;
  PersianDateTimePicker(
      {this.type = 'date',
      this.initial = null,
      this.disable = null,
      this.color = Colors.blueAccent,
      this.onSelect});

  @override
  _PersianDateTimePickerState createState() => _PersianDateTimePickerState();
}

class _PersianDateTimePickerState extends State<PersianDateTimePicker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Global.color = widget.color;
    Global.pickerType = widget.type;
    Global.disable = widget.disable;
  }

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
