
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'date.dart';
import 'package:shamsi_date/shamsi_date.dart';

/// A [RestorableValue] that knows how to save and restore [Jalali].
///
/// {@macro flutter.widgets.RestorableNum}.
class RestorableJalali extends RestorableValue<Jalali> {
  /// Creates a [RestorableJalali].
  ///
  /// {@macro flutter.widgets.RestorableNum.constructor}
  RestorableJalali(Jalali defaultValue) : _defaultValue = defaultValue;

  final Jalali _defaultValue;

  @override
  Jalali createDefaultValue() => _defaultValue;

  @override
  void didUpdateValue(Jalali? oldValue) {
    assert(debugIsSerializableForRestoration(value.millisecondsSinceEpoch));
    notifyListeners();
  }

  @override
  Jalali fromPrimitives(Object? data) => Jalali.fromMillisecondsSinceEpoch(data! as int);

  @override
  Object? toPrimitives() => value.millisecondsSinceEpoch;
}

/// A [RestorableValue] that knows how to save and restore [Jalali] that is
/// nullable.
///
/// {@macro flutter.widgets.RestorableNum}.
class RestorableJalaliN extends RestorableValue<Jalali?> {
  /// Creates a [RestorableJalali].
  ///
  /// {@macro flutter.widgets.RestorableNum.constructor}
  RestorableJalaliN(Jalali? defaultValue) : _defaultValue = defaultValue;

  final Jalali? _defaultValue;

  @override
  Jalali? createDefaultValue() => _defaultValue;

  @override
  void didUpdateValue(Jalali? oldValue) {
    assert(debugIsSerializableForRestoration(value?.millisecondsSinceEpoch));
    notifyListeners();
  }

  @override
  Jalali? fromPrimitives(Object? data) => data != null ? Jalali.fromMillisecondsSinceEpoch(data as int) : null;

  @override
  Object? toPrimitives() => value?.millisecondsSinceEpoch;
}
