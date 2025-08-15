//TODO:remove this file
// // Copyright 2014 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// import 'package:flutter/material.dart';

// /// An inherited widget that defines the visual properties for
// /// [PersianDatePickerDialog]s in this widget's subtree.
// ///
// /// Values specified here are used for [PersianDatePickerDialog] properties that are not
// /// given an explicit non-null value.
// class PersianDatePickerTheme extends InheritedTheme {
//   /// Creates a [PersianDatePickerTheme] that controls visual parameters for
//   /// descendent [PersianDatePickerDialog]s.
//   const PersianDatePickerTheme({
//     super.key,
//     required this.data,
//     required super.child,
//   });

//   /// Specifies the visual properties used by descendant [PersianDatePickerDialog]
//   /// widgets.
//   final DatePickerThemeData data;

//   /// The [data] from the closest instance of this class that encloses the given
//   /// context.
//   ///
//   /// If there is no [PersianDatePickerTheme] in scope, this will return
//   /// [ThemeData.datePickerTheme] from the ambient [Theme].
//   ///
//   /// Typical usage is as follows:
//   ///
//   /// ```dart
//   /// DatePickerThemeData theme = PersianDatePickerTheme.of(context);
//   /// ```
//   ///
//   /// See also:
//   ///
//   ///  * [maybeOf], which returns null if it doesn't find a
//   ///    [PersianDatePickerTheme] ancestor.
//   ///  * [defaults], which will return the default properties used when no
//   ///    other [PersianDatePickerTheme] has been provided.
//   static DatePickerThemeData of(BuildContext context) {
//     return maybeOf(context) ?? Theme.of(context).datePickerTheme;
//   }

//   /// The data from the closest instance of this class that encloses the given
//   /// context, if any.
//   ///
//   /// Use this function if you want to allow situations where no
//   /// [PersianDatePickerTheme] is in scope. Prefer using [PersianDatePickerTheme.of]
//   /// in situations where a [DatePickerThemeData] is expected to be
//   /// non-null.
//   ///
//   /// If there is no [PersianDatePickerTheme] in scope, then this function will
//   /// return null.
//   ///
//   /// Typical usage is as follows:
//   ///
//   /// ```dart
//   /// DatePickerThemeData? theme = PersianDatePickerTheme.maybeOf(context);
//   /// if (theme == null) {
//   ///   // Do something else instead.
//   /// }
//   /// ```
//   ///
//   /// See also:
//   ///
//   ///  * [of], which will return [ThemeData.datePickerTheme] if it doesn't
//   ///    find a [PersianDatePickerTheme] ancestor, instead of returning null.
//   ///  * [defaults], which will return the default properties used when no
//   ///    other [PersianDatePickerTheme] has been provided.
//   static DatePickerThemeData? maybeOf(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<PersianDatePickerTheme>()?.data;
//   }

//   /// A DatePickerThemeData used as the default properties for date pickers.
//   ///
//   /// This is only used for properties not already specified in the ambient
//   /// [PersianDatePickerTheme.of].
//   ///
//   /// See also:
//   ///
//   ///  * [of], which will return [ThemeData.datePickerTheme] if it doesn't
//   ///    find a [PersianDatePickerTheme] ancestor, instead of returning null.
//   ///  * [maybeOf], which returns null if it doesn't find a
//   ///    [PersianDatePickerTheme] ancestor.
//   static DatePickerThemeData defaults(BuildContext context) {
//     return Theme.of(context).useMaterial3
//       ? _PersianDatePickerDefaultsM3(context)
//       : _PersianDatePickerDefaultsM2(context);
//   }

//   @override
//   Widget wrap(BuildContext context, Widget child) {
//     return PersianDatePickerTheme(data: data, child: child);
//   }

//   @override
//   bool updateShouldNotify(PersianDatePickerTheme oldWidget) => data != oldWidget.data;
// }

// // Hand coded defaults based on Material Design 2.
// class _PersianDatePickerDefaultsM2 extends DatePickerThemeData {
//   _PersianDatePickerDefaultsM2(this.context)
//     : super(
//         elevation: 24.0,
//         shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
//         dayShape: const MaterialStatePropertyAll<OutlinedBorder>(CircleBorder()),
//         rangePickerElevation: 0.0,
//         rangePickerShape: const RoundedRectangleBorder(),
//       );

