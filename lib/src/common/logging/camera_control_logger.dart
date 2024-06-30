import 'log_level.dart';
import 'logger_channel.dart';

abstract class CameraControlLogger {
  const CameraControlLogger();

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
