import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/src/date/shamsi_date.dart';

import 'pcalendar_date_range_picker.dart';
import 'pdate_picker_common.dart';
import 'pdate_picker_header.dart';
import 'pdate_utils.dart' as utils;
import 'pinput_date_range_picker.dart';

const Size _inputPortraitDialogSize = Size(330.0, 270.0);
const Size _inputLandscapeDialogSize = Size(496, 164.0);
const Duration _dialogSizeAnimationDuration = Duration(milliseconds: 200);
const double _inputFormPortraitHeight = 98.0;
const double _inputFormLandscapeHeight = 108.0;

/// Shows a full screen modal dialog containing a Material Design date range
/// picker.
///
/// The returned [Future] resolves to the [JalaliRange] selected by the user
/// when the user saves their selection. If the user cancels the dialog, null is
/// returned.
///
/// If [initialDateRange] is non-null, then it will be used as the initially
/// selected date range. If it is provided, [initialDateRange.start] must be
/// before or on [initialDateRange.end].
///
/// The [firstDate] is the earliest allowable date. The [lastDate] is the latest
/// allowable date. Both must be non-null.
///
/// If an initial date range is provided, [initialDateRange.start]
/// and [initialDateRange.end] must both fall between or on [firstDate] and
/// [lastDate]. For all of these [Jalali] values, only their dates are
/// considered. Their time fields are ignored.
///
/// The [currentDate] represents the current day (i.e. today). This
/// date will be highlighted in the day grid. If null, the date of
/// `Jalali.now()` will be used.
///
/// An optional [initialEntryMode] argument can be used to display the date
/// picker in the [PDatePickerEntryMode.calendar] (a scrollable calendar month
/// grid) or [PDatePickerEntryMode.input] (two text input fields) mode.
/// It defaults to [PDatePickerEntryMode.calendar] and must be non-null.
///
/// The following optional string parameters allow you to override the default
/// text used for various parts of the dialog:
///
///   * [helpText], the label displayed at the top of the dialog.
///   * [cancelText], the label on the cancel button for the text input mode.
///   * [confirmText],the  label on the ok button for the text input mode.
///   * [saveText], the label on the save button for the fullscreen calendar
///     mode.
///   * [errorFormatText], the message used when an input text isn't in a proper
///     date format.
///   * [errorInvalidText], the message used when an input text isn't a
///     selectable date.
///   * [errorInvalidRangeText], the message used when the date range is
///     invalid (e.g. start date is after end date).
///   * [fieldStartHintText], the text used to prompt the user when no text has
///     been entered in the start field.
///   * [fieldEndHintText], the text used to prompt the user when no text has
///     been entered in the end field.
///   * [fieldStartLabelText], the label for the start date text input field.
///   * [fieldEndLabelText], the label for the end date text input field.
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
/// The [context], [useRootNavigator] and [routeSettings] arguments are passed
/// to [showDialog], the documentation for which discusses how it is used.
/// [context] and [useRootNavigator] must be non-null.
///
/// The [builder] parameter can be used to wrap the dialog widget
/// to add inherited widgets like [Theme].
///
/// See also:
///
///  * [showDatePicker], which shows a material design date picker used to
///    select a single date.
///  * [JalaliRange], which is used to describe a date range.
///
Future<JalaliRange?> showPersianDateRangePicker({
  required BuildContext context,
  JalaliRange? initialDateRange,
  required Jalali firstDate,
  required Jalali lastDate,
  Jalali? currentDate,
  PDatePickerEntryMode initialEntryMode = PDatePickerEntryMode.calendar,
  String? helpText,
  bool? showEntryModeIcon,
  String? cancelText,
  String? confirmText,
  String? saveText,
  String? errorFormatText,
  String? errorInvalidText,
  String? errorInvalidRangeText,
  String? fieldStartHintText,
  String? fieldEndHintText,
  String? fieldStartLabelText,
  String? fieldEndLabelText,
  Locale? locale,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  TextDirection? textDirection,
  TransitionBuilder? builder,
}) async {
  assert(context != null);
  assert(
    initialDateRange == null || (initialDateRange.start != null && initialDateRange.end != null),
    'initialDateRange must be null or have non-null start and end dates.',
  );
  assert(
    initialDateRange == null || !initialDateRange.start.isAfter(initialDateRange.end),
    "initialDateRange's start date must not be after it's end date.",
  );
  initialDateRange = initialDateRange == null ? null : utils.datesOnly(initialDateRange);
  assert(firstDate != null);
  firstDate = utils.dateOnly(firstDate);
  assert(lastDate != null);
  lastDate = utils.dateOnly(lastDate);
  assert(
    !lastDate.isBefore(firstDate),
    'lastDate $lastDate must be on or after firstDate $firstDate.',
  );
  assert(
    initialDateRange == null || !initialDateRange.start.isBefore(firstDate),
    "initialDateRange's start date must be on or after firstDate $firstDate.",
  );
  assert(
    initialDateRange == null || !initialDateRange.end.isBefore(firstDate),
    "initialDateRange's end date must be on or after firstDate $firstDate.",
  );
  assert(
    initialDateRange == null || !initialDateRange.start.isAfter(lastDate),
    "initialDateRange's start date must be on or before lastDate $lastDate.",
  );
  assert(
    initialDateRange == null || !initialDateRange.end.isAfter(lastDate),
    "initialDateRange's end date must be on or before lastDate $lastDate.",
  );
  currentDate = utils.dateOnly(currentDate ?? Jalali.now());
  assert(initialEntryMode != null);
  assert(useRootNavigator != null);

  Widget dialog = _DateRangePickerDialog(
    initialDateRange: initialDateRange,
    firstDate: firstDate,
    lastDate: lastDate,
    currentDate: currentDate,
    initialEntryMode: initialEntryMode,
    helpText: helpText,
    showEntryModeIcon: showEntryModeIcon,
    cancelText: cancelText,
    confirmText: confirmText,
    saveText: saveText,
    errorFormatText: errorFormatText,
    errorInvalidText: errorInvalidText,
    errorInvalidRangeText: errorInvalidRangeText,
    fieldStartHintText: fieldStartHintText,
    fieldEndHintText: fieldEndHintText,
    fieldStartLabelText: fieldStartLabelText,
    fieldEndLabelText: fieldEndLabelText,
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

  return showDialog<JalaliRange>(
    context: context,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    useSafeArea: false,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
  );
}

class _DateRangePickerDialog extends StatefulWidget {
  const _DateRangePickerDialog({
    Key? key,
    this.initialDateRange,
    required this.firstDate,
    required this.lastDate,
    this.currentDate,
    this.initialEntryMode = PDatePickerEntryMode.calendar,
    this.helpText,
    this.showEntryModeIcon,
    this.cancelText,
    this.confirmText,
    this.saveText,
    this.errorInvalidRangeText,
    this.errorFormatText,
    this.errorInvalidText,
    this.fieldStartHintText,
    this.fieldEndHintText,
    this.fieldStartLabelText,
    this.fieldEndLabelText,
  }) : super(key: key);

  final JalaliRange? initialDateRange;
  final Jalali firstDate;
  final Jalali lastDate;
  final Jalali? currentDate;
  final PDatePickerEntryMode initialEntryMode;
  final String? cancelText;
  final String? confirmText;
  final String? saveText;
  final String? helpText;
  final bool? showEntryModeIcon;
  final String? errorInvalidRangeText;
  final String? errorFormatText;
  final String? errorInvalidText;
  final String? fieldStartHintText;
  final String? fieldEndHintText;
  final String? fieldStartLabelText;
  final String? fieldEndLabelText;

  @override
  _DateRangePickerDialogState createState() => _DateRangePickerDialogState();
}

class _DateRangePickerDialogState extends State<_DateRangePickerDialog> {
  PDatePickerEntryMode? _entryMode;
  Jalali? _selectedStart;
  Jalali? _selectedEnd;
  late bool _autoValidate;
  final GlobalKey _calendarPickerKey = GlobalKey();
  final GlobalKey<PInputDateRangePickerState> _inputPickerKey =
      GlobalKey<PInputDateRangePickerState>();

  @override
  void initState() {
    super.initState();
    _selectedStart = widget.initialDateRange?.start;
    _selectedEnd = widget.initialDateRange?.end;
    _entryMode = widget.initialEntryMode;
    _autoValidate = false;
  }

  void _handleOk() {
    if (_entryMode == PDatePickerEntryMode.input) {
      final PInputDateRangePickerState picker = _inputPickerKey.currentState!;
      if (!picker.validate()) {
        setState(() {
          _autoValidate = true;
        });
        return;
      }
    }
    final JalaliRange? selectedRange = _hasSelectedDateRange
        ? JalaliRange(start: _selectedStart!, end: _selectedEnd!)
        : null;

    Navigator.pop(context, selectedRange);
  }

  void _handleCancel() {
    Navigator.pop(context);
  }

  void _handleEntryModeToggle() {
    setState(() {
      switch (_entryMode) {
        case PDatePickerEntryMode.calendar:
          _autoValidate = false;
          _entryMode = PDatePickerEntryMode.input;
          break;

        case PDatePickerEntryMode.input:
          // If invalid range (start after end), then just use the start date
          if (_selectedStart != null &&
              _selectedEnd != null &&
              _selectedStart!.isAfter(_selectedEnd!)) {
            _selectedEnd = null;
          }
          _entryMode = PDatePickerEntryMode.calendar;
          break;
        default:
          break;
      }
    });
  }

  void _handleStartDateChanged(Jalali? date) {
    setState(() => _selectedStart = date);
  }

  void _handleEndDateChanged(Jalali? date) {
    setState(() => _selectedEnd = date);
  }

  bool get _hasSelectedDateRange =>
      _selectedStart != null && _selectedEnd != null;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Orientation orientation = mediaQuery.orientation;
    final double textScaleFactor = math.min(mediaQuery.textScaleFactor, 1.3);

    late Widget contents;
    late Size size;
    ShapeBorder? shape;
    double? elevation;
    EdgeInsets? insetPadding;
    switch (_entryMode) {
      case PDatePickerEntryMode.calendar:
        contents = _CalendarRangePickerDialog(
          key: _calendarPickerKey,
          selectedStartDate: _selectedStart,
          selectedEndDate: _selectedEnd,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          currentDate: widget.currentDate,
          onStartDateChanged: _handleStartDateChanged,
          onEndDateChanged: _handleEndDateChanged,
          onConfirm: _hasSelectedDateRange ? _handleOk : null,
          onCancel: _handleCancel,
          onToggleEntryMode: _handleEntryModeToggle,
          confirmText: widget.saveText ?? "تایید",
          helpText: widget.helpText ?? "انتخاب تاریخ",
          showEntryModeIcon: widget.showEntryModeIcon ?? true,
        );
        size = mediaQuery.size;
        insetPadding = const EdgeInsets.all(0.0);
        shape = const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero));
        elevation = 0;
        break;

      case PDatePickerEntryMode.input:
        contents = _PInputDateRangePickerDialog(
          selectedStartDate: _selectedStart,
          selectedEndDate: _selectedEnd,
          currentDate: widget.currentDate,
          picker: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: orientation == Orientation.portrait
                ? _inputFormPortraitHeight
                : _inputFormLandscapeHeight,
            child: Column(
              children: <Widget>[
                const Spacer(),
                PInputDateRangePicker(
                  key: _inputPickerKey,
                  initialStartDate: _selectedStart,
                  initialEndDate: _selectedEnd,
                  firstDate: widget.firstDate,
                  lastDate: widget.lastDate,
                  onStartDateChanged: _handleStartDateChanged,
                  onEndDateChanged: _handleEndDateChanged,
                  autofocus: true,
                  autovalidate: _autoValidate,
                  helpText: widget.helpText,
                  errorInvalidRangeText: widget.errorInvalidRangeText,
                  errorFormatText: widget.errorFormatText,
                  errorInvalidText: widget.errorInvalidText,
                  fieldStartHintText: widget.fieldStartHintText,
                  fieldEndHintText: widget.fieldEndHintText,
                  fieldStartLabelText: widget.fieldStartLabelText,
                  fieldEndLabelText: widget.fieldEndLabelText,
                ),
                const Spacer(),
              ],
            ),
          ),
          onConfirm: _handleOk,
          onCancel: _handleCancel,
          onToggleEntryMode: _handleEntryModeToggle,
          confirmText: widget.confirmText ?? 'تایید',
          cancelText: widget.cancelText ?? 'لغو',
          helpText: widget.helpText ?? 'انتخاب تاریخ',
        );
        final DialogTheme dialogTheme = Theme.of(context).dialogTheme;
        size = orientation == Orientation.portrait
            ? _inputPortraitDialogSize
            : _inputLandscapeDialogSize;
        insetPadding =
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0);
        shape = dialogTheme.shape;
        elevation = dialogTheme.elevation ?? 24;
        break;
      default:
        break;
    }

    return Dialog(
      insetPadding: insetPadding,
      shape: shape,
      elevation: elevation,
      clipBehavior: Clip.antiAlias,
      child: AnimatedContainer(
        width: size.width,
        height: size.height,
        duration: _dialogSizeAnimationDuration,
        curve: Curves.easeIn,
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: textScaleFactor,
          ),
          child: Builder(builder: (BuildContext context) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: contents,
            );
          }),
        ),
      ),
    );
  }
}