//   final BuildContext context;
//   late final ThemeData _theme = Theme.of(context);
//   late final ColorScheme _colors = _theme.colorScheme;
//   late final TextTheme _textTheme = _theme.textTheme;
//   late final bool _isDark = _colors.brightness == Brightness.dark;

//   @override
//   Color? get headerBackgroundColor => _isDark ? _colors.surface : _colors.primary;

//   @override
//   ButtonStyle get cancelButtonStyle {
//     return TextButton.styleFrom();
//   }

//   @override
//   ButtonStyle get confirmButtonStyle {
//     return TextButton.styleFrom();
//   }

//   @override
//   Color? get headerForegroundColor => _isDark ? _colors.onSurface : _colors.onPrimary;

//   @override
//   TextStyle? get headerHeadlineStyle => _textTheme.headlineSmall;

//   @override
//   TextStyle? get headerHelpStyle => _textTheme.labelSmall;

//   @override
//   TextStyle? get weekdayStyle => _textTheme.bodySmall?.apply(
//     color: _colors.onSurface.withOpacity(0.60),
//   );

//   @override
//   TextStyle? get dayStyle => _textTheme.bodySmall;

//   @override
//   MaterialStateProperty<Color?>? get dayForegroundColor =>
//     MaterialStateProperty.resolveWith((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         return _colors.onPrimary;
//       } else if (states.contains(MaterialState.disabled)) {
//         return _colors.onSurface.withOpacity(0.38);
//       }
//       return _colors.onSurface;
//     });

//   @override
//   MaterialStateProperty<Color?>? get dayBackgroundColor =>
//     MaterialStateProperty.resolveWith((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         return _colors.primary;
//       }
//       return null;
//     });

//   @override
//   MaterialStateProperty<Color?>? get dayOverlayColor =>
//     MaterialStateProperty.resolveWith((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         if (states.contains(MaterialState.pressed)) {
//           return _colors.onPrimary.withOpacity(0.38);
//         }
//         if (states.contains(MaterialState.hovered)) {
//           return _colors.onPrimary.withOpacity(0.08);
//         }
//         if (states.contains(MaterialState.focused)) {
//           return _colors.onPrimary.withOpacity(0.12);
//         }
//       } else {
//         if (states.contains(MaterialState.pressed)) {
//           return _colors.onSurfaceVariant.withOpacity(0.12);
//         }
//         if (states.contains(MaterialState.hovered)) {
//           return _colors.onSurfaceVariant.withOpacity(0.08);
//         }
//         if (states.contains(MaterialState.focused)) {
//           return _colors.onSurfaceVariant.withOpacity(0.12);
//         }
//       }
//       return null;
//     });

//   @override
//   MaterialStateProperty<Color?>? get todayForegroundColor =>
//     MaterialStateProperty.resolveWith((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         return _colors.onPrimary;
//       } else if (states.contains(MaterialState.disabled)) {
//         return _colors.onSurface.withOpacity(0.38);
//       }
//       return _colors.primary;
//     });

//   @override
//   MaterialStateProperty<Color?>? get todayBackgroundColor => dayBackgroundColor;

//   @override
//   BorderSide? get todayBorder => BorderSide(color: _colors.primary);

//   @override
//   TextStyle? get yearStyle => _textTheme.bodyLarge;

//   @override
//   Color? get rangePickerBackgroundColor => _colors.surface;

//   @override
//   Color? get rangePickerShadowColor => Colors.transparent;

//   @override
//   Color? get rangePickerSurfaceTintColor => Colors.transparent;

//   @override
//   Color? get rangePickerHeaderBackgroundColor => _isDark ? _colors.surface : _colors.primary;

//   @override
//   Color? get rangePickerHeaderForegroundColor => _isDark ? _colors.onSurface : _colors.onPrimary;

//   @override
//   TextStyle? get rangePickerHeaderHeadlineStyle => _textTheme.headlineSmall;

