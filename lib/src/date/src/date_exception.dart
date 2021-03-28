// Copyright 2018 - 2021, Amirreza Madani. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library date_exception;

/// date exception
///
/// this can happen by creating invalid dates or going out of computable range
///
/// super class of all date exceptions
abstract class DateException implements Exception {
  /// Create a [DateException] with message
  factory DateException(String message) {
    return _DateExceptionImpl(message);
  }
}

/// implementation of [DateException] with message
class _DateExceptionImpl implements DateException {
  /// message
  final String message;

  /// Create a [DateException] with message
  _DateExceptionImpl(this.message);

  /// exception description
  @override
  String toString() {
    return 'DateException: $message';
  }
}