class _CalendarRangePickerDialog extends StatelessWidget {
  const _CalendarRangePickerDialog({
    Key? key,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.firstDate,
    required this.lastDate,
    required this.currentDate,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
    required this.onConfirm,
    required this.onCancel,
    required this.onToggleEntryMode,
    required this.confirmText,
    required this.helpText,
    required this.showEntryModeIcon,
  }) : super(key: key);

  final Jalali? selectedStartDate;
  final Jalali? selectedEndDate;
  final Jalali firstDate;
  final Jalali lastDate;
  final Jalali? currentDate;
  final ValueChanged<Jalali?> onStartDateChanged;
  final ValueChanged<Jalali?> onEndDateChanged;
  final VoidCallback? onConfirm;
  final VoidCallback onCancel;
  final VoidCallback onToggleEntryMode;
  final String confirmText;
  final String helpText;
  final bool showEntryModeIcon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final Orientation orientation = MediaQuery.of(context).orientation;
    final TextTheme textTheme = theme.textTheme;
    final Color headerForeground = colorScheme.brightness == Brightness.light
        ? colorScheme.onPrimary
        : colorScheme.onSurface;
    final Color headerDisabledForeground = headerForeground.withOpacity(0.38);
    final String startDateText = utils.formatRangeStartDate(
        localizations, selectedStartDate, selectedEndDate);
    final String endDateText = utils.formatRangeEndDate(
        localizations, selectedStartDate, selectedEndDate, Jalali.now());
    final TextStyle? headlineStyle = textTheme.titleLarge;
    final TextStyle? startDateStyle = headlineStyle?.apply(
        color: selectedStartDate != null
            ? headerForeground
            : headerDisabledForeground);
    final TextStyle? endDateStyle = headlineStyle?.apply(
        color: selectedEndDate != null
            ? headerForeground
            : headerDisabledForeground);
    final TextStyle saveButtonStyle = textTheme.labelLarge!.apply(
        color: onConfirm != null ? headerForeground : headerDisabledForeground);