//   @override
//   TextStyle? get rangePickerHeaderHelpStyle => _textTheme.labelSmall;

//   @override
//   Color? get rangeSelectionBackgroundColor => _colors.primary.withOpacity(0.12);

//   @override
//   MaterialStateProperty<Color?>? get rangeSelectionOverlayColor =>
//     MaterialStateProperty.resolveWith((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         if (states.contains(MaterialState.pressed)) {
//           return _colors.onPrimary.withOpacity(0.38);
//         }
//         if (states.contains(MaterialState.hovered)) {
//           return _colors.onPrimary.withOpacity(0.08);
//         }
//         if (states.contains(MaterialState.focused)) {
//           return _colors.onPrimary.withOpacity(0.12);
//         }
//       } else {
//         if (states.contains(MaterialState.pressed)) {
//           return _colors.onSurfaceVariant.withOpacity(0.12);
//         }
//         if (states.contains(MaterialState.hovered)) {
//           return _colors.onSurfaceVariant.withOpacity(0.08);
//         }
//         if (states.contains(MaterialState.focused)) {
//           return _colors.onSurfaceVariant.withOpacity(0.12);
//         }
//       }
//       return null;
//     });
// }

// // BEGIN GENERATED TOKEN PROPERTIES - PersianDatePicker

// // Do not edit by hand. The code between the "BEGIN GENERATED" and
// // "END GENERATED" comments are generated from data in the Material
// // Design token database by the script:
// //   dev/tools/gen_defaults/bin/gen_defaults.dart.

// class _PersianDatePickerDefaultsM3 extends DatePickerThemeData {
//   _PersianDatePickerDefaultsM3(this.context)
//     : super(
//         elevation: 6.0,
//         shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(28.0))),
//         // TODO(tahatesser): Update this to use token when gen_defaults
//         // supports `CircleBorder` for fully rounded corners.
//         dayShape: const MaterialStatePropertyAll<OutlinedBorder>(CircleBorder()),
//         rangePickerElevation: 0.0,
//         rangePickerShape: const RoundedRectangleBorder(),
//       );

//   final BuildContext context;
//   late final ThemeData _theme = Theme.of(context);
//   late final ColorScheme _colors = _theme.colorScheme;
//   late final TextTheme _textTheme = _theme.textTheme;

//   @override
//   Color? get backgroundColor => _colors.surfaceContainerHigh;

//   @override
//   ButtonStyle get cancelButtonStyle {
//     return TextButton.styleFrom();
//   }

//   @override
//   ButtonStyle get confirmButtonStyle {
//     return TextButton.styleFrom();
//   }

//   @override
//   Color? get shadowColor => Colors.transparent;

//   @override
//   Color? get surfaceTintColor => Colors.transparent;

//   @override
//   Color? get headerBackgroundColor => Colors.transparent;

//   @override
//   Color? get headerForegroundColor => _colors.onSurfaceVariant;

//   @override
//   TextStyle? get headerHeadlineStyle => _textTheme.headlineLarge;

//   @override
//   TextStyle? get headerHelpStyle => _textTheme.labelLarge;

//   @override
//   TextStyle? get weekdayStyle => _textTheme.bodyLarge?.apply(
//     color: _colors.onSurface,
//   );

//   @override
//   TextStyle? get dayStyle => _textTheme.bodyLarge;

//   @override
//   MaterialStateProperty<Color?>? get dayForegroundColor =>
//     MaterialStateProperty.resolveWith((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         return _colors.onPrimary;
//       } else if (states.contains(MaterialState.disabled)) {
//         return _colors.onSurface.withOpacity(0.38);
//       }
//       return _colors.onSurface;
//     });

//   @override
//   MaterialStateProperty<Color?>? get dayBackgroundColor =>
//     MaterialStateProperty.resolveWith((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         return _colors.primary;
//       }
//       return null;
//     });

