// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/src/date/shamsi_date.dart';

import 'pcalendar_date_picker.dart';
import 'pdate_picker_common.dart';
import 'pdate_picker_header.dart';
import 'pdate_utils.dart' as utils;
import 'pinput_date_picker.dart';

const Size _calendarPortraitDialogSize = Size(330.0, 518.0);
const Size _calendarLandscapeDialogSize = Size(496.0, 346.0);
const Size _inputPortraitDialogSize = Size(330.0, 270.0);
const Size _inputLandscapeDialogSize = Size(496, 160.0);
const Duration _dialogSizeAnimationDuration = Duration(milliseconds: 200);

/// Shows a dialog containing a Material Design date picker.
///
/// The returned [Future] resolves to the date selected by the user when the
/// user confirms the dialog. If the user cancels the dialog, null is returned.
///
/// When the date picker is first displayed, it will show the month of
/// [initialDate], with [initialDate] selected.
///
/// The [firstDate] is the earliest allowable date. The [lastDate] is the latest
/// allowable date. [initialDate] must either fall between these dates,
/// or be equal to one of them. For each of these [Jalali] parameters, only
/// their dates are considered. Their time fields are ignored. They must all
/// be non-null.
///
/// An optional [initialEntryMode] argument can be used to display the date
/// picker in the [PDatePickerEntryMode.calendar] (a calendar month grid)
/// or [PDatePickerEntryMode.input] (a text input field) mode.
/// It defaults to [PDatePickerEntryMode.calendar] and must be non-null.
///
/// An optional [selectableDayPredicate] function can be passed in to only allow
/// certain days for selection. If provided, only the days that
/// [selectableDayPredicate] returns true for will be selectable. For example,
/// this can be used to only allow weekdays for selection. If provided, it must
/// return true for [initialDate].
///
/// Optional strings for the [cancelText], [confirmText], [errorFormatText],
/// [errorInvalidText], [fieldHintText], [fieldLabelText], and [helpText] allow
/// you to override the default text used for various parts of the dialog:
///
///   * [cancelText], label on the cancel button.
///   * [confirmText], label on the ok button.
///   * [errorFormatText], message used when the input text isn't in a proper date format.
///   * [errorInvalidText], message used when the input text isn't a selectable date.
///   * [fieldHintText], text used to prompt the user when no text has been entered in the field.
///   * [fieldLabelText], label for the date text input field.
///   * [helpText], label on the top of the dialog.
///
/// An optional [locale] argument can be used to set the locale for the date
/// picker. It defaults to the ambient locale provided by [Localizations].
///
/// An optional [textDirection] argument can be used to set the text direction
/// ([TextDirection.ltr] or [TextDirection.rtl]) for the date picker. It
/// defaults to the ambient text direction provided by [Directionality]. If both
/// [locale] and [textDirection] are non-null, [textDirection] overrides the
/// direction chosen for the [locale].
///
/// The [context], [useRootNavigator] and [routeSettings] arguments are passed to
/// [showDialog], the documentation for which discusses how it is used. [context]
/// and [useRootNavigator] must be non-null.
///
/// The [builder] parameter can be used to wrap the dialog widget
/// to add inherited widgets like [Theme].
///
/// An optional [initialDatePickerMode] argument can be used to have the
/// calendar date picker initially appear in the [DatePickerMode.year] or
/// [DatePickerMode.day] mode. It defaults to [DatePickerMode.day], and
/// must be non-null.
Future<Jalali?> showPersianDatePicker({
  required BuildContext context,
  required Jalali initialDate,
  required Jalali firstDate,
  required Jalali lastDate,
  PDatePickerEntryMode initialEntryMode = PDatePickerEntryMode.calendar,
  PSelectableDayPredicate? selectableDayPredicate,
  String? helpText,
  String? cancelText,
  String? confirmText,
  Locale? locale,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  TextDirection? textDirection,
  TransitionBuilder? builder,
  PDatePickerMode initialDatePickerMode = PDatePickerMode.day,
  String? errorFormatText,
  String? errorInvalidText,
  String fieldHintText = '##/##/####',
  String fieldLabelText = 'ورود تاریخ',
}) async {
  initialDate = utils.dateOnly(initialDate);
  firstDate = utils.dateOnly(firstDate);
  lastDate = utils.dateOnly(lastDate);
  assert(!lastDate.isBefore(firstDate),
      'lastDate $lastDate must be on or after firstDate $firstDate.');
  assert(!initialDate.isBefore(firstDate),
      'initialDate $initialDate must be on or after firstDate $firstDate.');
  assert(!initialDate.isAfter(lastDate),
      'initialDate $initialDate must be on or before lastDate $lastDate.');
  assert(selectableDayPredicate == null || selectableDayPredicate(initialDate),
      'Provided initialDate $initialDate must satisfy provided selectableDayPredicate.');
  assert(debugCheckHasMaterialLocalizations(context));

  Widget dialog = _DatePickerDialog(
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    initialEntryMode: initialEntryMode,
    selectableDayPredicate: selectableDayPredicate,
    helpText: helpText,
    cancelText: cancelText,
    confirmText: confirmText,
    initialCalendarMode: initialDatePickerMode,
    errorFormatText: errorFormatText,
    errorInvalidText: errorInvalidText,
    fieldHintText: fieldHintText,
    fieldLabelText: fieldLabelText,
  );

  if (textDirection != null) {
    dialog = Directionality(
      textDirection: textDirection,
      child: dialog,
    );
  }

  if (locale != null) {
    dialog = Localizations.override(
      context: context,
      locale: locale,
      child: dialog,
    );
  }

  return showDialog<Jalali>(
    context: context,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
  );
}

