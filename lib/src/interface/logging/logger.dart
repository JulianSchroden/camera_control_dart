import 'camera_control_logger.dart';

abstract class Logger {
  void log<C extends LoggerChannel>(
    LogLevel level,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]);

  void info<C extends LoggerChannel>(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]);

  void warning<C extends LoggerChannel>(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]);
}