    final IconButton entryModeIcon = IconButton(
      padding: EdgeInsets.zero,
      color: headerForeground,
      icon: const Icon(Icons.edit),
      tooltip: 'ورود تاریخ',
      onPressed: onToggleEntryMode,
    );

    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: Scaffold(
        appBar: AppBar(
          leading: CloseButton(
            onPressed: onCancel,
          ),
          actions: <Widget>[
            if (orientation == Orientation.landscape) entryModeIcon,
            ButtonTheme(
              minWidth: 64,
              child: TextButton(
                onPressed: onConfirm,
                child: Text(confirmText, style: saveButtonStyle),
              ),
            ),
            const SizedBox(width: 8),
          ],
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 64),
            child: Row(children: <Widget>[
              SizedBox(
                  width: MediaQuery.of(context).size.width < 360 ? 42 : 72),
              Expanded(
                child: Semantics(
                  label: '$helpText $startDateText to $endDateText',
                  excludeSemantics: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        helpText,
                        style: textTheme.labelSmall!.apply(
                          color: headerForeground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          Text(
                            startDateText,
                            style: startDateStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            ' – ',
                            style: startDateStyle,
                          ),
                          Flexible(
                            child: Text(
                              endDateText,
                              style: endDateStyle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              if (showEntryModeIcon && orientation == Orientation.portrait)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: entryModeIcon,
                ),
            ]),
          ),
        ),
        body: PCalendarDateRangePicker(
          initialStartDate: selectedStartDate,
          initialEndDate: selectedEndDate,
          firstDate: firstDate,
          lastDate: lastDate,
          currentDate: currentDate,
          onStartDateChanged: onStartDateChanged,
          onEndDateChanged: onEndDateChanged,
        ),
      ),
    );
  }
}