class _DatePickerDialog extends StatefulWidget {
  _DatePickerDialog({
    Key? key,
    required Jalali initialDate,
    required Jalali firstDate,
    required Jalali lastDate,
    this.initialEntryMode = PDatePickerEntryMode.calendar,
    this.selectableDayPredicate,
    this.cancelText,
    this.confirmText,
    this.helpText,
    this.initialCalendarMode = PDatePickerMode.day,
    this.errorFormatText,
    this.errorInvalidText,
    this.fieldHintText,
    this.fieldLabelText,
  })  : initialDate = utils.dateOnly(initialDate),
        firstDate = utils.dateOnly(firstDate),
        lastDate = utils.dateOnly(lastDate),
        super(key: key) {
    assert(!this.lastDate.isBefore(this.firstDate),
        'lastDate ${this.lastDate} must be on or after firstDate ${this.firstDate}.');
    assert(!this.initialDate.isBefore(this.firstDate),
        'initialDate ${this.initialDate} must be on or after firstDate ${this.firstDate}.');
    assert(!this.initialDate.isAfter(this.lastDate),
        'initialDate ${this.initialDate} must be on or before lastDate ${this.lastDate}.');
    assert(
        selectableDayPredicate == null ||
            selectableDayPredicate!(this.initialDate),
        'Provided initialDate ${this.initialDate} must satisfy provided selectableDayPredicate');
  }

  /// The initially selected [Jalali] that the picker should display.
  final Jalali initialDate;

  /// The earliest allowable [Jalali] that the user can select.
  final Jalali firstDate;

  /// The latest allowable [Jalali] that the user can select.
  final Jalali lastDate;

  final PDatePickerEntryMode initialEntryMode;

  /// Function to provide full control over which [Jalali] can be selected.
  final PSelectableDayPredicate? selectableDayPredicate;

  /// The text that is displayed on the cancel button.
  final String? cancelText;

  /// The text that is displayed on the confirm button.
  final String? confirmText;

  /// The text that is displayed at the top of the header.
  ///
  /// This is used to indicate to the user what they are selecting a date for.
  final String? helpText;

  /// The initial display of the calendar picker.
  final PDatePickerMode initialCalendarMode;

  final String? errorFormatText;

  final String? errorInvalidText;

  final String? fieldHintText;

  final String? fieldLabelText;

  @override
  _DatePickerDialogState createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<_DatePickerDialog> {
  PDatePickerEntryMode? _entryMode;
  Jalali? _selectedDate;
  late bool _autoValidate;
  final GlobalKey _calendarPickerKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _entryMode = widget.initialEntryMode;
    _selectedDate = widget.initialDate;
    _autoValidate = false;
  }

  void _handleOk() {
    if (_entryMode == PDatePickerEntryMode.input ||  _entryMode == DatePickerEntryMode.inputOnly) {
      final FormState form = _formKey.currentState!;
      if (!form.validate()) {
        setState(() => _autoValidate = true);
        return;
      }
      form.save();
    }
    Navigator.pop(context, _selectedDate);
  }

  void _handleCancel() {
    Navigator.pop(context);
  }

  void _handelEntryModeToggle() {
    setState(() {
      switch (_entryMode) {
        case PDatePickerEntryMode.calendar:
          _autoValidate = false;
          _entryMode = PDatePickerEntryMode.input;
          break;
        case PDatePickerEntryMode.input:
          _formKey.currentState!.save();
          _entryMode = PDatePickerEntryMode.calendar;
          break;
        case PDatePickerEntryMode.calendarOnly:
        case PDatePickerEntryMode.inputOnly:
        default:
          assert(false, 'Can not change entry mode from _entryMode');
          break;
      }
    });
  }

  void _handleDateChanged(Jalali? date) {
    setState(() => _selectedDate = date);
  }

