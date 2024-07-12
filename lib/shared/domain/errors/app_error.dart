import 'package:flutter/foundation.dart';

abstract class AppError implements Exception {
  /// Error StackTrace
  ///
  ///   i.e. the current StackTrace if the error is thrown in a catch block
  // StackTrace? get stackTrace;
  final StackTrace? stackTrace;

  /// Error message
  final String message;

  /// Original error object
  ///
  ///   i.e. if an [AppError] is thrown in a catch block, the error caught is passed through this object
  final Object? error;

  AppError({
    this.stackTrace,
    required this.message,
    this.error,
  }) {
    if (error != null) {
      debugPrint(error.toString());
    }
    if (stackTrace != null) {
      debugPrintStack(stackTrace: stackTrace);
    }
  }
}