class _PInputDateRangePickerDialog extends StatelessWidget {
  const _PInputDateRangePickerDialog({
    Key? key,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.currentDate,
    required this.picker,
    required this.onConfirm,
    required this.onCancel,
    required this.onToggleEntryMode,
    required this.confirmText,
    required this.cancelText,
    required this.helpText,
  }) : super(key: key);

  final Jalali? selectedStartDate;
  final Jalali? selectedEndDate;
  final Jalali? currentDate;
  final Widget picker;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final VoidCallback onToggleEntryMode;
  final String confirmText;
  final String cancelText;
  final String helpText;

  String _formatDateRange(
      BuildContext context, Jalali? start, Jalali? end, Jalali? now) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final String startText =
        utils.formatRangeStartDate(localizations, start, end);
    final String endText =
        utils.formatRangeEndDate(localizations, start, end, now);
    if (start == null || end == null) {
      return localizations.unspecifiedDateRange;
    }
    if (Directionality.of(context) == TextDirection.ltr) {
      return '$startText – $endText';
    } else {
      return '$endText – $startText';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final Orientation orientation = MediaQuery.of(context).orientation;
    final TextTheme textTheme = theme.textTheme;

    final Color dateColor = colorScheme.brightness == Brightness.light
        ? colorScheme.onPrimary
        : colorScheme.onSurface;
    final TextStyle? dateStyle = orientation == Orientation.landscape
        ? textTheme.titleMedium?.apply(color: dateColor)
        : textTheme.headlineSmall?.apply(color: dateColor);
    final String dateText = _formatDateRange(
        context, selectedStartDate, selectedEndDate, currentDate);
    final String semanticDateText = selectedStartDate != null &&
            selectedEndDate != null
        ? '${selectedStartDate!.formatMediumDate()} – ${selectedEndDate!.formatMediumDate()}'
        : '';

    final Widget header = PDatePickerHeader(
      helpText: helpText,
      titleText: dateText,
      titleSemanticsLabel: semanticDateText,
      titleStyle: dateStyle,
      orientation: orientation,
      isShort: orientation == Orientation.landscape,
      icon: Icons.calendar_today,
      iconTooltip: 'انتخاب تاریخ',
      onIconPressed: onToggleEntryMode,
    );

    final Widget actions = Container(
      alignment: AlignmentDirectional.centerEnd,
      constraints: const BoxConstraints(minHeight: 52.0),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: OverflowBar(
        spacing: 8,
        children: <Widget>[
          TextButton(
            onPressed: onCancel,
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: onConfirm,
            child: Text(confirmText),
          ),
        ],
      ),
    );

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
  }
}