  Size? _dialogSize(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    switch (_entryMode) {
      case PDatePickerEntryMode.calendar:
      case PDatePickerEntryMode.calendarOnly:
        switch (orientation) {
          case Orientation.portrait:
            return _calendarPortraitDialogSize;
          case Orientation.landscape:
            return _calendarLandscapeDialogSize;
        }
      case PDatePickerEntryMode.input:
      case PDatePickerEntryMode.inputOnly:
        switch (orientation) {
          case Orientation.portrait:
            return _inputPortraitDialogSize;
          case Orientation.landscape:
            return _inputLandscapeDialogSize;
        }
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final Orientation orientation = MediaQuery.of(context).orientation;
    final TextTheme textTheme = theme.textTheme;
    // Constrain the textScaleFactor to the largest supported value to prevent
    // layout issues.
    final double textScaleFactor =
        math.min(MediaQuery.of(context).textScaleFactor, 1.3);

    final String dateText = _selectedDate != null
        ? _selectedDate!.formatMediumDate()
        // TODO(darrenaustin): localize 'Date'
        : 'Date';
    final Color dateColor = colorScheme.brightness == Brightness.light
        ? colorScheme.onPrimary
        : colorScheme.onSurface;
    final TextStyle? dateStyle = orientation == Orientation.landscape
        ? textTheme.titleMedium?.copyWith(color: dateColor)
        : textTheme.headlineSmall?.copyWith(color: dateColor);

    final Widget actions = ButtonBar(
      buttonTextTheme: ButtonTextTheme.primary,
      layoutBehavior: ButtonBarLayoutBehavior.constrained,
      children: <Widget>[
        TextButton(
          onPressed: _handleCancel,
          child: Text(widget.cancelText ?? 'لغو'),
        ),
        TextButton(
          onPressed: _handleOk,
          child: Text(widget.confirmText ?? 'تایید'),
        ),
      ],
    );

    PCalendarDatePicker pCalendarDatePicker () {
      return PCalendarDatePicker(
        key: _calendarPickerKey,
        initialDate: _selectedDate!,
        firstDate: widget.firstDate,
        lastDate: widget.lastDate,
        onDateChanged: _handleDateChanged,
        selectableDayPredicate: widget.selectableDayPredicate,
        initialCalendarMode: widget.initialCalendarMode,
      );
    }

    PInputDatePickerFormField pInputDatePickerFormField() {
      return PInputDatePickerFormField(
        initialDate: _selectedDate,
        firstDate: widget.firstDate,
        lastDate: widget.lastDate,
        onDateSubmitted: _handleDateChanged,
        onDateSaved: _handleDateChanged,
        selectableDayPredicate: widget.selectableDayPredicate,
        errorFormatText: widget.errorFormatText,
        errorInvalidText: widget.errorInvalidText,
        fieldHintText: widget.fieldHintText,
        fieldLabelText: widget.fieldLabelText,
        autofocus: true,
      );
    }

    late Widget picker;
    IconData? entryModeIcon;
    String? entryModeTooltip;
    switch (_entryMode) {
      case PDatePickerEntryMode.calendar:
        picker = pCalendarDatePicker();
        entryModeIcon = Icons.edit;
        // TODO(darrenaustin): localize 'Switch to input'
        entryModeTooltip = 'Switch to input';
        break;

      case PDatePickerEntryMode.calendarOnly:
        picker = pCalendarDatePicker();
        // TODO(darrenaustin): localize 'Switch to calendarOnly'
        entryModeIcon = null;
        entryModeTooltip = null;
        break;

      case PDatePickerEntryMode.input:
        picker = Form(
          key: _formKey,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: pInputDatePickerFormField(),
        );
        entryModeIcon = Icons.calendar_today;
        // TODO(darrenaustin): localize 'Switch to calendar'
        entryModeTooltip = 'Switch to calendar';
        break;

      case PDatePickerEntryMode.inputOnly:
        picker = Form(
          key: _formKey,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: pInputDatePickerFormField(),
        );
        // TODO(darrenaustin): localize 'Switch to calendar'
        break;
      default:
        break;
    }

    final Widget header = PDatePickerHeader(
      // TODO(darrenaustin): localize 'SELECT DATE'
      helpText: widget.helpText ?? 'انتخاب تاریخ',
      titleText: dateText,
      titleStyle: dateStyle,
      orientation: orientation,
      isShort: orientation == Orientation.landscape,
      icon: entryModeIcon,
      iconTooltip: entryModeTooltip,
      onIconPressed: _handelEntryModeToggle,
    );

    final Size dialogSize = _dialogSize(context)! * textScaleFactor;
    final DialogTheme dialogTheme = Theme.of(context).dialogTheme;
    return Dialog(
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      // The default dialog shape is radius 2 rounded rect, but the spec has
      // been updated to 4, so we will use that here for the Date Picker, but
      // only if there isn't one provided in the theme.
      shape: dialogTheme.shape ??
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
      clipBehavior: Clip.antiAlias,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: AnimatedContainer(
          width: dialogSize.width,
          height: dialogSize.height,
          duration: _dialogSizeAnimationDuration,
          curve: Curves.easeIn,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: textScaleFactor,
            ),
            child: Builder(builder: (BuildContext context) {
              switch (orientation) {
                case Orientation.portrait:
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      header,
                      Expanded(child: picker),
                      actions,
                    ],
                  );
                case Orientation.landscape:
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      header,
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(child: picker),
                            actions,
                          ],
                        ),
                      ),
                    ],
                  );
              }
            }),
          ),
        ),
      ),
    );
  }
}