//   @override
//   MaterialStateProperty<Color?>? get dayOverlayColor =>
//     MaterialStateProperty.resolveWith((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         if (states.contains(MaterialState.pressed)) {
//           return _colors.onPrimary.withOpacity(0.1);
//         }
//         if (states.contains(MaterialState.hovered)) {
//           return _colors.onPrimary.withOpacity(0.08);
//         }
//         if (states.contains(MaterialState.focused)) {
//           return _colors.onPrimary.withOpacity(0.1);
//         }
//       } else {
//         if (states.contains(MaterialState.pressed)) {
//           return _colors.onSurfaceVariant.withOpacity(0.1);
//         }
//         if (states.contains(MaterialState.hovered)) {
//           return _colors.onSurfaceVariant.withOpacity(0.08);
//         }
//         if (states.contains(MaterialState.focused)) {
//           return _colors.onSurfaceVariant.withOpacity(0.1);
//         }
//       }
//       return null;
//     });

//   @override
//   MaterialStateProperty<Color?>? get todayForegroundColor =>
//     MaterialStateProperty.resolveWith((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         return _colors.onPrimary;
//       } else if (states.contains(MaterialState.disabled)) {
//         return _colors.primary.withOpacity(0.38);
//       }
//       return _colors.primary;
//     });

//   @override
//   MaterialStateProperty<Color?>? get todayBackgroundColor => dayBackgroundColor;

//   @override
//   BorderSide? get todayBorder => BorderSide(color: _colors.primary);

//   @override
//   TextStyle? get yearStyle => _textTheme.bodyLarge;

//   @override
//   MaterialStateProperty<Color?>? get yearForegroundColor =>
//     MaterialStateProperty.resolveWith((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         return _colors.onPrimary;
//       } else if (states.contains(MaterialState.disabled)) {
//         return _colors.onSurfaceVariant.withOpacity(0.38);
//       }
//       return _colors.onSurfaceVariant;
//     });

//   @override
//   MaterialStateProperty<Color?>? get yearBackgroundColor =>
//     MaterialStateProperty.resolveWith((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         return _colors.primary;
//       }
//       return null;
//     });

//   @override
//   MaterialStateProperty<Color?>? get yearOverlayColor =>
//     MaterialStateProperty.resolveWith((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         if (states.contains(MaterialState.pressed)) {
//           return _colors.onPrimary.withOpacity(0.1);
//         }
//         if (states.contains(MaterialState.hovered)) {
//           return _colors.onPrimary.withOpacity(0.08);
//         }
//         if (states.contains(MaterialState.focused)) {
//           return _colors.onPrimary.withOpacity(0.1);
//         }
//       } else {
//         if (states.contains(MaterialState.pressed)) {
//           return _colors.onSurfaceVariant.withOpacity(0.1);
//         }
//         if (states.contains(MaterialState.hovered)) {
//           return _colors.onSurfaceVariant.withOpacity(0.08);
//         }
//         if (states.contains(MaterialState.focused)) {
//           return _colors.onSurfaceVariant.withOpacity(0.1);
//         }
//       }
//       return null;
//     });

//     @override
//     Color? get rangePickerShadowColor => Colors.transparent;

//     @override
//     Color? get rangePickerSurfaceTintColor => Colors.transparent;

//     @override
//     Color? get rangeSelectionBackgroundColor => _colors.secondaryContainer;

//   @override
//   MaterialStateProperty<Color?>? get rangeSelectionOverlayColor =>
//     MaterialStateProperty.resolveWith((Set<MaterialState> states) {
//       if (states.contains(MaterialState.pressed)) {
//         return _colors.onPrimaryContainer.withOpacity(0.1);
//       }
//       if (states.contains(MaterialState.hovered)) {
//         return _colors.onPrimaryContainer.withOpacity(0.08);
//       }
//       if (states.contains(MaterialState.focused)) {
//         return _colors.onPrimaryContainer.withOpacity(0.1);
//       }
//       return null;
//     });

//   @override
//   Color? get rangePickerHeaderBackgroundColor => Colors.transparent;

//   @override
//   Color? get rangePickerHeaderForegroundColor => _colors.onSurfaceVariant;

//   @override
//   TextStyle? get rangePickerHeaderHeadlineStyle => _textTheme.titleLarge;

//   @override
//   TextStyle? get rangePickerHeaderHelpStyle => _textTheme.titleSmall;
// }

// // END GENERATED TOKEN PROPERTIES - PersianDatePicker
