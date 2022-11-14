// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/src/date/shamsi_date.dart';

import 'pdate_picker_common.dart';
import 'pdate_utils.dart' as utils;
import 'pdate_utils.dart';

const double _inputPortraitHeight = 98.0;
const double _inputLandscapeHeight = 108.0;

class PInputDatePickerFormField extends StatefulWidget {
  /// Creates a [TextFormField] configured to accept and validate a date.
  ///
  /// If the optional [initialDate] is provided, then it will be used to populate
  /// the text field. If the [fieldHintText] is provided, it will be shown.
  ///
  /// If [initialDate] is provided, it must not be before [firstDate] or after
  /// [lastDate]. If [selectableDayPredicate] is provided, it must return `true`
  /// for [initialDate].
  ///
  /// [firstDate] must be on or before [lastDate].
  ///
  /// [firstDate], [lastDate], and [autofocus] must be non-null.
  ///
  PInputDatePickerFormField({
    Key? key,
    Jalali? initialDate,
    required Jalali firstDate,
    required Jalali lastDate,
    this.onDateSubmitted,
    this.onDateSaved,
    this.selectableDayPredicate,
    this.errorFormatText,
    this.errorInvalidText,
    this.fieldHintText,
    this.fieldLabelText,
    this.autofocus = false,
  })  : initialDate = initialDate != null ? utils.dateOnly(initialDate) : null,
        firstDate = utils.dateOnly(firstDate),
        lastDate = utils.dateOnly(lastDate),
        super(key: key) {
    assert(!this.lastDate.isBefore(this.firstDate),
        'lastDate ${this.lastDate} must be on or after firstDate ${this.firstDate}.');
    assert(initialDate == null || !this.initialDate!.isBefore(this.firstDate),
        'initialDate ${this.initialDate} must be on or after firstDate ${this.firstDate}.');
    assert(initialDate == null || !this.initialDate!.isAfter(this.lastDate),
        'initialDate ${this.initialDate} must be on or before lastDate ${this.lastDate}.');
    assert(
        selectableDayPredicate == null ||
            initialDate == null ||
            selectableDayPredicate!(this.initialDate),
        'Provided initialDate ${this.initialDate} must satisfy provided selectableDayPredicate.');
  }

  /// If provided, it will be used as the default value of the field.
  final Jalali? initialDate;

  /// The earliest allowable [Jalali] that the user can input.
  final Jalali firstDate;

  /// The latest allowable [Jalali] that the user can input.
  final Jalali lastDate;

  /// An optional method to call when the user indicates they are done editing
  /// the text in the field. Will only be called if the input represents a valid
  /// [Jalali].
  final ValueChanged<Jalali?>? onDateSubmitted;

  /// An optional method to call with the final date when the form is
  /// saved via [FormState.save]. Will only be called if the input represents
  /// a valid [Jalali].
  final ValueChanged<Jalali?>? onDateSaved;

  /// Function to provide full control over which [Jalali] can be selected.
  final PSelectableDayPredicate? selectableDayPredicate;

  /// The error text displayed if the entered date is not in the correct format.
  final String? errorFormatText;

  /// The error text displayed if the date is not valid.
  ///
  /// A date is not valid if it is earlier than [firstDate], later than
  /// [lastDate], or doesn't pass the [selectableDayPredicate].
  final String? errorInvalidText;

  /// The hint text displayed in the [TextField].
  ///
  /// If this is null, it will default to the date format string. For example,
  /// 'mm/dd/yyyy' for en_US.
  final String? fieldHintText;

  /// The label text displayed in the [TextField].
  ///
  /// If this is null, it will default to the words representing the date format
  /// string. For example, 'Month, Day, Year' for en_US.
  final String? fieldLabelText;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  @override
  State<PInputDatePickerFormField> createState() =>
      _InputDatePickerFormFieldState();
}

class _InputDatePickerFormFieldState extends State<PInputDatePickerFormField> {
  final TextEditingController _controller = TextEditingController();
  Jalali? _selectedDate;
  String? _inputText;
  bool _autoSelected = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_selectedDate != null) {
      _inputText = _selectedDate!.formatCompactDate();
      TextEditingValue textEditingValue =
          _controller.value.copyWith(text: _inputText);
      // Select the new text if we are auto focused and haven't selected the text before.
      if (widget.autofocus && !_autoSelected) {
        textEditingValue = textEditingValue.copyWith(
            selection: TextSelection(
          baseOffset: 0,
          extentOffset: _inputText!.length,
        ));
        _autoSelected = true;
      }
      _controller.value = textEditingValue;
      _controller.text = _inputText!;
    }
  }

  Jalali? _parseDate(String text) {
    try {
      return parseCompactDate(text);
    } catch (e) {
      return null;
    }
  }

  bool _isValidAcceptableDate(Jalali? date) {
    return date != null &&
        !date.isBefore(widget.firstDate) &&
        !date.isAfter(widget.lastDate) &&
        (widget.selectableDayPredicate == null ||
            widget.selectableDayPredicate!(date));
  }

  String? _validateDate(String? text) {
    final Jalali? date = _parseDate(text!);
    if (date == null) {
      // TODO(darrenaustin): localize 'Invalid format.'
      return widget.errorFormatText ?? 'Invalid format.';
    } else if (!_isValidAcceptableDate(date)) {
      // TODO(darrenaustin): localize 'Out of range.'
      return widget.errorInvalidText ?? 'Out of range.';
    }
    return null;
  }

  void _handleSaved(String? text) {
    if (widget.onDateSaved != null) {
      final Jalali? date = _parseDate(text!);
      if (_isValidAcceptableDate(date)) {
        _selectedDate = date;
        _inputText = text;
        widget.onDateSaved!(date);
      }
    }
  }

  void _handleSubmitted(String text) {
    if (widget.onDateSubmitted != null) {
      final Jalali? date = _parseDate(text);
      if (_isValidAcceptableDate(date)) {
        _selectedDate = date;
        _inputText = text;
        widget.onDateSubmitted!(date);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: orientation == Orientation.portrait
            ? _inputPortraitHeight
            : _inputLandscapeHeight,
        child: Column(
          children: <Widget>[
            const Spacer(),
            TextFormField(
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                filled: true,
                // TODO(darrenaustin): localize 'mm/dd/yyyy' and 'Enter Date'
                hintText: widget.fieldHintText ?? 'mm/dd/yyyy',
                labelText: widget.fieldLabelText ?? 'Enter Date',
              ),
              validator: _validateDate,
              // inputFormatters: <TextInputFormatter>[
              //   // TODO(darrenaustin): localize date separator '/'
              //   _DateTextInputFormatter('/'),
              // ],
              keyboardType: TextInputType.text,
              onSaved: _handleSaved,
              onFieldSubmitted: _handleSubmitted,
              autofocus: widget.autofocus,
              controller: _controller,
            ),
            const Spacer(),
          ],
        ),
      );
    });
  }
}

// class _DateTextInputFormatter extends TextInputFormatter {
//   _DateTextInputFormatter(this.separator);

//   final String separator;

//   final FilteringTextInputFormatter _filterFormatter =
//       // Only allow digits and separators (slash, dot, comma, hyphen, space).
//       FilteringTextInputFormatter.allow(RegExp(r'[\d\/\.,-\s]+'));

//   @override
//   TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
//     final TextEditingValue filteredValue = _filterFormatter.formatEditUpdate(oldValue, newValue);
//     return filteredValue.copyWith(
//       // Replace any separator character with the given separator
//       text: filteredValue.text.replaceAll(RegExp(r'[\D]'), separator),
//     );
//   }
// }
