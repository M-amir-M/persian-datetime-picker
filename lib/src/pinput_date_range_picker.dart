import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/src/date/shamsi_date.dart';

import 'pdate_utils.dart' as utils;

/// Provides a pair of text fields that allow the user to enter the start and
/// end dates that represent a range of dates.
//
// This is not publicly exported (see pickers.dart), as it is just an
// internal component used by [showDateRangePicker].
class PInputDateRangePicker extends StatefulWidget {
  /// Creates a row with two text fields configured to accept the start and end dates
  /// of a date range.
  PInputDateRangePicker({
    Key? key,
    Jalali? initialStartDate,
    Jalali? initialEndDate,
    required Jalali firstDate,
    required Jalali lastDate,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
    this.helpText,
    this.errorFormatText,
    this.errorInvalidText,
    this.errorInvalidRangeText,
    this.fieldStartHintText,
    this.fieldEndHintText,
    this.fieldStartLabelText,
    this.fieldEndLabelText,
    this.autofocus = false,
    this.autovalidate = false,
  })  : initialStartDate =
            initialStartDate == null ? null : utils.dateOnly(initialStartDate),
        initialEndDate =
            initialEndDate == null ? null : utils.dateOnly(initialEndDate),
        firstDate = utils.dateOnly(firstDate),
        lastDate = utils.dateOnly(lastDate),
        super(key: key);

  /// The [Jalali] that represents the start of the initial date range selection.
  final Jalali? initialStartDate;

  /// The [Jalali] that represents the end of the initial date range selection.
  final Jalali? initialEndDate;

  /// The earliest allowable [Jalali] that the user can select.
  final Jalali firstDate;

  /// The latest allowable [Jalali] that the user can select.
  final Jalali lastDate;

  /// Called when the user changes the start date of the selected range.
  final ValueChanged<Jalali?> onStartDateChanged;

  /// Called when the user changes the end date of the selected range.
  final ValueChanged<Jalali?> onEndDateChanged;

  /// The text that is displayed at the top of the header.
  ///
  /// This is used to indicate to the user what they are selecting a date for.
  final String? helpText;

  /// Error text used to indicate the text in a field is not a valid date.
  final String? errorFormatText;

  /// Error text used to indicate the date in a field is not in the valid range
  /// of [firstDate] - [lastDate].
  final String? errorInvalidText;

  /// Error text used to indicate the dates given don't form a valid date
  /// range (i.e. the start date is after the end date).
  final String? errorInvalidRangeText;

  /// Hint text shown when the start date field is empty.
  final String? fieldStartHintText;

  /// Hint text shown when the end date field is empty.
  final String? fieldEndHintText;

  /// Label used for the start date field.
  final String? fieldStartLabelText;

  /// Label used for the end date field.
  final String? fieldEndLabelText;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// If true, this the date fields will validate and update their error text
  /// immediately after every change. Otherwise, you must call
  /// [PInputDateRangePickerState.validate] to validate.
  final bool autovalidate;

  @override
  PInputDateRangePickerState createState() => PInputDateRangePickerState();
}

/// The current state of an [PInputDateRangePicker]. Can be used to
/// [validate] the date field entries.
class PInputDateRangePickerState extends State<PInputDateRangePicker> {
  String? _startInputText;
  String? _endInputText;
  Jalali? _startDate;
  Jalali? _endDate;
  TextEditingController? _startController;
  TextEditingController? _endController;
  String? _startErrorText;
  String? _endErrorText;
  bool _autoSelected = false;

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStartDate;
    _startController = TextEditingController();
    _endDate = widget.initialEndDate;
    _endController = TextEditingController();
  }

  @override
  void dispose() {
    _startController!.dispose();
    _endController!.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_startDate != null) {
      _startInputText = _startDate!.formatCompactDate();
      final bool selectText = widget.autofocus && !_autoSelected;
      _updateController(_startController!, _startInputText, selectText);
      _autoSelected = selectText;
    }

    if (_endDate != null) {
      _endInputText = _endDate!.formatCompactDate();
      _updateController(_endController!, _endInputText, false);
    }
  }

  /// Validates that the text in the start and end fields represent a valid
  /// date range.
  ///
  /// Will return true if the range is valid. If not, it will
  /// return false and display an appropriate error message under one of the
  /// text fields.
  bool validate() {
    String? startError = _validateDate(_startDate);
    final String? endError = _validateDate(_endDate);
    if (startError == null && endError == null) {
      if (_startDate!.isAfter(_endDate!)) {
        startError = widget.errorInvalidRangeText ?? 'تاریخ معتبر نمی باشد.';
      }
    }
    setState(() {
      _startErrorText = startError;
      _endErrorText = endError;
    });
    return startError == null && endError == null;
  }

  Jalali? _parseDate(String text) {
    try {
      return utils.parseCompactDate(text);
    } catch (e) {
      return null;
    }
  }

  String? _validateDate(Jalali? date) {
    if (date == null) {
      return widget.errorFormatText ?? 'تاریخ انتخاب شده معتبر نمی باشد.';
    } else if (date.isBefore(widget.firstDate) ||
        date.isAfter(widget.lastDate)) {
      return widget.errorInvalidText ?? 'تاریخ انتخاب شده معتبر نمی باشد.';
    }
    return null;
  }

  void _updateController(
      TextEditingController controller, String? text, bool selectText) {
    TextEditingValue textEditingValue = controller.value.copyWith(text: text);
    if (selectText) {
      textEditingValue = textEditingValue.copyWith(
          selection: TextSelection(
        baseOffset: 0,
        extentOffset: text!.length,
      ));
    }
    controller.value = textEditingValue;
  }

  void _handleStartChanged(String text) {
    setState(() {
      _startInputText = text;
      _startDate = _parseDate(text);
      // ignore: avoid_print
      print(_startDate);
      widget.onStartDateChanged.call(_startDate);
    });
    if (widget.autovalidate) {
      validate();
    }
  }

  void _handleEndChanged(String text) {
    setState(() {
      _endInputText = text;
      _endDate = _parseDate(text);
      widget.onEndDateChanged.call(_endDate);
    });
    if (widget.autovalidate) {
      validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final InputDecorationTheme inputTheme =
        Theme.of(context).inputDecorationTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _startController,
            decoration: InputDecoration(
              border: inputTheme.border ?? const UnderlineInputBorder(),
              filled: inputTheme.filled,
              hintText: widget.fieldStartHintText ?? '##/##/####',
              labelText: widget.fieldStartLabelText ?? 'تاریخ شروع',
              errorText: _startErrorText,
            ),
            keyboardType: TextInputType.datetime,
            onChanged: _handleStartChanged,
            autofocus: widget.autofocus,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: _endController,
            decoration: InputDecoration(
              border: inputTheme.border ?? const UnderlineInputBorder(),
              filled: inputTheme.filled,
              hintText: widget.fieldEndHintText ?? '##/##/####',
              labelText: widget.fieldEndLabelText ?? 'تاریخ پایان',
              errorText: _endErrorText,
            ),
            keyboardType: TextInputType.datetime,
            onChanged: _handleEndChanged,
          ),
        ),
      ],
    );
  }
}
