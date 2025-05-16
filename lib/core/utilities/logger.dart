import 'package:flutter/widgets.dart';

enum LogLevel { debug, info, warn, error }

/// A simple logging utility for controlling and outputting log messages at different levels.
///
/// The `Logger` class provides a way to log messages with varying levels of severity: debug, info, warn, and error.
/// It also supports including contextual information and stack traces in the log output.
///
/// ## Logging Levels:
/// - `LogLevel.debug`: Detailed information used for debugging.
/// - `LogLevel.info`: General information about the application's execution.
/// - `LogLevel.warn`: Warning messages indicating potential issues or unusual conditions.
/// - `LogLevel.error`: Error messages indicating significant problems that need attention.
///
/// ## Configuration:
/// The logging level can be configured using the `configure` method. Only messages with a log level equal to or higher
/// than the configured level will be outputted.
///
/// ## Methods:
/// - `configure(LogLevel logLevel)`: Configures the minimum log level that will be outputted. Logs with a level lower than
///   this will be ignored.
///
/// - `debug(String message, {BuildContext? context})`: Logs a message at the debug level. Optionally includes the
///   `BuildContext` if provided.
///
/// - `info(String message, {BuildContext? context})`: Logs a message at the info level. Optionally includes the
///   `BuildContext` if provided.
///
/// - `warn(String message, {BuildContext? context})`: Logs a message at the warn level. Optionally includes the
///   `BuildContext` if provided.
///
/// - `error(String message, {BuildContext? context, StackTrace? stackTrace})`: Logs a message at the error level.
///   Optionally includes the `BuildContext` and `StackTrace` if provided.
///
/// ## Example Usage:
/// ```dart
/// void main() {
///   Logger.configure(LogLevel.info); // Configure logging to only show info and higher levels
///   Logger.debug('This is a debug message'); // This will not be logged
///   Logger.info('This is an info message'); // This will be logged
///   Logger.warn('This is a warning message'); // This will be logged
///   Logger.error('This is an error message'); // This will be logged
/// }
/// ```
///
/// The example shows how to configure the logger to output messages at the info level and higher,
/// and demonstrates how different log levels are handled.
class Logger {
  static LogLevel _logLevel = LogLevel.debug;

  // Configure the log level at setup
  static void configure(LogLevel logLevel) {
    _logLevel = logLevel;
  }

  static void _log(LogLevel level, String message,
      {BuildContext? context, StackTrace? stackTrace}) {
    if (level.index >= _logLevel.index) {
      final contextInfo = context != null ? ' [${context.toString()}]' : '';
      final stackTraceInfo = stackTrace != null ? '\n$stackTrace' : '';

      final now = DateTime.now();
      debugPrint(
          '${now.toIso8601String()}|$level|$contextInfo|$message$stackTraceInfo');
    }
  }

  static void debug(String message, {BuildContext? context}) =>
      _log(LogLevel.debug, message, context: context);
  static void info(String message, {BuildContext? context}) =>
      _log(LogLevel.info, message, context: context);
  static void warn(String message, {BuildContext? context}) =>
      _log(LogLevel.warn, message, context: context);
  static void error(String message,
          {BuildContext? context, StackTrace? stackTrace}) =>
      _log(LogLevel.error, message, context: context, stackTrace: stackTrace);
}
